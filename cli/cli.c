#include <unistd.h> 
#include <stdio.h> 
#include <sys/socket.h> 
#include <stdlib.h> 
#include <netinet/in.h> 
#include <string.h> 
#include <getopt.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>
#include <termios.h>
#include <unistd.h>
#include <math.h>


#define BUF_SIZE_BYTES (17)
#define INC 1.0f
#define MOVE_INC 0.1f

#define fabs(x) ((x>0)?x:-x)

static void pabort(const char *s)
{
	perror(s);
	abort();
}

int getch(void) {
    struct termios oldattr, newattr;
    int ch;
    tcgetattr( STDIN_FILENO, &oldattr );
    newattr = oldattr;
    newattr.c_lflag &= ~( ICANON | ECHO );
    tcsetattr( STDIN_FILENO, TCSANOW, &newattr );
    ch = getchar();
    tcsetattr( STDIN_FILENO, TCSANOW, &oldattr );
    return ch;
}

int _kbhit(void)
{
  struct termios oldt, newt;
  int ch;
  int oldf;
 
  tcgetattr(STDIN_FILENO, &oldt);
  newt = oldt;
  newt.c_lflag &= ~(ICANON | ECHO);
  tcsetattr(STDIN_FILENO, TCSANOW, &newt);
  oldf = fcntl(STDIN_FILENO, F_GETFL, 0);
  fcntl(STDIN_FILENO, F_SETFL, oldf | O_NONBLOCK);
 
  ch = getchar();
 
  tcsetattr(STDIN_FILENO, TCSANOW, &oldt);
  fcntl(STDIN_FILENO, F_SETFL, oldf);
 
  if(ch != EOF)
  {
    ungetc(ch, stdin);
    return 1;
  }
 
  return 0;
}

#define FLY_RADIUS 20

#define HOME_X 0
#define HOME_Y 0
#define HOME_Z 0

#define SCALE 10	//mm to 0.1mm units

static const char *device = "/dev/spidev0.0";
static const uint8_t mode = 0;
static const uint8_t bits = 8;
static const uint32_t spiSpeed = 500000;
static const uint16_t delay = 0;
static int spiFD;
int16_t spiTx[(BUF_SIZE_BYTES+1)/2];
int16_t spiRx[(BUF_SIZE_BYTES+1)/2];
float xPos = 0.0f, yPos = HOME_Y, zPos= HOME_Z;
typedef uint32_t bool;
#define true 1
#define false 0

float BoardDistance = 85.22;
const float freq = 40000;
//float speed = 1500;	//mm/s
//float acc = 1.5;		//mm/s^2
float speed = 1250;	//mm/s
float acc = 1.5;	
uint16_t timeFactor =0;

float cenPos[3];
float cenRot[3];
float cenScale[3];

#define D2R(x) (x/180.0*M_PI)

int8_t norm(float x)
{
	return (int8_t)(x * 127);
}

void multiplyMatrix(float* a, float* b, float* r)
{
	float c[16];
	memset(c, 0 , 16 * sizeof(float));
	for (int i = 0; i < 4; ++i) {
      for (int j = 0; j < 4; ++j) {
         for (int k = 0; k < 4; ++k) {
            c[i*4+j] += a[i*4 + k] * b[k*4 + j];
         }
      }
   }

   memcpy(r, c, 16*sizeof(float));
}

void printMatrix(float* a)
{
	for (int i = 0; i < 4; ++i) {
      for (int j = 0; j < 4; ++j) {
		  printf("%f\t", a[i*4+j]);
	  }
	  printf("\n");
	}
}

void transfer(int len)
{
	int ret;

	struct spi_ioc_transfer tr = {
		.tx_buf = (unsigned long)spiTx+1,
		.rx_buf = (unsigned long)spiRx+1,
		.len = len+1,
		.delay_usecs = delay,
		.speed_hz = spiSpeed,
		.bits_per_word = bits,
	};

	ret = ioctl(spiFD, SPI_IOC_MESSAGE(1), &tr);
	if (ret < 1)
		pabort("can't send spi message");

	/*uint8_t *ptr = (uint8_t*)spiTx + 1;
	for(int i=0; i<len+1;i++)
		printf("%.2X, ", *ptr++);

	printf("\n");*/
}

