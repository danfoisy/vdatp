# SIM

This is the simulator code - a bit of a mess quite honestly but I tell myself that this was only for experimentation.  It was built for the last version QT5. You need to have CUDA installed and a CUDA/OpenGL GPU to make this work.

You can rotate the display by clicking and dragging.  The three sliders to the immediate right of the display control the viewing slice and the radio buttons set which slice is being display (or none).  `Pt Sz` changes the point size for each voxel, `Min Val` sets any voxels below the set value invisible and `Max Val` adjusts the overall scaling of the values.

Below the display are controls to animate or move the motion of the focus point.

The controls at the bottom marked `Color`, `Phase/Position` and `test` are used to communicate with the PI over a TCP/IP channel and send commands to move the focus point.