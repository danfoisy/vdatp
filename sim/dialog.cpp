#include "dialog.h"
#include <QHBoxLayout>
#include <QVBoxLayout>
#include "glwidget.h"
#include <QSlider>
#include <QLabel>
#include "simpoints.h"
#include <QButtonGroup>
#include <QRadioButton>
#include "marker.h"
#include <QPushButton>
#include <QGroupBox>
#include <QLineEdit>
#include <QIntValidator>
#include <QColorDialog>
#include "slider.h"

const QString PaletteFilename = "../../Shaders/BlAqGrYeOrRe_labelbar.500.png";


Dialog::Dialog(QWidget *parent)
    : QDialog(parent)
{
    setMinimumSize(1600,1200);

    glWidget = new GLWidget(PaletteFilename);
    glWidget->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
    QVBoxLayout *glWidgetBox = new QVBoxLayout;

#define DIM 20
    path.lineTo(0,0,1, Qt::yellow);
    path.lineTo(-DIM,-DIM,2, Qt::green);
    path.lineTo(DIM,-DIM,0,Qt::blue);
    path.lineTo(DIM,+DIM,0,Qt::cyan);
    path.lineTo(-DIM,+DIM,0,Qt::blue);

    path.calculateMotion();

    glWidget->setPath(path);

    palette = new QLabel;
    palettePixmap.load(PaletteFilename);
    palette->setPixmap(palettePixmap.scaledToHeight(5));
    //palette->setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);
    glWidgetBox->addWidget(glWidget,1);
    glWidgetBox->addWidget(palette);


    sliderX = new QSlider(Qt::Vertical);
    sliderX->setMinimum(-1000);
    sliderX->setMaximum(1000);
    sliderX->setValue(1000);
    QVBoxLayout *xSliderBox= new QVBoxLayout;
    xSliderBox->addWidget(sliderX);
    xSliderBox->addWidget(new QLabel(" X"));

    connect(sliderX, &QSlider::valueChanged, this, &Dialog::slidersChanged);

    sliderY = new QSlider(Qt::Vertical);
    sliderY->setMinimum(0);
    sliderY->setMaximum(1000);
    sliderY->setValue(1000);
    QVBoxLayout *ySliderBox= new QVBoxLayout;
    ySliderBox->addWidget(sliderY);
    ySliderBox->addWidget(new QLabel(" Y"));
    connect(sliderY, &QSlider::valueChanged, this, &Dialog::slidersChanged);

    sliderZ = new QSlider(Qt::Vertical);
    sliderZ->setMinimum(-1000);
    sliderZ->setMaximum(1000);
    sliderZ->setValue(0);
    QVBoxLayout *zSliderBox= new QVBoxLayout;
    zSliderBox->addWidget(sliderZ);
    zSliderBox->addWidget(new QLabel(" Z"));
    connect(sliderZ, &QSlider::valueChanged, this, &Dialog::slidersChanged);

    QVBoxLayout *slice = new QVBoxLayout;
    slice->addWidget(new QLabel("Slice"));
    sliceNone = new QRadioButton("none");
    sliceNone->setChecked(false);
    connect(sliceNone, &QRadioButton::toggled, [this](){this->glWidget->sliceEnabled(0);});
    sliceX = new QRadioButton("X");
    connect(sliceX, &QRadioButton::toggled, [this](){this->glWidget->sliceEnabled(1);});
    sliceY = new QRadioButton("Y");
    connect(sliceY, &QRadioButton::toggled, [this](){this->glWidget->sliceEnabled(2);});
    sliceZ = new QRadioButton("Z");
    sliceZ->setChecked(true);
    connect(sliceZ, &QRadioButton::toggled, [this](){this->glWidget->sliceEnabled(3);});
    slice->addWidget(sliceNone);
    slice->addWidget(sliceX);
    slice->addWidget(sliceY);
    slice->addWidget(sliceZ);
    slice->addStretch(1);

    QVBoxLayout *pointSizeBox = new QVBoxLayout;
    QSlider *pointSizeSlider = new QSlider(Qt::Vertical);
    pointSizeSlider->setRange(0,100);
    pointSizeSlider->setValue(50);
    connect(pointSizeSlider, &QSlider::valueChanged, [this](int val){this->glWidget->pointSizeChanged((float)val/10.0);});
    pointSizeBox->addWidget(pointSizeSlider);
    pointSizeBox->addWidget(new QLabel("Pt Sz"));

    QVBoxLayout *pointMinBox = new QVBoxLayout;
    QSlider *pointMinSlider = new QSlider(Qt::Vertical);
    pointMinSlider->setRange(0,99);
    pointMinSlider->setValue(0);
    connect(pointMinSlider, &QSlider::valueChanged, [this](int val){this->glWidget->pointMinChanged((float)val/100.0);});
    pointMinBox->addWidget(pointMinSlider);
    pointMinBox->addWidget(new QLabel("Min val"));

    QVBoxLayout *pointMaxBox = new QVBoxLayout;
    QSlider *pointMaxSlider = new QSlider(Qt::Vertical);
    pointMaxSlider->setRange(1,500);
    pointMaxSlider->setValue(100);
    connect(pointMaxSlider, &QSlider::valueChanged, [this](int val){this->glWidget->pointMaxChanged((float)val/100.0);});
    pointMaxBox->addWidget(pointMaxSlider);
    pointMaxBox->addWidget(new QLabel("Max val"));

    QHBoxLayout *pointsDisplayBox = new QHBoxLayout;
    pointsDisplayBox->addLayout(pointSizeBox);
    pointsDisplayBox->addLayout(pointMinBox);
    pointsDisplayBox->addLayout(pointMaxBox);

    QHBoxLayout *hbox = new QHBoxLayout;
    hbox->addItem(glWidgetBox);
    hbox->addItem(xSliderBox);
    hbox->addItem(ySliderBox);
    hbox->addItem(zSliderBox);
    hbox->addItem(slice);
    hbox->addLayout(pointsDisplayBox);


    QHBoxLayout *simBox = new QHBoxLayout;
    simBox->addWidget(new QLabel("Frame"));
    simSlider = new QSlider(Qt::Horizontal);
    simSlider->setRange(0,path.pathPoints.length()-1);
    simSlider->setValue(0);
    connect(simSlider, &QSlider::valueChanged, this, &Dialog::displayFrame);
    simBox->addWidget(simSlider,1);
    QPushButton *play=new QPushButton("Play");
    play->setAutoDefault(false);
    simBox->addWidget(play);
    connect(play, &QPushButton::clicked,[this](){
        simSlider->setValue(0);
        m_playTimer.start(200);
    });



    xPos = new Slider(Qt::Horizontal);
    xPos->setRange(-SimPoints::SimExtentsX/2, SimPoints::SimExtentsX/2);
    connect(xPos, &Slider::valueChanged, [this](int newPosition, bool programmaticChange){
        if(!programmaticChange)
        {
            xPosText->setText(QString::number(newPosition));
            changePositionManual();
        }
    });

    xPosText = new QLineEdit("0");
    xPosText->setMaximumWidth(50);
    xPosText->setValidator(new QIntValidator(-SimPoints::SimExtentsX/2, SimPoints::SimExtentsX/2));
    connect(xPosText, &QLineEdit::returnPressed, [this](){
        bool ok;

        int newPosition = xPosText->text().toInt(&ok);
        if(ok)
        {
            xPos->setValueProgrammatically(newPosition);
            changePositionManual();
        }
    });

    QHBoxLayout *xPosBox = new QHBoxLayout;
    xPosBox->addWidget(new QLabel("X"));
    xPosBox->addWidget(xPos,1);
    xPosBox->addWidget(xPosText);



    yPos = new Slider(Qt::Horizontal);
    yPos->setRange(0, SimPoints::SimExtentsY);
    yPos->setValue(0);
    connect(yPos, &Slider::valueChanged, [this](int newPosition, bool programmaticChange){
        if(!programmaticChange)
        {
            yPosText->setText(QString::number(newPosition));
            changePositionManual();
        }
    });

    yPosText = new QLineEdit(QString::number(yPos->value()));
    yPosText->setMaximumWidth(50);
    yPosText->setValidator(new QIntValidator(0, SimPoints::SimExtentsY));
    connect(yPosText, &QLineEdit::returnPressed, [this](){
        bool ok;

        int newPosition = yPosText->text().toInt(&ok);
        if(ok)
        {
            yPos->setValueProgrammatically(newPosition);
            changePositionManual();
        }
    });

    QHBoxLayout *yPosBox = new QHBoxLayout;
    yPosBox->addWidget(new QLabel("Y"));
    yPosBox->addWidget(yPos,1);
    yPosBox->addWidget(yPosText);




    zPos = new Slider(Qt::Horizontal);
    zPos->setRange(-SimPoints::SimExtentsZ/2, SimPoints::SimExtentsZ/2);
    connect(zPos, &Slider::valueChanged, [this](int newPosition, bool programmaticChange){
        if(!programmaticChange)
        {
            zPosText->setText(QString::number(newPosition));
            changePositionManual();
        }
    });
    zPosText = new QLineEdit("0");
    zPosText->setMaximumWidth(50);
    zPosText->setValidator(new QIntValidator(-SimPoints::SimExtentsZ/2, SimPoints::SimExtentsZ/2));
    connect(zPosText, &QLineEdit::returnPressed, [this](){
        bool ok;

        int newPosition = zPosText->text().toInt(&ok);
        if(ok)
        {
            zPos->setValueProgrammatically(newPosition);
            changePositionManual();
        }
    });

    QHBoxLayout *zPosBox = new QHBoxLayout;
    zPosBox->addWidget(new QLabel("Z"));
    zPosBox->addWidget(zPos,1);
    zPosBox->addWidget(zPosText);



    colorLabel = new QLabel();
    colorLabel->setFixedSize(25,25);
    colorLabel->setFrameStyle(QFrame::WinPanel | QFrame::Sunken);
    colorLabel->setLineWidth(2);
    colorLabel->setAutoFillBackground(true);

    QPushButton *selectColor = new QPushButton("Color");
    QPalette pal = colorLabel->palette();
    pal.setColor(QPalette::Window, Qt::white);
    colorLabel->setPalette(pal);

    connect(selectColor, &QPushButton::clicked, [this](){
        QPalette pal = colorLabel->palette();
        QColor col = QColorDialog::getColor(pal.color(QPalette::Window));

        if(col.isValid()){
            pal.setColor(QPalette::Window, col);
            colorLabel->setPalette(pal);
        }
    });
    selectColor->setAutoDefault(false);

    buttonPhase = new QRadioButton("Phase");
    //buttonPhase->setEnabled(false);
    buttonPhase->setChecked(true);
    buttonPosition = new QRadioButton("Position");
    //buttonPosition->setChecked(true);

    QHBoxLayout *colBox = new QHBoxLayout;
    colBox->addWidget(colorLabel);
    colBox->addWidget(selectColor);
    colBox->addStretch(1);
    colBox->addWidget(buttonPhase);
    colBox->addWidget(buttonPosition);

    QVBoxLayout *manVbox = new QVBoxLayout;
    manVbox->addItem(xPosBox);
    manVbox->addItem(yPosBox);
    manVbox->addItem(zPosBox);
    manVbox->addItem(colBox);


    QGroupBox *manualControls = new QGroupBox("Manual controls");
    manualControls->setLayout(manVbox);

    QVBoxLayout *vbox = new QVBoxLayout;
    vbox->addItem(hbox);
    vbox->addItem(simBox);
    vbox->addWidget(manualControls);

    testButton= new QPushButton("test");
    testButton->setAutoDefault(false);
    connect(testButton, &QPushButton::clicked,[this](){
        testTimer.start(100);
    });

    connect(&testTimer, &QTimer::timeout,[this](){
        float x = xPos->value();
        float y = yPos->value();
        float z = testX;

        qDebug() << testX;

        testX += testIncr;

        if(fabsf(testX)>30)
            testIncr = -testIncr;


        QVector3D pos(x, y, z);

        glWidget->m_pointCloud.calculatePower(pos);
        glWidget->m_marker.setPos(pos);
        glWidget->update();

        QPalette pal = colorLabel->palette();
        QColor col = pal.color(QPalette::Window);

        PathPoint pathPoint(pos, col);

        transmit(pathPoint);
    });

    vbox->addWidget(testButton);

    setLayout(vbox);

    m_playTimer.setSingleShot(true);
    connect(&m_playTimer, &QTimer::timeout, [this](){
        if(simSlider->value()< simSlider->maximum())
        {
            simSlider->setValue(simSlider->value() + 1 );
            m_playTimer.start(50);
        }
    });

    connect(&socket, &QTcpSocket::connected, [this](){socketStateChange(SocketState::Connected);});
    connect(&socket, &QTcpSocket::disconnected, [this](){socketStateChange(SocketState::Disconnected);});
    connect(&socket, &QTcpSocket::errorOccurred, [this](QAbstractSocket::SocketError socketError){
        socketStateChange(SocketState::Error, socketError);
    });
    socketTimer.setSingleShot(true);
    connect(&socketTimer, &QTimer::timeout, [this](){socketStateChange(SocketState::Timeout);});
    tryConnect();


    slidersChanged();
    this->glWidget->sliceEnabled(3);
}

