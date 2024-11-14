#include "pointcloud.h"
#include "simpoints.h"
#include <QOpenGLExtraFunctions>

PointCloud::PointCloud(SimPoints *simPoints) :
    m_simPoints(simPoints)
{

}

const float planeVertices[] = {
     1.0f, 1.0f,  1.0f,
     1.0f, 1.0f, -1.0f,
    -1.0f, 1.0f,  1.0f,
     1.0f, 1.0f, -1.0f,
    -1.0f, 1.0f, -1.0f,
    -1.0f, 1.0f,  1.0f,

    1.0f,    1.0f,   1.0f,
    1.0f,    1.0f,  -1.0f,
    1.0f,   -1.0f,   1.0f,
    1.0f,    1.0f,  -1.0f,
    1.0f,   -1.0f,  -1.0f,
    1.0f,   -1.0f,   1.0f,

    1.0f,    1.0f, 1.0f,
    1.0f,   -1.0f, 1.0f,
   -1.0f,    1.0f, 1.0f,
    1.0f,   -1.0f, 1.0f,
   -1.0f,   -1.0f, 1.0f,
   -1.0f,    1.0f, 1.0f
};



void PointCloud::initializeGL(QString paletteFilename)
{
    QOpenGLFunctions *f = QOpenGLContext::currentContext()->functions();

    delete m_program;
    m_program = new QOpenGLShaderProgram;
    m_program->addShaderFromSourceFile(QOpenGLShader::Vertex, "../../Shaders/pointcloud.vert");
    m_program->addShaderFromSourceFile(QOpenGLShader::Fragment, "../../Shaders/pointcloud.frag");
    m_program->link();
    m_program->bind();

    m_projMatrixLoc = m_program->uniformLocation("projMatrix");
    m_camMatrixLoc = m_program->uniformLocation("camMatrix");
    m_slicesLoc = m_program->uniformLocation("slices");
    m_sliceEnabledLoc = m_program->uniformLocation("sliceMode");
    m_pointOptions = m_program->uniformLocation("pointOptions");

    //create points buffer - static
    delete m_vboPoints;
    m_vboPoints = new QOpenGLBuffer;
    m_vboPoints->create();
    m_vboPoints->bind();
    m_vboPoints->setUsagePattern(QOpenGLBuffer::StaticDraw);
    m_vboPoints->allocate(SimPoints::TotalPoints * sizeof(GLfloat)*3);

    float *pointsData = (float*)m_vboPoints->map(QOpenGLBuffer::WriteOnly);
    m_simPoints->initializePoints(pointsData);
    m_vboPoints->unmap();

    //create power buffer - dynamic
    delete m_vboPower;
    m_vboPower = new QOpenGLBuffer;
    m_vboPower->create();
    m_vboPower->bind();
    m_vboPower->setUsagePattern(QOpenGLBuffer::StaticDraw);
    m_vboPower->allocate(SimPoints::TotalPoints * sizeof(GLfloat));

    float *powerData = (float*)m_vboPower->map(QOpenGLBuffer::WriteOnly);
    m_simPoints->calculatePower(Vector3D(0,40,0), powerData);
    m_vboPower->unmap();


    delete m_vao;
    m_vao = new QOpenGLVertexArrayObject;
    m_vao->create();
    m_vao->bind();
    m_vboPoints->bind();
    f->glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), nullptr);
    m_vboPower->bind();
    f->glVertexAttribPointer(1, 1, GL_FLOAT, GL_FALSE, sizeof(GLfloat), nullptr);

    f->glEnableVertexAttribArray(0);
    f->glEnableVertexAttribArray(1);

    f->glEnable(GL_DEPTH_TEST);
    //f->glEnable(GL_CULL_FACE);

    m_texture= new QOpenGLTexture(QImage(paletteFilename));

    m_vao->release();

    //----------------------------------------------------------------------------
    m_programPlanes = new QOpenGLShaderProgram;
    m_programPlanes->addShaderFromSourceFile(QOpenGLShader::Vertex, "../../Shaders/plane.vert");
    m_programPlanes->addShaderFromSourceFile(QOpenGLShader::Fragment, "../../Shaders/plane.frag");
    m_programPlanes->link();
    m_programPlanes->bind();

    m_projMatrixLocPlanes = m_programPlanes->uniformLocation("projMatrix");
    m_camMatrixLocPlanes = m_programPlanes->uniformLocation("camMatrix");
    m_posPlanes = m_programPlanes->uniformLocation("planePos");

    m_vboPlanes = new QOpenGLBuffer;
    m_vboPlanes->create();
    m_vboPlanes->bind();
    m_vboPlanes->setUsagePattern(QOpenGLBuffer::DynamicDraw);
    m_vboPlanes->allocate(planeVertices, sizeof(planeVertices));

    m_vaoPlanes = new QOpenGLVertexArrayObject;
    m_vaoPlanes->create();
    m_vaoPlanes->bind();
    m_vboPlanes->bind();
    f->glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(GLfloat), nullptr);
    f->glEnableVertexAttribArray(0);

    f->glEnable(GL_DEPTH_TEST);
    //f->glDisable(GL_CULL_FACE);
    f->glEnable(GL_BLEND);
    f->glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    m_vaoPlanes->release();

}

