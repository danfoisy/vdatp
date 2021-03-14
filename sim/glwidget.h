#ifndef GLWIDGET_H
#define GLWIDGET_H

#include <QOpenGLWidget>
#include <QOpenGLFunctions>
#include <QOpenGLVertexArrayObject>
#include <QOpenGLBuffer>
#include <QMatrix4x4>
#include <QObject>
#include <QOpenGLShaderProgram>
#include <QOpenGLShader>
#include <QOpenGLTexture>
#include "axis.h"
#include "simpoints.h"
#include "pointcloud.h"
#include "pathdisplay.h"
#include "marker.h"

class Path;
class GLWidget : public QOpenGLWidget, protected QOpenGLFunctions
{
    Q_OBJECT

public:
    GLWidget(QString paletteFilename, QWidget *parent = nullptr);
    ~GLWidget();
    void sliceChanged(float xSlice, float ySlice, float zSlice);
    void setPath(Path &path);
    void sliceEnabled(int _sliceMode);
    void pointSizeChanged(float f);
    void pointMinChanged(float f);
    void pointMaxChanged(float f);
    PointCloud m_pointCloud;
    Marker m_marker;
    SimPoints m_simPoints;

protected:
    void resizeGL(int width, int height) override;
    void paintGL() override;
    void initializeGL() override;

    virtual void mousePressEvent(QMouseEvent *event) override;
    virtual void mouseMoveEvent(QMouseEvent *event) override;
    virtual void wheelEvent(QWheelEvent *event) override;

private:

    QMatrix4x4 m_proj;
    QMatrix4x4 m_world;
    QVector3D m_eye;
    QVector3D m_target = {0, 0.5, 0};

    float eyeDistance = 5.0f;

    QPoint m_lastPos;
    float yaw = 90.0f;
    float pitch = 0.0f;

    void setEyeCoordinates();

    Axis axis;

    PathDisplay m_pathDisplay;


    Path *m_path;
    QVector3D m_slices= {1,1,1};

    QString m_paletteFilename;
};

#endif // GLWIDGET_H