void initSPI()
{
	int ret;

	spiFD = open(device, O_RDWR);
	if (spiFD < 0)
		pabort("can't open device");

	ret = ioctl(spiFD, SPI_IOC_WR_MODE, &mode);
	if (ret == -1)
		pabort("can't set spi mode");

	ret = ioctl(spiFD, SPI_IOC_WR_BITS_PER_WORD, &bits);
	if (ret == -1)
		pabort("can't set bits per word");

	ret = ioctl(spiFD, SPI_IOC_WR_MAX_SPEED_HZ, &spiSpeed);
	if (ret == -1)
		pabort("can't set max speed hz");


	printf("spi mode: %d\n", mode);
	printf("bits per word: %d\n", bits);
	printf("max speed: %d Hz (%d KHz)\n", spiSpeed, spiSpeed/1000);
}

void closeSPI()
{
	close(spiFD);
}

void printPos()
{
	printf("%.1f, %.1f, %.1f\n", xPos, yPos, zPos);
}

void sendRawMove(uint16_t r0, uint16_t r1, uint16_t r2, uint16_t r3)
{
	spiTx[0]=3<<9;
	spiTx[1]=r0;
	spiTx[2]=r1;
	spiTx[3]=r2;
	spiTx[4]=r3;

	transfer(8);
}

void sendmove(float x, float y, float z)
{
	spiTx[0]=3<<9;
	spiTx[1]=x*SCALE;
	spiTx[2]=y*SCALE;
	spiTx[3]=z*SCALE;
	spiTx[4]=0;
	
	xPos=x;
	yPos=y;
	zPos=z;
	
	//printPos();
	
	transfer(8);
}

void sendmoveCol(float x, float y, float z, float r, float g, float b)
{
	spiTx[0]=3<<9;
	spiTx[1]=x*SCALE;
	spiTx[2]=y*SCALE;
	spiTx[3]=z*SCALE;
	uint8_t red = 3.0f * r; 
	uint8_t green = 7.0f * g;
	uint8_t blue = 3.0f *b;
	spiTx[4]= blue << 5 | green << 2 | red ;
	//printf("%0.2X\n", spiTx[4]);
	xPos=x;
	yPos=y;
	zPos=z;
	
	//printPos();
	
	transfer(8);
}


void pauseFifoProcessing(bool b)
{
	spiTx[0]=7<<9;
	spiTx[1]=!b ? 0xffff : 0x0000;
	spiTx[2]=0;
	spiTx[3]=0;
	spiTx[4]=0;
	
	transfer(8);
}

void move(float x, float y, float z)
{
	pauseFifoProcessing(true);
	sendRawMove(0, 1, 0, 0);
	sendmove(x, y, z);
	pauseFifoProcessing(false);
}

void moveCol(float x, float y, float z, float r, float g, float b)
{
	pauseFifoProcessing(true);
	sendRawMove(0, 1, 0, 0);
	sendmoveCol(x, y, z, r, g, b);
	pauseFifoProcessing(false);
}

void printSpeed()
{
	//printf("%.0f mm/s\n", speed);
	printf("%d\n", speed);
}

void sendMatrix()
{
	int8_t coeff[9];

	float angles[]={D2R(cenRot[0]), D2R(cenRot[1]), D2R(cenRot[2])};

	float Rz[] = {	cosf(angles[2]), 	-sinf(angles[2]), 	0,			0, 
					sinf(angles[2]), 	cosf(angles[2]), 	0, 			0,
					0, 					0, 					1,			0,
					0,					0,					0,			1
				};

	float Ry[] = {	cosf(angles[1]), 	0,					sinf(angles[1]), 		0,			
					0 ,					1,					0,						0,
					-sinf(angles[1]),	0,					cosf(angles[1]),		0,			
					0,					0,					0,						1	
				};

	float Rx[] = {	1 ,					0,					0,					0,
					0,					cosf(angles[0]),	-sinf(angles[0]),	0,
					0,					sinf(angles[0]), 	cosf(angles[0]), 	0,			
					0,					0,					0,					1
				};
	
	float Scale[] = {	cenScale[0],	0,				0,				0,
						0,				cenScale[1],	0,				0,
						0,				0,				cenScale[2],	0,
						0,				0,				0,				1
	};

	float result[16];

	multiplyMatrix(Scale, Rx, result);
	multiplyMatrix(Ry, result, result);
	multiplyMatrix(Rz, result, result);

	coeff[0]=norm(result[0]);
	coeff[1]=norm(result[1]);
	coeff[2]=norm(result[2]);

	coeff[3]=norm(result[4]);
	coeff[4]=norm(result[5]);
	coeff[5]=norm(result[6]);

	coeff[6]=norm(result[8]);
	coeff[7]=norm(result[9]);
	coeff[8]=norm(result[10]);
	
	/* for (int i = 0; i < 3; ++i) {
      for (int j = 0; j < 3; ++j) {
		  printf("%d\t", coeff[i*3+j]);
	  }
	  printf("\n");
	}*/

	spiTx[0]=10<<9;
	spiTx[1]=((uint8_t)coeff[1] << 8) | (uint8_t)coeff[0];
	spiTx[2]=((uint8_t)coeff[3] << 8) | (uint8_t)coeff[2];
	spiTx[3]=((uint8_t)coeff[5] << 8) | (uint8_t)coeff[4];
	spiTx[4]=((uint8_t)coeff[7] << 8) | (uint8_t)coeff[6];
	spiTx[5]=(uint8_t)coeff[8];
	spiTx[6]=cenPos[0]*SCALE;
	spiTx[7]=cenPos[1]*SCALE;
	spiTx[8]=cenPos[2]*SCALE;
	transfer(16);

	usleep(1000);
  
}