Dialog::~Dialog()
{
}

void Dialog::slidersChanged()
{
    glWidget->sliceChanged((float)sliderX->value()/1000.0,
                             (float)sliderY->value()/1000.0,
                             (float)sliderZ->value()/1000.0);
}

void Dialog::resizeEvent(QResizeEvent *event)
{
    Q_UNUSED(event);
    palette->setPixmap(palettePixmap.scaled(glWidget->width(),10));
}

void Dialog::displayFrame(int frame)
{
    PathPoint pathPoint = path.pathPoints[frame];
    changePositionColor(pathPoint);
}

void Dialog::changePositionColor(PathPoint pathPoint)
{
    xPos->setValueProgrammatically(pathPoint.position.x());
    xPosText->setText(QString::number(pathPoint.position.x()));
    yPos->setValueProgrammatically(pathPoint.position.y());
    yPosText->setText(QString::number(pathPoint.position.y()));
    zPos->setValueProgrammatically(pathPoint.position.z());
    zPosText->setText(QString::number(pathPoint.position.z()));

    glWidget->m_pointCloud.calculatePower(pathPoint.position);
    glWidget->m_marker.setPos(pathPoint.position);
    glWidget->update();

    transmit(pathPoint);
}

void Dialog::changePositionManual()
{
    float x = xPos->value();
    float y = yPos->value();
    float z = zPos->value();

    QVector3D pos(x, y, z);

    glWidget->m_pointCloud.calculatePower(pos);
    glWidget->m_marker.setPos(pos);
    glWidget->update();

    QPalette pal = colorLabel->palette();
    QColor col = pal.color(QPalette::Window);

    PathPoint pathPoint(pos, col);

    transmit(pathPoint);
}

