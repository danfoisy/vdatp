#include "axis.h"
#include <QOpenGLVersionFunctionsFactory>
#include <QOpenGLFunctions_4_5_Core>
#include <QOpenGLExtraFunctions>

const float axisVertices[] = {
    -1.0f, 0.0f, 0.0f,      1.0f, 0.0f, 0.0f,
    1.0f, 0.0f, 0.0f,       1.0f, 0.0f, 0.0f,
    0.0f, 0.0f, 0.0f,       0.0f, 1.0f, 0.0f,
    0.0f, 1.0f, 0.0f,       0.0f, 1.0f, 0.0f,
    0.0f, 0.0f, -1.0f,      0.0f, 0.0f, 1.0f,
    0.0f, 0.0f, 1.0f,       0.0f, 0.0f, 1.0f
};


void Axis::initializeGL()
{
    QOpenGLFunctions *f = QOpenGLContext::currentContext()->functions();

    delete m_program;
    m_program = new QOpenGLShaderProgram;
    m_program->addShaderFromSourceFile(QOpenGLShader::Vertex, "../axis.vert");
    m_program->addShaderFromSourceFile(QOpenGLShader::Fragment, "../axis.frag");
    m_program->link();

    m_projMatrixLoc = m_program->uniformLocation("projMatrix");
    m_camMatrixLoc = m_program->uniformLocation("camMatrix");

    delete m_vao;
    m_vao = new QOpenGLVertexArrayObject;
    if (m_vao->create())
        m_vao->bind();

    m_program->bind();

    delete m_vbo;
    m_vbo = new QOpenGLBuffer;
    m_vbo->create();
    m_vbo->bind();
    m_vbo->allocate(axisVertices, sizeof(axisVertices));
    f->glEnableVertexAttribArray(0);
    f->glEnableVertexAttribArray(1);
    f->glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), nullptr);
    f->glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (void*)(3* sizeof(float)));
    m_vbo->release();

    f->glEnable(GL_DEPTH_TEST);
    //f->glEnable(GL_CULL_FACE);
}

void Axis::paintGL(QMatrix4x4 &camera, QMatrix4x4 &projection)
{
    QOpenGLExtraFunctions *f = QOpenGLContext::currentContext()->extraFunctions();

    m_program->bind();
    m_vao->bind();
    m_program->setUniformValue(m_projMatrixLoc, projection);
    m_program->setUniformValue(m_camMatrixLoc, camera);

    f->glDrawArrays(GL_LINES, 0, 6);

    m_vao->release();
    m_program->release();
}
