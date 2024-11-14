#include "pathdisplay.h"
#include <QOpenGLExtraFunctions>
#include "path.h"
#include "simpoints.h"





void PathDisplay::initializeGL(Path *path, SimPoints &simPoints)
{
    QOpenGLFunctions *f = QOpenGLContext::currentContext()->functions();

    delete m_program;
    m_program = new QOpenGLShaderProgram;
    m_program->addShaderFromSourceFile(QOpenGLShader::Vertex, "../../Shaders/path.vert");
    m_program->addShaderFromSourceFile(QOpenGLShader::Fragment, "../../Shaders/path.frag");
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
    m_vbo->setUsagePattern(QOpenGLBuffer::DynamicDraw);
    m_vbo->allocate(3000 * sizeof(GLfloat) * 6);

    float *buffer = (float*)m_vbo->map(QOpenGLBuffer::WriteOnly);
    numPoints=path->pathPoints.size();

    for(int i=0;i<numPoints;i++)
    {
        *buffer++ = simPoints.normalize(path->pathPoints[i].position.x());
        *buffer++ = simPoints.normalize(path->pathPoints[i].position.y());
        *buffer++ = simPoints.normalize(path->pathPoints[i].position.z());

        *buffer++ = path->pathPoints[i].color.redF();
        *buffer++ = path->pathPoints[i].color.greenF();
        *buffer++ = path->pathPoints[i].color.blueF();
    }
    m_vbo->unmap();

    f->glEnableVertexAttribArray(0);
    f->glEnableVertexAttribArray(1);
    f->glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), nullptr);
    f->glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (void*)(3* sizeof(float)));
    m_vbo->release();

    f->glEnable(GL_DEPTH_TEST);
    //f->glEnable(GL_CULL_FACE);
}

void PathDisplay::paintGL(QMatrix4x4 &camera, QMatrix4x4 &projection, QVector3D &slices)
{
    Q_UNUSED(slices)

    QOpenGLExtraFunctions *f = QOpenGLContext::currentContext()->extraFunctions();

    m_program->bind();
    m_vao->bind();
    m_program->setUniformValue(m_projMatrixLoc, projection);
    m_program->setUniformValue(m_camMatrixLoc, camera);

    //f->glDrawArrays(GL_LINE_STRIP, 0, numPoints);
    f->glDrawArrays(GL_POINTS, 0, numPoints);

    m_vao->release();
    m_program->release();
}


void PathDisplay::setPath(Path *path, SimPoints &simPoints)
{
    numPoints=path->pathPoints.size();

    float *buffer = (float*)malloc(numPoints * 6);
    for(int i=0;i<numPoints;i++)
    {
        *buffer++ = simPoints.normalize(path->pathPoints[i].position.x());
        *buffer++ = simPoints.normalize(path->pathPoints[i].position.y());
        *buffer++ = simPoints.normalize(path->pathPoints[i].position.z());

        *buffer++ = path->pathPoints[i].color.redF();
        *buffer++ = path->pathPoints[i].color.greenF();
        *buffer++ = path->pathPoints[i].color.blueF();
    }

m_vao->bind();
    m_vbo->bind();
    float *data = (float*)m_vbo->map(QOpenGLBuffer::WriteOnly);
    memcpy(data, buffer, numPoints * 6);
    //m_vbo->write(0, buffer, numPoints*6);
    m_vbo->unmap();
    m_vbo->release();
    m_vao->release();

    free(buffer);
}