int lineTo(int compIdx, float d, float r, float g, float b)
{
	float maxV = speed/freq;
	float maxA = acc/freq;
	
	maxA = d >0 ? maxA : -maxA;
	
	float components[3]={xPos, yPos, zPos};
	
	float v = 0;
	float pos = 0;
	float posStart = components[compIdx];
	
	float accPos =0;
	
	int cnt=0;
	
	bool halfwayReached = false;
	while(1)
	{
		v+=maxA;
		pos+=v;
		components[compIdx] = posStart + pos ;
		
 
		//if(cnt%2)
			sendmoveCol(components[0], components[1], components[2], r, g, b);
		cnt++;
		
		if(fabs(v)>=maxV) 
		{
			v= d >0 ? maxV : -maxV;
			accPos = pos;
			break;
		}
		
		if((d>0 && pos>=d/2) || (d<0 && pos<=d/2))
		{
			//printf("F: %.1f, %.1f, %.1f   %f, %f\n", xPos, yPos, zPos, d, pos);
			halfwayReached = true;
			break;
		}
		//printf("A: %.1f, %.1f, %.1f\n", xPos, yPos, zPos);
	}
	
	if(!halfwayReached)
	{
		if(d>0) {
			for( ; pos<=d-accPos; pos+= v)
			{
				components[compIdx] = posStart + pos ;
			
				//if(cnt%2)
					sendmoveCol(components[0], components[1], components[2], r, g, b);
				//printf("B: %.1f, %.1f, %.1f\n", xPos, yPos, zPos);
				cnt++;
			}
		} else {
			//printf("G: %.1f, %.1f, %.1f   %f, %f, %f, %f\n", xPos, yPos, zPos, d, pos, v, accPos);
			for( ; pos>=d-accPos; pos+= v)
			{
				components[compIdx] = posStart + pos ;
			
				//if(cnt%2)
					sendmoveCol(components[0], components[1], components[2], r, g, b);
				//printf("C: %.1f, %.1f, %.1f\n", xPos, yPos, zPos);
				cnt++;
			}
		}
		
	} 
	
	while(1)
	{
		v-=maxA;
		pos+=v;
		components[compIdx] = posStart + pos ;
		
		//if(cnt%2)
			sendmoveCol(components[0], components[1], components[2], r, g, b);
		//printf("D: %.1f, %.1f, %.1f\n", xPos, yPos, zPos);
		cnt++;
		
		if((d>0 && v<=0) || (d<0 && v>=0)) 
			break;
	}
	
	return cnt;
}

