#include "simpoints.h"
#include <cmath>
#include <limits>
#include <QDebug>
#include "transducer.h"
#include <iostream>



SimPoints::SimPoints()
{
    float Xnormal = 1.0f/(SimExtentsX/2.0f);
    float Ynormal = 1.0f/SimExtentsY;
    float Znormal = 1.0f/(SimExtentsZ/2.0f);

    normalizingFactor = fminf(Xnormal, fminf(Ynormal, Znormal));

    int numLayers = TopLayerPresent ? 2 : 1;

    for(int layer=0; layer<numLayers; layer++)
    {
        float x = ((float)NumTransducerX-1)/2*TransducerSpacingX;
        float dx = -TransducerSpacingX;
        if(layer==1)
        {
            x= -x;
            dx= -dx;
        }

        for(int xIdx=0; xIdx<NumTransducerX; xIdx++)
        {
            float z = -((float)NumTransducerZ-1)/2*TransducerSpacingZ;
            for(int zIdx=0; zIdx<NumTransducerZ; zIdx++)
            {
                //float x=((float)xIdx-((float)NumTransducerX-1)/2)*TransducerSpacingX;
                //float z=((float)zIdx-((float)NumTransducerZ-1)/2)*TransducerSpacingZ;

                float phase=0;

                
                phase = (float)M_PI;
               

                float y = (layer == 0) ? TransducerUpperYPos : TransducerLowerYPos;
                float normal = (layer == 0) ? -1 : 1;
                transducers.push_back(Transducer( Vector3D(x, y, z), normal, phase));

                qDebug() << transducers.size() - 1 << x << y << z;

                z += TransducerSpacingZ;
            }

            x += dx;
        }
    }

    calcFPGAPoints();
}

void SimPoints::calcFPGAPoints()
{

    QString xStr = "\tlogic [10:0] xTransducer [NUM_CHANNELS*2] = '{\n\t\t";
    //QString yStr = "\tlogic [10:0] yTransducer [NUM_CHANNELS] = '{\n\t\t";
    QString zStr = "\tlogic [10:0] zTransducer [NUM_CHANNELS*2] = '{\n\t\t";
    QString pStr = "\tfloat phaseConstant [NUM_CHANNELS*2] = '{\n\t\t";

    //int numLayers = TopLayerPresent ? 2 : 1;
    for(int layer=0; layer<2; layer++)
    {
        float x = ((float)NumTransducerX-1)/2*TransducerSpacingX;
        float dx = -TransducerSpacingX;
        if(layer==1)
        {
            x= -x;
            dx= -dx;
        }

        for(int xIdx=0; xIdx<NumTransducerX; xIdx++)
        {
            float z = -((float)NumTransducerZ-1)/2*TransducerSpacingZ;
            for(int zIdx=0; zIdx<NumTransducerZ; zIdx++)
            {
                float phase=0;

                

                uint32_t* intPhase = (uint32_t*)&phase;
                char str[15];
                sprintf(str, "32'h%08X", *intPhase);

                //if(layer==0)
                {
                    xStr += QString::number(x*1) + ((zIdx==NumTransducerZ-1 && xIdx==NumTransducerX-1) ? "" : ",\t");
                    zStr += QString::number(z*1) + ((zIdx==NumTransducerZ-1 && xIdx==NumTransducerX-1) ? "" : ",\t");
                }

                pStr += QString(str) + ((zIdx==NumTransducerZ-1 && xIdx==NumTransducerX-1) ? "" : ",\t");

                z += TransducerSpacingZ;

                if(zIdx%10==9 && !(zIdx==NumTransducerZ-1 && xIdx==NumTransducerX-1 && layer == 1)) {
                    //if(layer==0 && !(zIdx==NumTransducerZ-1 && xIdx==NumTransducerX-1))
                    {
                        xStr+="\n\t\t";
                        zStr+="\n\t\t";
                    }
                    pStr+="\n\t\t";
                }
            }

            x += dx;
        }

    }
    xStr+="\n\t};\n\n";
    zStr+="\n\t};\n\n";
    pStr+="\n\t};\n\n";

    std::cout << xStr.toStdString() << zStr.toStdString() << pStr.toStdString();

    char str[100];
    float negWaveK = -WAVE_K/10;
    uint32_t* intWaveK = (uint32_t*)&negWaveK;
    sprintf(str, "\tlocalparam NEG_WAVE_K_DIV10 = 32'h%08X;\n", *intWaveK);
    std::cout << str;

    float scale = MaxPhaseCnt/2.0f/M_PI;
    uint32_t* intScale = (uint32_t*)&scale;
    sprintf(str, "\tlocalparam SCALE_CNST = 32'h%08X;\n", *intScale);
    std::cout << str;

    Vector3D pt(0,100,0);
    for(int t=0; t< (int)transducers.size(); t++){
        Vector3D delta = pt - transducers[t].pt;
        float r= delta.length();
        float focusedPhase = transducers[t].phase - r * WAVE_K;

        char str[100];
        uint32_t* intfocusedPhase = (uint32_t*)&focusedPhase;
        sprintf(str, "%d, %f, %f, %f, %d, %f, %08X\n",
                t,
                transducers[t].phase,
                focusedPhase,
                focusedPhase *MaxPhaseCnt/(2.0*M_PI),
                (int)(-focusedPhase *MaxPhaseCnt/(2.0*M_PI))%MaxPhaseCnt,
                fmodf(-focusedPhase, 2* M_PI)*MaxPhaseCnt/(2*M_PI),
                *intfocusedPhase
            );
        std::cout << str;
    }
}

