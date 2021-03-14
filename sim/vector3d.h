#ifndef VECTOR3D_H
#define VECTOR3D_H
#include <cmath>
#ifndef __NVCC__
#include <QVector3D>
#endif
class Vector3D{
public:
    float x;
    float y;
    float z;

#ifdef __NVCC__
    __device__
#endif
    Vector3D() :
        x(0),
        y(0),
        z(0)
    { }

#ifndef __NVCC__
    Vector3D(QVector3D v) :
        x(v.x()),
        y(v.y()),
        z(v.z())
    { }
#endif

#ifdef __NVCC__
    __device__
#endif
    Vector3D(float _x, float _y, float _z) :
        x(_x),
        y(_y),
        z(_z)
    { }

#ifdef __NVCC__
    __device__
#endif
    Vector3D operator - (Vector3D const &v2)
    {
        return Vector3D(x-v2.x, y-v2.y, z-v2.z);
    }

#ifdef __NVCC__
    __device__
#endif
    float length()
    {
        return sqrtf(x*x + y*y + z*z);
    }


};


#endif // VECTOR3D_H