void sendProfile()
{
	pauseFifoProcessing(true);
	int cnt=0;
/*
#define SZ 30
#define NUM 4824
	sendRawMove(NUM+1, NUM, 0, 0);
	cnt+=lineTo(0, -2*SZ, 1, 1, 1);
	cnt+=lineTo(0, 2*SZ, 1, 1, 1);

	sendRawMove(NUM+1, 1, 10000, 0);
	sendmoveCol(SZ,0,0, 1 ,1,1);
*/

#define SZ 20
#define NUM 5840
sendRawMove(0, NUM, 0, 0);
	cnt+=lineTo(2, SZ, 1, 1, 1);
	cnt+=lineTo(1, SZ, 1, 1, 1);
	cnt+=lineTo(2, -SZ, 1, 1, 1);
	cnt+=lineTo(1, -SZ, 1, 1, 1);

/*sendRawMove(0, NUM, 50, 0);
	cnt+=lineTo(2, SZ, 0, 1, 0);
	cnt+=lineTo(1, SZ, 0, 1, 0);
	cnt+=lineTo(2, -SZ, 0, 1, 0);
	cnt+=lineTo(1, -SZ, 0, 1, 0);
*/
/*#define SZ 10
	cnt+=lineTo(2, SZ, 0, 0, 1);
	cnt+=lineTo(1, SZ, 0, 1, 0);
	//cnt+=lineTo(2, -SZ, 0, 0, 1);
	//cnt+=lineTo(1, -SZ, 1, 1, 0);
	cnt+=lineTo(0, SZ, 1,1,0);
	cnt+=lineTo(1, -SZ, 1, 0, 0);
	cnt+=lineTo(2, -SZ, 0, 1, 1);
	cnt+=lineTo(0, -SZ, 1,1,1);
*/
/*	#define SZ 20
	#define LOOP 300
	cnt+=lineTo(2, SZ, 0, 0, 1);
	for(int i=0;i<LOOP;i++)
		sendmoveCol(xPos, yPos, zPos, 1,1,1);
	cnt+=lineTo(1, SZ, 0, 1, 0);
	for(int i=0;i<LOOP;i++)
		sendmoveCol(xPos, yPos, zPos, 1,1,1);
	cnt+=lineTo(1, -SZ, 1, 0, 0);
	for(int i=0;i<LOOP;i++)
		sendmoveCol(xPos, yPos, zPos, 1,1,1);
	cnt+=lineTo(2, -SZ, 0, 1, 1);
	for(int i=0;i<LOOP;i++)
		sendmoveCol(xPos, yPos, zPos, 1,1,1);
	cnt+=LOOP*4;
*/

//circle
/*	#define RADIUS 10
	#define PERIMETER 3500
	sendRawMove(0, PERIMETER, 0, 0);

	float deltaAngle =2*M_PI / PERIMETER;
	float angle = 0.0f;

	float colors[][3] = {
		0,		0,		0.5,
		0,		0.5,	0,
		0.5,	0,		0,
		0,		0,		1,
		0,		1,		0,
		1,		0,		0,
		0,		1,		1,
		1,		0,		1,
		1,		1,		0,
		1,		1,		1,
	};

	for(int i=0;i<PERIMETER;i++)
	{
		float z= RADIUS * cosf(angle) - RADIUS;
		float y= RADIUS * sinf(angle);
		float x=0;

		
		//sendmoveCol(x,y,z, fmod(i, PERIMETER/3), fmod(i, PERIMETER/9), fmod(i, PERIMETER/27));
		sendmoveCol(x,y,z, colors[i/(PERIMETER/10)][0], colors[i/(PERIMETER/10)][1], colors[i/(PERIMETER/10)][2]);
		angle += deltaAngle;
	}
	cnt=PERIMETER;
*/  
//butterfly1
/*	#define RADIUS 3
	#define PERIMETER 1000

	for(int i=0; i<4;i++)
	{
		float wingAngle = D2R(20-20*i);

		if(i<3)
			sendRawMove((2*PERIMETER+1) * (i+1), 2*PERIMETER, 2, 0);
		else
			sendRawMove(0, 2*PERIMETER, 2, 0);
		float deltaAngle =2*M_PI / PERIMETER;
		float angle = 0.0f;
		
		float Ry[] = {	cosf(wingAngle), 	0,					sinf(wingAngle), 		0,			
						0 ,					1,					0,						0,
						-sinf(wingAngle),	0,					cosf(wingAngle),		0,			
						0,					0,					0,						1	
					};

		for(int i=0;i<PERIMETER;i++)
		{
			float z= RADIUS * cosf(angle) - RADIUS;
			float y= RADIUS * sinf(angle);
			float x=0;
		
			float x1 = x*Ry[0] + y*Ry[4] + z*Ry[8];
			float y1 = x*Ry[1] + y*Ry[5] + z*Ry[9];
			float z1 = x*Ry[2] + y*Ry[6] + z*Ry[10];

			sendmoveCol(x1,y1,z1, 1 ,1,1);
			angle += deltaAngle;
		}

		angle = 0.0f;
		for(int i=0;i<PERIMETER;i++)
		{
			float z= RADIUS * cosf(angle) - RADIUS;
			float y= RADIUS * sinf(angle);
			float x=0;

			float x1 = x*Ry[0] + y*Ry[4] + z*Ry[8];
			float y1 = x*Ry[1] + y*Ry[5] + z*Ry[9];
			float z1 = x*Ry[2] + y*Ry[6] + z*Ry[10];

			sendmoveCol(x1,y1,-z1, 1 ,1,1);

			angle += deltaAngle;
		}

		cnt+=2*PERIMETER;
	}
*/


/*#define SZ 40
	cnt+=lineTo(2, SZ, 0.75, 0.75, 0.75);
	cnt+=lineTo(2, -SZ, 0.75, 0.75, 0.75);
*/
	printf("cnt=%d\n",cnt);
	sendMatrix();
	pauseFifoProcessing(false);
}
 