void PointCloud::paintGL(QMatrix4x4 &camera, QMatrix4x4 &projection, QVector3D &slices)
{
    QOpenGLExtraFunctions *f = QOpenGLContext::currentContext()->extraFunctions();

    m_program->bind();
    m_vao->bind();
    m_texture->bind();
    m_program->setUniformValue(m_projMatrixLoc, projection);
    m_program->setUniformValue(m_camMatrixLoc, camera);
    m_program->setUniformValue(m_slicesLoc, slices);
    m_program->setUniformValue(m_sliceEnabledLoc, sliceMode);
    m_program->setUniformValue(m_pointOptions, QVector3D(m_ptSize, m_ptMin, m_ptMax));

    f->glDrawArrays(GL_POINTS, 0, SimPoints::TotalPoints);

    m_vao->release();
    m_program->release();


    //---------------------------
    m_programPlanes->bind();
    m_vaoPlanes->bind();
    m_programPlanes->setUniformValue(m_projMatrixLocPlanes, projection);
    m_programPlanes->setUniformValue(m_camMatrixLocPlanes, camera);

    if(slices.y()<1.0f)
    {
        m_programPlanes->setUniformValue(m_posPlanes, QVector3D(1, slices.y(), 1));
        f->glDrawArrays(GL_TRIANGLES, 0, 6);
    }

    if(slices.x()<1.0f)
    {
        m_programPlanes->setUniformValue(m_posPlanes, QVector3D(slices.x(), 1, 1));
        f->glDrawArrays(GL_TRIANGLES, 6, 6);
    }

    if(slices.z()<1.0f)
    {
        m_programPlanes->setUniformValue(m_posPlanes, QVector3D(1, 1, slices.z()));
        f->glDrawArrays(GL_TRIANGLES, 12, 6);
    }

    m_vaoPlanes->release();
    m_programPlanes->release();
}

void PointCloud::sliceEnabled(int _sliceMode)
{
    sliceMode = _sliceMode;
}

void PointCloud::pointSizeChanged(float f)
{
    m_ptSize=f;
}

void PointCloud::pointMinChanged(float f)
{
    m_ptMin=f;
}

void PointCloud::pointMaxChanged(float f)
{
    m_ptMax=f;
}

void PointCloud::calculatePower(Vector3D pt)
{
    m_vboPower->bind();
    float *powerData = (float*)m_vboPower->map(QOpenGLBuffer::WriteOnly);
    m_simPoints->calculatePower(pt, powerData);
    m_vboPower->unmap();
    m_vboPower->release();
}


