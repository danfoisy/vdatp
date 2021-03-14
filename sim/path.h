#ifndef PATH_H
#define PATH_H

#include <QColor>
#include <QVector3D>

#define MAX_NUM_POINTS 3000

class PathPoint
{
public:
    PathPoint(QVector3D _pos, QColor _col) :
        position(_pos),
        color(_col)
    {  }

    void setComponent(int idx, float val)
    {
        position[idx] = val;
    }

    QVector3D position;
    QColor color;
};

class WayPoint
{
public:
    WayPoint(float _x, float _y, float _z, QColor _color) :
        pt(_x, _y, _z),
        color(_color)
    { }
    QVector3D pt;
    QColor color;
    QVector3D velocity;
    float tVelocity;
};

class Path
{
public:


    void moveTo(float xpos, float ypos, float zpos);
    void lineTo(float xpos, float ypos, float zpos, QColor col);
    QList<WayPoint> wayPoints;

    void calculateMotion();

    QVector<PathPoint> pathPoints;
private:
    float x1 = 0.0f;
    float y1 = 0.0f;
    float z1 = 0.0f;

    //void calcLineMotion(float x2, float y2, float z2, QColor col );
    //void addPoint(float xpos, float ypos, float zpos, QColor col);

    //float calcTimeBetweenWaypoints(QVector3D deltaPos);


};

#endif // PATH_H
