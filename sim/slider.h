#ifndef SLIDER_H
#define SLIDER_H

#include <QSlider>
#include <QObject>

class Slider : public QSlider
{
    Q_OBJECT
public:
    Slider(Qt::Orientation orientation, QWidget *parent = nullptr);
    void setValueProgrammatically(int value);

signals:
    void valueChanged(int value, bool programmaticChange);

private:
    bool programmaticChange = false;
};

#endif // SLIDER_H
