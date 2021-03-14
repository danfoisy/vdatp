//********************************************************************************************
//NOTE: to make this work, also need to add D:\CUDA\lib\x64 to LIB env. variable in BUILD config
//********************************************************************************************

#include <chrono>
#include <iostream>
#include "vector3d.h"
#include "simpoints.h"

// helper functions for cleaner time measuring code
std::chrono::time_point<std::chrono::high_resolution_clock> now() {
    return std::chrono::high_resolution_clock::now();
}
template <typename T>
double milliseconds(T t) {
    return (double) std::chrono::duration_cast<std::chrono::nanoseconds>(t).count() / 1000000;
}


//__constant__ Transducer d_transducers[SimPoints::NumTransducers];
__constant__ uint8_t d_transducers[SimPoints::NumTransducers * sizeof(Transducer)];

__global__
void simKernel(cudaPitchedPtr valuesPitch) {
    Transducer *transducers = (Transducer*)d_transducers;

    size_t pitchX = valuesPitch.pitch/sizeof(float);
    float* values = (float*)valuesPitch.ptr;

    int yIdx= threadIdx.x;
    int xIdx= blockIdx.x;
    int zIdx= blockIdx.y;

    int idx = yIdx*SimPoints::NumSimPointsZ*pitchX + zIdx*pitchX + xIdx;

    Vector3D simPt(
                xIdx*SimPoints::SimInterval-(SimPoints::SimExtentsX-1)/2,
                yIdx*SimPoints::SimInterval,
                zIdx*SimPoints::SimInterval-(SimPoints::SimExtentsZ-1)/2
            );

    float reAcc=0;
    float imAcc=0;

    for(int t=0; t< SimPoints::NumTransducers; t++){
        Vector3D delta = simPt - transducers[t].pt;
        float r = delta.length();
        float theta = acos(delta.y*transducers[t].normal / r);
        float phi = transducers[t].focusedPhase;

        float T2=2 * j1f(SimPoints::WAVE_K * SimPoints::TransducerDiameter/2*sinf(theta)) /
                (SimPoints::WAVE_K*SimPoints::TransducerDiameter/2*sinf(theta));
        float re = SimPoints::P0 * T2 / r * cos(phi+SimPoints::WAVE_K*r);
        float im = SimPoints::P0 * T2 / r * sin(phi+SimPoints::WAVE_K*r);

        reAcc += re;
        imAcc += im;
    }
    //reAcc = xIdx ==20 ? 100 : 0;

    float mag = sqrtf(reAcc*reAcc + imAcc*imAcc);
    values[idx]=mag;


}

extern "C"
void cudaCalc(float *values, Transducer *transducers) {

    auto t1 = now();

    cudaExtent extent= make_cudaExtent(SimPoints::NumSimPointsX * sizeof(float), SimPoints::NumSimPointsZ, SimPoints::NumSimPointsY);
    cudaPitchedPtr d_values;
    cudaMalloc3D(&d_values, extent);

    cudaMemcpyToSymbol(d_transducers, transducers, SimPoints::NumTransducers * sizeof(Transducer));

    auto t2 = now();

    dim3 blockSize(SimPoints::NumSimPointsY, 1, 1);
    dim3 numBlocks(SimPoints::NumSimPointsX, SimPoints::NumSimPointsZ, 1);

    simKernel<<<numBlocks, blockSize>>>(d_values);
    cudaDeviceSynchronize();


    auto t3 = now();

    cudaMemcpy3DParms memcpyParms = {0};
    memcpyParms.srcPtr=d_values;
    memcpyParms.dstPtr.ptr=values;
    memcpyParms.dstPtr.pitch=SimPoints::NumSimPointsX *sizeof(float);
    memcpyParms.dstPtr.xsize=SimPoints::NumSimPointsX;
    memcpyParms.dstPtr.ysize=SimPoints::NumSimPointsZ;
    memcpyParms.extent.width=SimPoints::NumSimPointsX * sizeof(float);
    memcpyParms.extent.height=SimPoints::NumSimPointsZ;
    memcpyParms.extent.depth=SimPoints::NumSimPointsY;
    memcpyParms.kind=cudaMemcpyDeviceToHost;

    cudaError_t ret=cudaMemcpy3D(&memcpyParms);


    if(ret!= cudaSuccess)
        std::cout << "error " << cudaGetErrorString(ret) <<"\n";

    cudaFree(d_values.ptr);

    auto t4 = now();

    /*std::cout << "GPU time breakdown--------\n";
    std::cout << "loading into device memory: " << milliseconds(t2 - t1) << " milliseconds\n";
    std::cout << "actual addition:            " << milliseconds(t3 - t2) << " milliseconds\n";
    std::cout << "loading into host memory:   " << milliseconds(t4 - t3) << " milliseconds\n";
*/
    return;
}
