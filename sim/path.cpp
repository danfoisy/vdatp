#include "path.h"
#include <QDebug>
#include <cmath>
#include "simpoints.h"

void Path::moveTo(float xpos, float ypos, float zpos)
{
    wayPoints.append(WayPoint(xpos, ypos, zpos, Qt::black));
}

void Path::lineTo(float xpos, float ypos, float zpos, QColor col)
{
    wayPoints.append(WayPoint(xpos, ypos, zpos, col));
}

const float MAX_VELOCITY = 2;   //mm/period
//const float maxA = 1;   //mm2/period

void Path::calculateMotion()
{
    QVector3D q=wayPoints[0].pt;
    QVector3D v={0,0,0};

    for(int i=0; i<wayPoints.size(); i++){
      QVector3D q0=q;
      QVector3D v0=v;

      QVector3D q1;
      if(i<wayPoints.size()-1)
        q1= wayPoints[i+1].pt;
      else
        q1= wayPoints[1].pt;

      QVector3D v1;
      const float t= 0.0;
      if(i<wayPoints.size()-2)
        v1=(wayPoints[i+2].pt - wayPoints[i+1].pt)*t;
      else if(i<wayPoints.size()-1)
          v1=(wayPoints[1].pt - wayPoints[i+1].pt)*t;
      else
          v1=(wayPoints[2].pt - wayPoints[1].pt)*t;

      QVector3D a= 2*q0 - 2*q1 + v0 + v1;
      QVector3D b= -v1 -2*v0 - 3*(q0 -q1);
      QVector3D c= v0;
      QVector3D d= q0;

      QVector3D maxV = -b*b/3/a+c;
      float max = fmaxf(fabsf(maxV.x()), fmaxf(fabsf(maxV.y()), fabsf(maxV.z())));
      int time = max / MAX_VELOCITY + 0.5;

      for(float t = 0; t < time; t++) {
          QVector3D pt= a*pow(t/time,3) + b*pow(t/time,2) + c*t/time + d;
          pathPoints.push_back(PathPoint(pt + QVector3D(0, SimPoints::SimExtentsY/2,0), wayPoints[i].color));

      }

      q = q1;
      v= v1;
    }
}




