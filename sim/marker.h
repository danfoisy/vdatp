#ifndef MARKER_H
#define MARKER_H

#include <QOpenGLWidget>
#include <QOpenGLFunctions>
#include <QOpenGLVertexArrayObject>
#include <QOpenGLBuffer>
#include <QMatrix4x4>
#include <QObject>
#include <QOpenGLShaderProgram>
#include <QOpenGLShader>
#include <QOpenGLTexture>
#include <QVector3D>
#include "simpoints.h"

class Marker
{
public:
    Marker(SimPoints* _simPoints) :
        m_simPoints(_simPoints)
    {}
    void initializeGL();
    void paintGL(QMatrix4x4 &camera, QMatrix4x4 &projection);
    void setPos(QVector3D _pos);
private:
    QOpenGLShaderProgram *m_program = nullptr;
    int m_projMatrixLoc = 0;
    int m_camMatrixLoc = 0;
    int m_posLoc = 0;
    QOpenGLBuffer *m_vbo = nullptr;
    QOpenGLVertexArrayObject *m_vao = nullptr;

    QVector3D pos={0,0,0};

    SimPoints* m_simPoints;
};

#endif // MARKER_H
