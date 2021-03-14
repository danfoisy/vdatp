EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 4 110
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L power:GND #PWR0402
U 1 1 5CF19F7E
P 5150 4900
F 0 "#PWR0402" H 5150 4650 50  0001 C CNN
F 1 "GND" H 5155 4727 50  0000 C CNN
F 2 "" H 5150 4900 50  0001 C CNN
F 3 "" H 5150 4900 50  0001 C CNN
	1    5150 4900
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0401
U 1 1 5CF1A6B0
P 5050 2300
F 0 "#PWR0401" H 5050 2150 50  0001 C CNN
F 1 "+5V" H 5065 2473 50  0000 C CNN
F 2 "" H 5050 2300 50  0001 C CNN
F 3 "" H 5050 2300 50  0001 C CNN
	1    5050 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	5150 2300 5050 2300
Connection ~ 5150 4900
Connection ~ 5450 4900
Wire Wire Line
	5450 4900 5550 4900
Wire Wire Line
	5350 4900 5450 4900
Connection ~ 5350 4900
Connection ~ 5250 4900
Wire Wire Line
	5250 4900 5350 4900
Wire Wire Line
	5150 4900 5250 4900
Wire Wire Line
	5050 4900 5150 4900
Connection ~ 5050 4900
Connection ~ 4950 4900
Wire Wire Line
	4950 4900 5050 4900
Wire Wire Line
	4850 4900 4950 4900
Connection ~ 5050 2300
Wire Wire Line
	6050 4100 6350 4100
Wire Wire Line
	6050 4000 6350 4000
Wire Wire Line
	6050 3900 6350 3900
Wire Wire Line
	6050 3800 6350 3800
$Comp
L Connector:Raspberry_Pi_2_3 SBC401
U 1 1 5CF18AA9
P 5250 3600
F 0 "SBC401" H 5650 5050 50  0000 C CNN
F 1 "Raspberry_Pi_2_3" H 5950 4950 50  0000 C CNN
F 2 "Module:Raspberry_Pi_Zero_Socketed_THT_MountingHoles_SMT" H 5250 3600 50  0001 C CNN
F 3 "https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_3bplus_1p0_reduced.pdf" H 5250 3600 50  0001 C CNN
	1    5250 3600
	1    0    0    -1  
$EndComp
Text HLabel 6350 3800 2    50   Output ~ 0
nCE0
Text HLabel 6350 3900 2    50   Input ~ 0
miso
Text HLabel 6350 4000 2    50   Output ~ 0
mosi
Text HLabel 6350 4100 2    50   Output ~ 0
sclk
NoConn ~ 5450 2300
NoConn ~ 5350 2300
NoConn ~ 4450 2700
NoConn ~ 4450 2800
NoConn ~ 4450 3000
NoConn ~ 4450 3100
NoConn ~ 4450 3200
NoConn ~ 4450 3500
NoConn ~ 4450 3600
NoConn ~ 4450 3400
NoConn ~ 4450 3800
NoConn ~ 4450 3900
NoConn ~ 4450 4000
NoConn ~ 4450 4100
NoConn ~ 4450 4200
NoConn ~ 4450 4300
NoConn ~ 6050 2700
NoConn ~ 6050 2800
NoConn ~ 6050 3000
NoConn ~ 6050 3100
NoConn ~ 6050 3300
NoConn ~ 6050 3400
NoConn ~ 6050 3500
NoConn ~ 6050 3700
NoConn ~ 6050 4300
NoConn ~ 6050 4400
$EndSCHEMATC