float SimPoints::normalize(float f)
{
    return f*normalizingFactor;
}

void SimPoints::initializePoints(float *pointsData)
{
    for(float y=0; y<=SimExtentsY; y+=SimInterval)
    {
        for(float z= -SimExtentsZ/2; z<=SimExtentsZ/2; z+=SimInterval)
        {
            for(float x= -SimExtentsX/2; x<=SimExtentsX/2; x+=SimInterval) {
                *pointsData++ = normalize(x);
                *pointsData++ = normalize(y);
                *pointsData++ = normalize(z);
            }
        }
    }
}

void SimPoints::calculatePower(Vector3D pt, float *powerData)
{
    //calculate new phases with focused point

        for(int t=0; t< (int)transducers.size(); t++){
            Vector3D delta = pt - transducers[t].pt;
            float r= delta.length();
            float s= r * WAVE_K;
            float s1 = -s ;
            if(t>=(int)transducers.size()/2)
                s1+=M_PI;
            transducers[t].focusedPhase = fmodf(s1, 2*M_PI) + 2*M_PI;
qDebug() << t << r<< s <<s1 << transducers[t].focusedPhase;
        }
    

    if(!UseCuda)
        simCPU(powerData);
    else
        simGPU(powerData);
}

void SimPoints::simCPU(float *powerData)
{
    std::vector<float> yValues(TotalPoints, 0);
    float min=std::numeric_limits<float>::max();
    float max=std::numeric_limits<float>::min();

    for(int yIdx=0; yIdx<NumSimPointsY; yIdx++)
    {
        for(int zIdx= 0; zIdx<NumSimPointsZ; zIdx++)
        {
            for(int xIdx= 0; xIdx<NumSimPointsX; xIdx++)
            {
                int idx = yIdx*NumSimPointsZ*NumSimPointsX + zIdx*NumSimPointsX + xIdx;
                Vector3D simPt(
                            xIdx*SimInterval-(SimExtentsX-1)/2,
                            yIdx*SimInterval,
                            zIdx*SimInterval-(SimExtentsZ-1)/2
                        );
                float reAcc=0;
                float imAcc=0;
                for(int t=0; t< (int)transducers.size(); t++){
                    Vector3D delta = simPt - transducers[t].pt;
                    float r = delta.length();
                    float theta = acos(delta.y*transducers[t].normal / r);
                    float phi = transducers[t].focusedPhase;

                    float T2=2*_j1(WAVE_K*TransducerDiameter/2*sinf(theta)) / (WAVE_K*TransducerDiameter/2*sinf(theta));
                    float re = P0 * T2 / r * cosf(phi+WAVE_K*r);
                    float im = P0 * T2 / r * sinf(phi+WAVE_K*r);

                    reAcc += re;
                    imAcc += im;
                }

                float mag = sqrtf(reAcc*reAcc + imAcc*imAcc);
                yValues[idx]=mag;
                if(mag>max)
                    max=mag;
                else if(mag<min)
                    min=mag;
            }
        }
    }

    int idx = 0;
    for(int yIdx=0; yIdx<NumSimPointsY; yIdx++)
    {
        for(int zIdx= 0; zIdx<NumSimPointsZ; zIdx++)
        {
            for(int xIdx= 0; xIdx<NumSimPointsX; xIdx++)
            {
                //powerData[idx] = yValues[idx].first / max; //(yValues[idx].first-min)/scale;
                powerData[idx] = yValues[idx] / max; //(yValues[idx].first-min)/scale;
                idx++;
            }
        }
    }
}

extern "C" void cudaCalc(float *values, Transducer *transducers);

void SimPoints::simGPU(float *powerData)
{
    float *values = (float*)malloc(NumSimPointsX * NumSimPointsZ * NumSimPointsY * sizeof(float));
    cudaCalc(values, transducers.data());

    int idx = 0;
    float max=std::numeric_limits<float>::min();

    for(int yIdx=0; yIdx<NumSimPointsY; yIdx++)
    {
        for(int zIdx= 0; zIdx<NumSimPointsZ; zIdx++)
        {
            for(int xIdx= 0; xIdx<NumSimPointsX; xIdx++)
            {
                if(values[idx]>max)
                    max=values[idx];
                idx++;
            }
        }
    }

    idx=0;
    for(int yIdx=0; yIdx<NumSimPointsY; yIdx++)
    {
        for(int zIdx= 0; zIdx<NumSimPointsZ; zIdx++)
        {
            for(int xIdx= 0; xIdx<NumSimPointsX; xIdx++)
            {
                powerData[idx] = values[idx] / max;
                idx++;
            }
        }
    }

    free(values);


}


        void SimPoints::calculatePhase(Vector3D pt)
        {
            static constexpr float WAVE_C       = 343000;                // speed of sound mm/s
            static constexpr float PIEZO_FREQ   = 40000;                 // Hz
            static constexpr float WAVE_K = 2.0f*M_PI*PIEZO_FREQ/WAVE_C; // rad/mm

            for(int t=0; t<(int)transducers.size(); t++){
                Vector3D delta = pt - transducers[t].pt;
                float r= delta.length();
                float s= r * -WAVE_K;
                if(transducers[t].isOnTop)
                    s+=M_PI;
                transducers[t].focusedPhase = fmodf(s, 2*M_PI) + 2*M_PI;
            }
        }