void Dialog::transmit(PathPoint pathPoint)
{
    QByteArray str, str1;
    QByteArray buf="B";
    for(int i=0; i< SimPoints::NumTransducers;i++)
    {
        int idx = i;
        float focusedPhase = glWidget->m_simPoints.transducers[idx].focusedPhase;

        int focusedPhaseInt = (int)(focusedPhase * SimPoints::MaxPhaseCnt/(2*M_PI));
        buf += QByteArray::number(focusedPhaseInt);

        str+= QByteArray::number(focusedPhaseInt);
        str += ",";

        /*Vector3D delta = glWidget->m_simPoints.transducers[idx].pt - pathPoint.position;
        float multKF = - delta.length() * SimPoints::WAVE_K;
        float phaseF = glWidget->m_simPoints.transducers[idx].phase + multKF;
        str1+=  QByteArray::number(phaseF);
        str1+=",";*/
        if(i==49 || i==99)
        {
            qDebug() << str;
            //qDebug() << str1;
            str.clear();
            //str1.clear();
        }
        if(i!=SimPoints::NumTransducers-1)
            buf += ",";
    }

    buf += "\n";

    if(buttonPhase->isChecked())
    {
        if(currentSocketState ==  SocketState::Connected)
            socket.write(buf.data(), buf.size() + 1);
    }
    else
    {
        char buf[1000];
        int len=0;
        len = sprintf(buf,"A%d,%d,%d,%d,%d,%d\n",
                (int)pathPoint.position.x()*10,
                (int)pathPoint.position.y()*10,
                (int)pathPoint.position.z()*10,
                pathPoint.color.red(),
                pathPoint.color.green(),
                pathPoint.color.blue()
            );
        qDebug() << buf;
        if(currentSocketState ==  SocketState::Connected)
            socket.write(buf, len+1);
    }

    qDebug() << "";
}

