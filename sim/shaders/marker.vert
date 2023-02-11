#version 450 core

layout (location = 0) in vec3 aPos;
uniform mat4 projMatrix;
uniform mat4 camMatrix;
uniform vec3 pos;

void main()
{
    gl_Position = projMatrix * camMatrix * vec4(aPos.x + pos.x, aPos.y + pos.y, aPos.z + pos.z, 1.0);
};

