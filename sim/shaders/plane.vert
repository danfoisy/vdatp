#version 450 core

layout (location = 0) in vec3 aPos;
uniform mat4 projMatrix;
uniform mat4 camMatrix;
uniform vec3 planePos;
out vec4 vertexColor;

void main()
{
    gl_Position = projMatrix * camMatrix * vec4(aPos.x * planePos.x,
						aPos.y * planePos.y,
						aPos.z * planePos.z,
						1.0);

    if(planePos.x<1.0f)
	vertexColor=vec4(1,0,0,0.05);

    if(planePos.y<1.0f)
	vertexColor=vec4(0,1,0,0.05);

    if(planePos.z<1.0f)
	vertexColor=vec4(0,0,1,0.05);
};