void Dialog::tryConnect()
{
    socket.connectToHost(ipAddress,port);
    //socketTimer.start(2000);
}

void Dialog::socketStateChange(SocketState nextState, QAbstractSocket::SocketError err)
{
    socketTimer.stop();
//qDebug() << "socket status" << (int)currentSocketState << (int)nextState << err;
    switch(currentSocketState){
    case SocketState::Disconnected:
        switch(nextState) {
        case SocketState::Connected:
            qDebug() << "Connected";
            currentSocketState = SocketState::Connected;
            break;
        case SocketState::Disconnected:
        case SocketState::Error:
            currentSocketState = SocketState::Disconnected;
            socketTimer.start(2000);
            break;
        case SocketState::Timeout:
            currentSocketState = SocketState::Disconnected;
            tryConnect();
            break;

        default:
            qDebug() << "socket error" << (int)currentSocketState << (int)nextState << err;
            break;
        }
        break;
    case SocketState::Connected:
        switch(nextState) {
        case SocketState::Disconnected:
        case SocketState::Error:
            currentSocketState = SocketState::Disconnected;
            socketTimer.start(2000);
            break;
        default:
            qDebug() << "socket error" << (int)currentSocketState << (int)nextState << err;
            break;
        }
        break;
    default:
        qDebug() << "socket error" << (int)currentSocketState << (int)nextState << err;
        break;
    }
}
