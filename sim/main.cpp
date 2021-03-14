#include "dialog.h"

#include <QApplication>
#include <QSurfaceFormat>
#include <QDebug>
#include <QOpenGLFunctions>

#define detailSizeX 10
#define detailSizeZ 10
#define detailSizeY 10

extern "C" void cudaCalc(float *values);
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    QSurfaceFormat fmt;
    fmt.setDepthBufferSize(24);

    fmt.setVersion(4, 6);
    fmt.setProfile(QSurfaceFormat::CoreProfile);


    QSurfaceFormat::setDefaultFormat(fmt);

    Dialog w;
    w.show();



    return a.exec();
}
