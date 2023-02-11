#version 450 core

in vec3 pathColor;
out vec4 FragColor;

void main()
{
    FragColor = vec4(pathColor, 1.0f);
}
