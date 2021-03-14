#include "glwidget.h"
#include <QOpenGLVersionFunctionsFactory>
#include <QOpenGLFunctions_4_5_Core>
#include <QOpenGLExtraFunctions>
#include <QMouseEvent>
#include "path.h"

#define deg2rad(x) (x/180.0*3.14159)

GLWidget::GLWidget(QString paletteFilename, QWidget *parent) :
    QOpenGLWidget(parent),
    m_pointCloud(&m_simPoints),
    m_marker(&m_simPoints),
    m_paletteFilename(paletteFilename)
{
    setEyeCoordinates();
}


GLWidget::~GLWidget()
{

    /*makeCurrent();
    delete m_program;
    delete m_vbo;
    delete m_vao;

    doneCurrent();*/
}

void GLWidget::resizeGL(int width, int height)
{
    m_proj.setToIdentity();
    m_proj.perspective(20.0f, GLfloat(width) / height, 0.01f, 100.0f);
    update();
}

void GLWidget::paintGL()
{
    //glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    //auto f = QOpenGLVersionFunctionsFactory::get<QOpenGLFunctions_4_5_Core>();
    QOpenGLExtraFunctions *f = QOpenGLContext::currentContext()->extraFunctions();

    f->glClearColor(0, 0, 0, 1);
    f->glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    QMatrix4x4 camera;
    camera.lookAt(m_eye, m_target, QVector3D(0, 1, 0));

    axis.paintGL(camera, m_proj);
    m_pathDisplay.paintGL(camera, m_proj, m_slices);
    m_marker.paintGL(camera, m_proj);
    m_pointCloud.paintGL(camera, m_proj, m_slices);

}


void GLWidget::initializeGL()
{
    QOpenGLFunctions *f = QOpenGLContext::currentContext()->functions();

    f->glEnable(GL_DEPTH_TEST);
    //f->glEnable(GL_CULL_FACE);
    f->glEnable(GL_PROGRAM_POINT_SIZE);

    axis.initializeGL();
    m_pointCloud.initializeGL(m_paletteFilename);
    m_pathDisplay.initializeGL(m_path, m_simPoints);
    m_marker.initializeGL();
}


void GLWidget::mousePressEvent(QMouseEvent *event)
{
    m_lastPos = event->pos();
}

void GLWidget::mouseMoveEvent(QMouseEvent *event)
{

    if(event->buttons() & Qt::LeftButton)
    {
        const float sensitivity = 100.1f;
        float dx = (event->position().x() - m_lastPos.x()) / width() * sensitivity;
        float dy = (m_lastPos.y() - event->position().y() ) / height() * sensitivity;

        yaw += dx;
        pitch += dy;

        if(pitch > 89.0f)
            pitch = 89.0f;
        else if(pitch < -89.0f)
            pitch = -89.0f;


        setEyeCoordinates();

        update();
    }

    m_lastPos = event->pos();
}

void GLWidget::setEyeCoordinates()
{
    m_eye.setX( cos(deg2rad(yaw)) * cos(deg2rad(pitch)) * eyeDistance);
    m_eye.setY( sin(deg2rad(pitch)) * eyeDistance);
    m_eye.setZ(sin(deg2rad(yaw)) * cos(deg2rad(pitch)) * eyeDistance);
}

void GLWidget::wheelEvent(QWheelEvent *event)
{
    int numDegrees = event->angleDelta().y() / 8;
    int numSteps = numDegrees / 15;

    eyeDistance -= numSteps * 0.1;

    if(eyeDistance > 10.0)
        eyeDistance = 10.0;
    else if(eyeDistance<1.0)
        eyeDistance = 1.0;

    setEyeCoordinates();

    update();
}

void GLWidget::sliceChanged(float xSlice, float ySlice, float zSlice)
{
    m_slices.setX(xSlice);
    m_slices.setY(ySlice);
    m_slices.setZ(zSlice);

    update();
}


void GLWidget::setPath(Path &path)
{
    m_path = &path;

    //m_pathDisplay.setPath(path, m_simPoints);

    //update();
}


void GLWidget::sliceEnabled(int _sliceMode)
{
    m_pointCloud.sliceEnabled(_sliceMode);

    update();
}

void GLWidget::pointSizeChanged(float f)
{
    m_pointCloud.pointSizeChanged(f);
    update();
}

void GLWidget::pointMinChanged(float f)
{
    m_pointCloud.pointMinChanged(f);
    update();
}

void GLWidget::pointMaxChanged(float f)
{
    m_pointCloud.pointMaxChanged(f);
    update();
}