void sendHalfDistance(float halfDistance)
{
	spiTx[0]=0x04<<9;
	spiTx[1]=halfDistance*SCALE;
	spiTx[2]=0;
	spiTx[3]=0;
	spiTx[4]=0;
	transfer(8);
}

void setTimeFactor(uint16_t factor)
{
	spiTx[0]=0x02<<9;
	spiTx[1]=factor;
	spiTx[2]=0x0;
	spiTx[3]=0x0;
	spiTx[4]=0;
	transfer(8);

	timeFactor = factor;
}

void sendRadius(float radius)
{
	radius *=SCALE;
	uint32_t r= radius * radius;
	spiTx[0]=0x06<<9;
	spiTx[1]=r;
	spiTx[2]=r>>16;
	spiTx[3]=0x0;
	spiTx[4]=0;
	transfer(8);
}




void moveCenter(float x, float y, float z)
{
	cenPos[0]=x;
	cenPos[1]=y;
	cenPos[2]=z;

	sendMatrix();

	printf("Center %.1f, %.1f, %.1f\n", x, y, z);
	usleep(1000);
}

void rotate(float x, float y, float z)
{
	cenRot[0]=x;
	cenRot[1]=y;
	cenRot[2]=z;

	sendMatrix();

	printf("Center rotate %.1f, %.1f, %.1f\n", x, y, z);
	usleep(1000);
}

float randf(float max)
{
	return (float)rand()/(float)RAND_MAX * 2*max - max;
}
void runFlyAround()
{
	const float ds = 0.2;  
	float a=0;
	const float da = ds / FLY_RADIUS;
	cenRot[2] = 65;

	while(!_kbhit())
	{
		cenPos[0]=FLY_RADIUS * cosf(a);
		//cenPos[1]+=v[1];
		cenPos[2]=FLY_RADIUS * sinf(a);

		cenRot[1] = -90 + a*180/M_PI;
		sendMatrix();

		usleep(50000);

		a += da;
		if(a> 2*M_PI)
			a-=2*M_PI;

		printf("%f, %f, %f \n",cenPos[0], cenPos[1], cenPos[2]);
	}
}

