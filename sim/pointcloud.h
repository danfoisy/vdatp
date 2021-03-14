#ifndef POINTCLOUD_H
#define POINTCLOUD_H

#include <QOpenGLWidget>
#include <QOpenGLFunctions>
#include <QOpenGLVertexArrayObject>
#include <QOpenGLBuffer>
#include <QMatrix4x4>
#include <QObject>
#include <QOpenGLShaderProgram>
#include <QOpenGLShader>
#include <QOpenGLTexture>
#include "simpoints.h"

class PointCloud
{
public:
    PointCloud(SimPoints *simPoints);
    void initializeGL(QString paletteFilename);
    void paintGL(QMatrix4x4 &camera, QMatrix4x4 &projection, QVector3D &slices);
    void sliceEnabled(int _sliceMode);
    void pointSizeChanged(float f);
    void pointMinChanged(float f);
    void pointMaxChanged(float f);

    void calculatePower(Vector3D pt);
private:
    SimPoints *m_simPoints;
    QOpenGLShaderProgram *m_program = nullptr;

    int m_projMatrixLoc = 0;
    int m_camMatrixLoc = 0;
    int m_slicesLoc = 0;
    int m_sliceEnabledLoc = 0;
    int m_pointOptions = 0;
    QOpenGLBuffer *m_vboPoints = nullptr;
    QOpenGLBuffer *m_vboPower = nullptr;
    QOpenGLVertexArrayObject *m_vao = nullptr;
    QOpenGLTexture *m_texture = nullptr;


    QOpenGLShaderProgram *m_programPlanes = nullptr;
    QOpenGLBuffer *m_vboPlanes = nullptr;
    QOpenGLVertexArrayObject *m_vaoPlanes = nullptr;
    int m_projMatrixLocPlanes = 0;
    int m_camMatrixLocPlanes = 0;
    int m_posPlanes = 0;


    int sliceMode = 0;
    float m_ptSize=5;
    float m_ptMin=0;
    float m_ptMax=1;
};

#endif // POINTCLOUD_H
