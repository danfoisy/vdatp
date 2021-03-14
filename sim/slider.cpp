#include "slider.h"

Slider::Slider(Qt::Orientation orientation, QWidget *parent) :
    QSlider(orientation, parent)
{
    connect(this, &QSlider::valueChanged, [this](int value){
        emit valueChanged(value, programmaticChange);
        programmaticChange = false;
    });
}


void Slider::setValueProgrammatically(int value)
{
    programmaticChange = true;
    setValue(value);
}
