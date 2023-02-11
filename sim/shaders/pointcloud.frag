#version 450 core

out vec4 FragColor;
in float vertexPower;
uniform sampler2D paletteTexture;

void main()
{
    FragColor =texture(paletteTexture, vec2(vertexPower, 1));
}
