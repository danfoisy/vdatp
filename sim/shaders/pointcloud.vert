#version 450 core

layout (location = 0) in vec3 aPos;
layout (location = 1) in float power;
uniform mat4 projMatrix;
uniform mat4 camMatrix;
uniform vec3 slices;
uniform int sliceMode;
uniform vec3 pointOptions;
out float vertexPower;

void main()
{
    gl_Position = projMatrix * camMatrix * vec4(aPos.x, aPos.y, aPos.z, 1.0);

    gl_PointSize = 0;

    if(sliceMode == 0)
    {
	if(aPos.x < slices.x || aPos.y < slices.y || aPos.z < slices.z)
	    gl_PointSize = pointOptions.x;

    }
    else if(sliceMode == 1)
	gl_PointSize = abs(aPos.x - slices.x)<0.01 ? pointOptions.x : 0;
    else if(sliceMode == 2)
	gl_PointSize = abs(aPos.y - slices.y)<0.005 ? pointOptions.x : 0;
    else if(sliceMode == 3)
	gl_PointSize = abs(aPos.z - slices.z)<0.01 ? pointOptions.x : 0;

    vertexPower = (power - pointOptions.y) * (pointOptions.z);
    vertexPower = clamp(vertexPower, 0, 1);

    if(vertexPower==0.0)
	gl_PointSize=0;
};

