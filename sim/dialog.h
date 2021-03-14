#ifndef DIALOG_H
#define DIALOG_H

#include <QDialog>
#include "path.h"
#include <QTimer>
#include "vector3d.h"
#include <QTcpSocket>

class GLWidget;
class QSlider;
class QRadioButton;
class QLabel;
class QLineEdit;
class Slider;

class Dialog : public QDialog
{
    Q_OBJECT

public:
    Dialog(QWidget *parent = nullptr);
    ~Dialog();
protected:

    void resizeEvent(QResizeEvent *event) override;

private:
    enum class SocketState {
        Connected =0 ,
        Disconnected =1,
        Error =2,
        Timeout =3
    };

private slots:
    void displayFrame(int frame);
    void slidersChanged();
    void socketStateChange(SocketState nextState, QAbstractSocket::SocketError err=QAbstractSocket::UnknownSocketError);

private:
    GLWidget *glWidget;

    QSlider *sliderX;
    QSlider *sliderY;
    QSlider *sliderZ;

    QRadioButton *sliceNone;
    QRadioButton *sliceX;
    QRadioButton *sliceY;
    QRadioButton *sliceZ;
    Path path;

    QPixmap palettePixmap;
    QLabel *palette;

    void changePositionColor(PathPoint pathPoint);

    QTimer m_playTimer;
    QSlider *simSlider;

    Slider *xPos;
    Slider *yPos;
    Slider *zPos;

    QLineEdit *xPosText;
    QLineEdit *yPosText;
    QLineEdit *zPosText;

    QLabel *colorLabel;
    QRadioButton *buttonPhase;
    QRadioButton *buttonPosition;

    void changePositionManual();

    void transmit(PathPoint pathPoint);

    QTcpSocket socket;
    const QString ipAddress = "192.168.50.2";
    //const QString ipAddress = "localhost";
    const int port = 3333;
    QTimer socketTimer;
    SocketState currentSocketState = SocketState::Disconnected;

    void tryConnect();

    float testX =0;
    float testIncr = 1;
    QPushButton *testButton;
    QTimer testTimer;
};
#endif // DIALOG_H
