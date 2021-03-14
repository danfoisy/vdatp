#ifndef TRANSDUCER_H
#define TRANSDUCER_H

#include "vector3d.h"

class Transducer
{
public:
#ifdef __NVCC__
    __device__
#endif
    Transducer(){}

#ifdef __NVCC__
    __device__
#endif
    Transducer(Vector3D _pt, float _normal, float _phase) :
        pt(_pt),
        normal(_normal),
        phase(_phase)
    { }
    Vector3D pt;
    float normal;
    float phase;
    float focusedPhase;

    bool isOnTop;
};

#endif // TRANSDUCER_H
