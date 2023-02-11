#version 450 core

layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;
uniform mat4 projMatrix;
uniform mat4 camMatrix;
out vec3 pathColor;

void main()
{
    gl_Position = projMatrix * camMatrix * vec4(aPos.x, aPos.y, aPos.z, 1.0);
    pathColor = aColor;
    gl_PointSize = 2;
};
