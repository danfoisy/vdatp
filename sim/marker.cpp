#include "marker.h"

#include <QOpenGLVersionFunctionsFactory>
#include <QOpenGLFunctions_4_5_Core>
#include <QOpenGLExtraFunctions>

const float markerVertices[] = {
    0.0f, 0.0f, 0.0f
};

void Marker::initializeGL()
{
    QOpenGLFunctions *f = QOpenGLContext::currentContext()->functions();

    delete m_program;
    m_program = new QOpenGLShaderProgram;
    m_program->addShaderFromSourceFile(QOpenGLShader::Vertex, "../marker.vert");
    m_program->addShaderFromSourceFile(QOpenGLShader::Geometry, "../markerGeo.vert");
    m_program->addShaderFromSourceFile(QOpenGLShader::Fragment, "../marker.frag");
    m_program->link();

    m_projMatrixLoc = m_program->uniformLocation("projMatrix");
    m_camMatrixLoc = m_program->uniformLocation("camMatrix");
    m_posLoc = m_program->uniformLocation("pos");

    delete m_vao;
    m_vao = new QOpenGLVertexArrayObject;
    if (m_vao->create())
        m_vao->bind();

    m_program->bind();

    delete m_vbo;
    m_vbo = new QOpenGLBuffer;
    m_vbo->create();
    m_vbo->bind();
    m_vbo->allocate(markerVertices, sizeof(markerVertices));
    f->glEnableVertexAttribArray(0);
    f->glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), nullptr);
    m_vbo->release();

    f->glEnable(GL_DEPTH_TEST);
}

void Marker::paintGL(QMatrix4x4 &camera, QMatrix4x4 &projection)
{
    QOpenGLExtraFunctions *f = QOpenGLContext::currentContext()->extraFunctions();

    m_program->bind();
    m_vao->bind();
    m_program->setUniformValue(m_projMatrixLoc, projection);
    m_program->setUniformValue(m_camMatrixLoc, camera);
    m_program->setUniformValue(m_posLoc, pos);
    f->glDrawArrays(GL_POINTS, 0, 1);

    m_vao->release();
    m_program->release();
}

void Marker::setPos(QVector3D _pos)
{
    pos=QVector3D(m_simPoints->normalize(_pos.x()),
                  m_simPoints->normalize(_pos.y()),
                  m_simPoints->normalize(_pos.z()));
}