int main(int argc, char const *argv[]) 
{ 
	FILE *fp;
	
	float inc;
	float a;
	float Radius;

	float cenX=FLY_RADIUS;
	float cenY=0;
	float cenZ=0;
	float rotX=0;
	float rotY=0;
	float rotZ=0;

	float scale = 1.0f;
	cenScale[0] = scale;
	cenScale[1] = scale;
	cenScale[2] = scale;

    initSPI();
	pauseFifoProcessing(true);
	
	
	sscanf(argv[1],"%f", &BoardDistance);
	sscanf(argv[2],"%f", &Radius);
	
	sendHalfDistance(BoardDistance/2);
	setTimeFactor(2);
	sendRadius(Radius);
	
	printf("listening\n");
	int cnt =0;
	
	bool done = false;
	while(!done)
	{
		int ch = getch();
		
		switch(ch) {
			case 'H':
				pauseFifoProcessing(true);
				sendRawMove(0, 1, 0, 0);
				sendmoveCol(HOME_X, HOME_Y, HOME_Z,1.0f, 1.0f, 1.0f);
				pauseFifoProcessing(false);
				break;
			case 'h':
				move(HOME_X, HOME_Y, HOME_Z);
				cenX=0;//FLY_RADIUS;
				cenY=0;
				cenZ=0;
				cenScale[0] = 1.0f;
				cenScale[1] = 1.0f;
				cenScale[2] = 1.0f;
				cenPos[0] = 0;//FLY_RADIUS;
				cenPos[1] = 0.0f;
				cenPos[2] = 0.0f;
				cenRot[0] = 0.0f;
				cenRot[1] = 0.0f;
				cenRot[2] = 0.0f;
				rotX=0;
				rotY=0;
				rotZ=0;
				sendMatrix();
				printPos();
				break;
			case 'z':
				zPos-=INC;
				printPos();
				moveCol(xPos,yPos,zPos, 1.0f, 1.0f, 1.0f);
				break;
			case 'a':
				zPos+=INC;
				printPos();
				moveCol(xPos,yPos,zPos, 1.0f, 1.0f, 1.0f);
				break;
			case 'x':
				xPos-=INC;
				printPos();
				moveCol(xPos,yPos,zPos, 1.0f, 1.0f, 1.0f);
				break;
			case 's':
				xPos+=INC;
				printPos();
				moveCol(xPos,yPos,zPos, 1.0f, 1.0f, 1.0f);
				break;
			case 'c':
				yPos-=INC;
				printPos();
				moveCol(xPos,yPos,zPos, 1.0f, 1.0f, 1.0f);
				break;
			case 'd':
				yPos+=INC;
				printPos();
				moveCol(xPos,yPos,zPos, 1.0f, 1.0f, 1.0f);
				break;
			case 'o':
				sendProfile();
				break;

			case '0':
				spiTx[0]=0x01<<9;
				spiTx[1]=0x0;
				spiTx[2]=0x0;
				spiTx[3]=0x0;
				spiTx[4]=0;
				transfer(8);
				break;
			case '=':
				if(timeFactor<63)
				{
					timeFactor++;
					setTimeFactor(timeFactor);
					
					printf("Time factor %d\n", timeFactor); 
				}
				break;
			case ']':
				if(timeFactor>0)
				{
					timeFactor--;
					setTimeFactor(timeFactor);
					
					printf("Time factor %d\n", timeFactor);
				}
				break;
			case 'j':
				cenX += MOVE_INC;
				moveCenter(cenX, cenY, cenZ);
				break;
			case 'm':
				cenX -= MOVE_INC;
				moveCenter(cenX, cenY, cenZ);
				break;
			case 'k':
				cenY += MOVE_INC;
				moveCenter(cenX, cenY, cenZ);
				break;
			case ',':
				cenY -= MOVE_INC;
				moveCenter(cenX, cenY, cenZ);
				break;
			case 'l':
				cenZ += MOVE_INC;
				moveCenter(cenX, cenY, cenZ);
				break;
			case '.':
				cenZ -= MOVE_INC;
				moveCenter(cenX, cenY, cenZ);
				break;	
			case '1':
				rotX += 360.0/127.0;
				if(rotX > 180.0f)
					rotX -= 360.09f;
				rotate(rotX, rotY, rotZ);
				break;
			case 'q':
				rotX -= 360.0/127.0;
				if(rotX < -180.0f)
					rotX += 360.09f;
				rotate(rotX, rotY, rotZ);
				break;
			case '2':
				rotY += 360.0/127.0;
				if(rotY > 180.0f)
					rotY -= 360.09f;
				rotate(rotX, rotY, rotZ);
				break;
			case 'w':
				rotY -= 360.0/127.0;
				if(rotY < -180.0f)
					rotY += 360.09f;
				rotate(rotX, rotY, rotZ);
				break;
			case '3':
				rotZ += 360.0/127.0;
				if(rotZ > 180.0f)
					rotZ -= 360.09f;
				rotate(rotX, rotY, rotZ);
				break;
			case 'e':
				rotZ -= 360.0/127.0;
				if(rotZ < -180.0f)
					rotZ += 360.09f;
				rotate(rotX, rotY, rotZ);
				break;
			case '4':
				scale += 0.05f;
				if(scale> 1.0f)
					scale = 1.0f;
				cenScale[0] = scale;
				cenScale[1] = scale;
				cenScale[2] = scale;
				sendMatrix();
				break;
			case 'r':
				scale -= 0.05f;
				if(scale<0.05f)
					scale = 0.05f;
				cenScale[0] = scale;
				cenScale[1] = scale;
				cenScale[2] = scale;
				sendMatrix();
				break;	
			case '5':
				BoardDistance += 0.1;
				sendHalfDistance(BoardDistance/2);
				printf("Distance: %f\n", BoardDistance);
				break;
			case 't':
				BoardDistance -= 0.1;
				sendHalfDistance(BoardDistance/2);
				printf("Distance: %f\n", BoardDistance);
				break;
			case '+':
				runFlyAround();
				break;
		}
		
	}
	
	closeSPI();
    return 0; 
} 
