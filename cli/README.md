# CLI

This code runs on a Raspberry Pi and provides a command line interface to the FPGAs.  It sets up SPI0 at 500kHz and waits for the user to enter in commands.  No points for code cleanliness - this was purely for experimentation.

To compile the code:
`gcc -lm cli.c`

To run the code:
`./a.out [board separation distance] [radius]`
where:
```
board separation distance = the distance between the two boards in millimeters
radius = the radius under the ball that has enabled transducers.  This was used to try and reduce the distortions
```

I usually use: `./a.out 135 2000`

The most commonly used commands are as follows:
``` 
h   - moves the focus point to the home coordinates
z,a - increase/decrease Z coordinate
x,s - increase/decrease X coordinate
d,c - increase/decrease Y coordinate
o   - send profile to the FPGA FIFO
=,] - increase/decrease the time scaling factor
1,q - increase/decrease the X rotation angle
2,w - increase/decrease the Y rotation angle
3,e - increase/decrease the Z rotation angle
4,r - increase/decrease the scaling factor
+   - run a fly around animation
```

