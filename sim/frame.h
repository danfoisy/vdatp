#ifndef FRAME_H
#define FRAME_H
#include <QList>
#include <QVector3D>
#include <QColor>

class Movement
{
public:
    Movement(QVector3D _position, QColor _color) :
        position(_position),
        color(_color)
    { }
    QVector3D position;
    QColor color;
};

class FrameActions
{
public:
    FrameActions(float xpos, float ypos, float zpos) :
        pos(xpos, ypos, zpos),
        color(Qt::black)
    {}

    FrameActions(float xpos, float ypos, float zpos, QColor col) :
        pos(xpos, ypos, zpos),
        color(col)
    {  }

    void doAction(QList<Movement> &movements)
    {
        movements.append(Movement(pos, color));
    }

    QVector3D pos;
    QColor color;
};


class Frame : public QList<FrameActions>
{
public:

};

#endif // FRAME_H
