#ifndef TRANSDUCERS_H
#define TRANSDUCERS_H

//#include <QList>
#include <vector>
#include <utility>
#include "vector3d.h"
#include "transducer.h"
#include "math_constants.h"

#ifndef M_PI
#define M_PI 3.14159
#endif

constexpr int32_t ceiling(float num)
{
    return (static_cast<float>(static_cast<int32_t>(num)) == num)
        ? static_cast<int32_t>(num)
        : static_cast<int32_t>(num) + ((num > 0) ? 1 : 0);
}

class SimPoints
{
public:

    SimPoints();
    float normalize(float f);
    void initializePoints(float *pointsData);
    void calculatePower(Vector3D pt, float *powerData);

    enum class TrapType {
        VORTEX,
        TWIN,
        BOTTLE,
        MATD
    };

    static constexpr TrapType trapType = TrapType::MATD;

    static constexpr int NumTransducerX = 10;
    static constexpr int NumTransducerZ = 10;
    static constexpr float TransducerSpacingX = 10;    //mm
    static constexpr float TransducerSpacingZ = 10;    //mm
    static constexpr float TransducerLowerYPos = -2;    //mm
    static constexpr float TransducerUpperYPos = 143;    //mm
    static constexpr float SimExtentsY = 145;    //mm
    static constexpr float SimInterval = 1;    //mm
    static constexpr float  SimExtentsX = 100;   //mm
    static constexpr float  SimExtentsZ = 100;   //mm
    static constexpr int NumSimPointsX = ceiling((SimExtentsX + 1) / SimInterval);
    static constexpr int NumSimPointsZ = ceiling((SimExtentsZ + 1) / SimInterval);
    static constexpr int NumSimPointsY = ceiling((SimExtentsY + 1) / SimInterval);
    static constexpr bool TopLayerPresent = true;
    static constexpr float P0 = 1;
    static constexpr float TransducerDiameter = 7.2;     //mm
    static constexpr float WAVE_C=  343; // m/s
    static constexpr float PIEZO_FREQ = 40000;
    static constexpr float WAVE_K = (float)(2.0f*M_PI*PIEZO_FREQ/(1000.0f*WAVE_C)); //https://en.wikipedia.org/wiki/Wavenumber
    static constexpr float Helicity = 1;
    static constexpr float BottleRadius = 10;
    static constexpr float TwinAngle = 0;
    static constexpr int TotalPoints = NumSimPointsX * NumSimPointsY * NumSimPointsZ;
    static constexpr int NumTransducers = NumTransducerX * NumTransducerZ * (TopLayerPresent ? 2 : 1);
    static constexpr bool UseCuda = true;
    static constexpr int MaxPhaseCnt = 512;
    std::vector<Transducer> transducers;
private:
    float normalizingFactor;

    void simCPU(float *powerData);
    void simGPU(float *powerData);

    void calcFPGAPoints();

    void calculatePhase(Vector3D pt);
};
#endif // TRANSDUCERS_H
