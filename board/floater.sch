EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 110
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
L Oscillator:ASE-xxxMHz X?
U 1 1 5E5895DB
P 1150 1700
AR Path="/5E33BBDC/5E5895DB" Ref="X?"  Part="1" 
AR Path="/5E5895DB" Ref="X101"  Part="1" 
F 0 "X101" H 1200 2000 50  0000 L CNN
F 1 "ASE-24.576MHz" H 1200 1950 50  0000 L CNN
F 2 "holo:ASFL1" H 1850 1350 50  0001 C CNN
F 3 "ASFL1-24.576MHZ-L-T" H 1050 1700 50  0001 C CNN
	1    1150 1700
	1    0    0    -1  
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 5E5895E1
P 1150 1400
AR Path="/5E33BBDC/5E5895E1" Ref="#PWR?"  Part="1" 
AR Path="/5E5895E1" Ref="#PWR0108"  Part="1" 
F 0 "#PWR0108" H 1150 1250 50  0001 C CNN
F 1 "+3V0" H 1165 1573 50  0000 C CNN
F 2 "" H 1150 1400 50  0001 C CNN
F 3 "" H 1150 1400 50  0001 C CNN
	1    1150 1400
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E5895E7
P 1150 2000
AR Path="/5E33BBDC/5E5895E7" Ref="#PWR?"  Part="1" 
AR Path="/5E5895E7" Ref="#PWR0109"  Part="1" 
F 0 "#PWR0109" H 1150 1750 50  0001 C CNN
F 1 "GND" H 1155 1827 50  0000 C CNN
F 2 "" H 1150 2000 50  0001 C CNN
F 3 "" H 1150 2000 50  0001 C CNN
	1    1150 2000
	1    0    0    -1  
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 5E5895ED
P 850 1700
AR Path="/5E33BBDC/5E5895ED" Ref="#PWR?"  Part="1" 
AR Path="/5E5895ED" Ref="#PWR0104"  Part="1" 
F 0 "#PWR0104" H 850 1550 50  0001 C CNN
F 1 "+3V0" H 865 1873 50  0000 C CNN
F 2 "" H 850 1700 50  0001 C CNN
F 3 "" H 850 1700 50  0001 C CNN
	1    850  1700
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1450 1700 1850 1700
$Comp
L Device:C_Small C?
U 1 1 5E5895F4
P 850 1000
AR Path="/5E33BBDC/5E5895F4" Ref="C?"  Part="1" 
AR Path="/5E5895F4" Ref="C101"  Part="1" 
F 0 "C101" H 942 1046 50  0000 L CNN
F 1 "4.7uF" H 942 955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 850 1000 50  0001 C CNN
F 3 "1276-1044-1-ND" H 850 1000 50  0001 C CNN
	1    850  1000
	1    0    0    -1  
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 5E5895FA
P 850 900
AR Path="/5E33BBDC/5E5895FA" Ref="#PWR?"  Part="1" 
AR Path="/5E5895FA" Ref="#PWR0102"  Part="1" 
F 0 "#PWR0102" H 850 750 50  0001 C CNN
F 1 "+3V0" H 865 1073 50  0000 C CNN
F 2 "" H 850 900 50  0001 C CNN
F 3 "" H 850 900 50  0001 C CNN
	1    850  900 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E589600
P 850 1100
AR Path="/5E33BBDC/5E589600" Ref="#PWR?"  Part="1" 
AR Path="/5E589600" Ref="#PWR0103"  Part="1" 
F 0 "#PWR0103" H 850 850 50  0001 C CNN
F 1 "GND" H 855 927 50  0000 C CNN
F 2 "" H 850 1100 50  0001 C CNN
F 3 "" H 850 1100 50  0001 C CNN
	1    850  1100
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x05_Odd_Even J?
U 1 1 5E5ABA97
P 1600 3150
AR Path="/5E33BBDC/5E5ABA97" Ref="J?"  Part="1" 
AR Path="/5E5ABA97" Ref="J101"  Part="1" 
F 0 "J101" H 1650 3567 50  0000 C CNN
F 1 "JTAG" H 1650 3476 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x05_P2.54mm_Vertical_Shrouded" H 1600 3150 50  0001 C CNN
F 3 "732-2094-ND" H 1600 3150 50  0001 C CNN
	1    1600 3150
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E5ABA9D
P 900 2950
AR Path="/5E33BBDC/5E5ABA9D" Ref="#PWR?"  Part="1" 
AR Path="/5E5ABA9D" Ref="#PWR0105"  Part="1" 
F 0 "#PWR0105" H 900 2700 50  0001 C CNN
F 1 "GND" V 905 2822 50  0000 R CNN
F 2 "" H 900 2950 50  0001 C CNN
F 3 "" H 900 2950 50  0001 C CNN
	1    900  2950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E5ABAA3
P 900 3350
AR Path="/5E33BBDC/5E5ABAA3" Ref="#PWR?"  Part="1" 
AR Path="/5E5ABAA3" Ref="#PWR0107"  Part="1" 
F 0 "#PWR0107" H 900 3100 50  0001 C CNN
F 1 "GND" V 905 3222 50  0000 R CNN
F 2 "" H 900 3350 50  0001 C CNN
F 3 "" H 900 3350 50  0001 C CNN
	1    900  3350
	0    1    1    0   
$EndComp
$Comp
L power:+2V5 #PWR?
U 1 1 5E5ABAA9
P 900 3250
AR Path="/5E33BBDC/5E5ABAA9" Ref="#PWR?"  Part="1" 
AR Path="/5E5ABAA9" Ref="#PWR0106"  Part="1" 
F 0 "#PWR0106" H 900 3100 50  0001 C CNN
F 1 "+2V5" V 915 3378 50  0000 L CNN
F 2 "" H 900 3250 50  0001 C CNN
F 3 "" H 900 3250 50  0001 C CNN
	1    900  3250
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 5E5ABAAF
P 1900 3650
AR Path="/5E33BBDC/5E5ABAAF" Ref="R?"  Part="1" 
AR Path="/5E5ABAAF" Ref="R103"  Part="1" 
F 0 "R103" H 1968 3696 50  0000 L CNN
F 1 "1.0K" H 1968 3605 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 1900 3650 50  0001 C CNN
F 3 "A127319CT-ND" H 1900 3650 50  0001 C CNN
	1    1900 3650
	-1   0    0    1   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E5ABAB5
P 1900 3750
AR Path="/5E33BBDC/5E5ABAB5" Ref="#PWR?"  Part="1" 
AR Path="/5E5ABAB5" Ref="#PWR0112"  Part="1" 
F 0 "#PWR0112" H 1900 3500 50  0001 C CNN
F 1 "GND" H 1905 3577 50  0000 C CNN
F 2 "" H 1900 3750 50  0001 C CNN
F 3 "" H 1900 3750 50  0001 C CNN
	1    1900 3750
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 5E5ABABB
P 1950 2750
AR Path="/5E33BBDC/5E5ABABB" Ref="R?"  Part="1" 
AR Path="/5E5ABABB" Ref="R104"  Part="1" 
F 0 "R104" H 1700 2800 50  0000 L CNN
F 1 "10K" H 1750 2700 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 1950 2750 50  0001 C CNN
F 3 "541-3958-1-ND" H 1950 2750 50  0001 C CNN
	1    1950 2750
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 5E5ABAC1
P 1850 2750
AR Path="/5E33BBDC/5E5ABAC1" Ref="R?"  Part="1" 
AR Path="/5E5ABAC1" Ref="R102"  Part="1" 
F 0 "R102" H 1918 2796 50  0000 L CNN
F 1 "10K" H 1918 2705 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 1850 2750 50  0001 C CNN
F 3 "541-3958-1-ND" H 1850 2750 50  0001 C CNN
	1    1850 2750
	-1   0    0    1   
$EndComp
$Comp
L power:+2V5 #PWR?
U 1 1 5E5ABAC7
P 1950 2650
AR Path="/5E33BBDC/5E5ABAC7" Ref="#PWR?"  Part="1" 
AR Path="/5E5ABAC7" Ref="#PWR0113"  Part="1" 
F 0 "#PWR0113" H 1950 2500 50  0001 C CNN
F 1 "+2V5" V 1965 2778 50  0000 L CNN
F 2 "" H 1950 2650 50  0001 C CNN
F 3 "" H 1950 2650 50  0001 C CNN
	1    1950 2650
	1    0    0    -1  
$EndComp
$Comp
L power:+2V5 #PWR?
U 1 1 5E5ABACD
P 1850 2650
AR Path="/5E33BBDC/5E5ABACD" Ref="#PWR?"  Part="1" 
AR Path="/5E5ABACD" Ref="#PWR0111"  Part="1" 
F 0 "#PWR0111" H 1850 2500 50  0001 C CNN
F 1 "+2V5" V 1865 2778 50  0000 L CNN
F 2 "" H 1850 2650 50  0001 C CNN
F 3 "" H 1850 2650 50  0001 C CNN
	1    1850 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 3350 1900 3350
Wire Wire Line
	1800 3150 1850 3150
Wire Wire Line
	1800 2950 1950 2950
Wire Wire Line
	1300 3350 900  3350
Wire Wire Line
	1300 3250 900  3250
Wire Wire Line
	1300 2950 900  2950
Wire Wire Line
	1900 3550 1900 3350
Wire Wire Line
	1850 3150 1850 2850
Wire Wire Line
	1950 2950 1950 2850
NoConn ~ 1300 3050
NoConn ~ 1800 3050
NoConn ~ 1300 3150
$Comp
L Switch:SW_Push SW?
U 1 1 5E5BB2B4
P 1000 4350
AR Path="/5E33BBDC/5E5BB2B4" Ref="SW?"  Part="1" 
AR Path="/5E5BB2B4" Ref="SW101"  Part="1" 
F 0 "SW101" H 1000 4635 50  0000 C CNN
F 1 "SW_Push" H 1000 4544 50  0000 C CNN
F 2 "Button_Switch_SMD:SW_SPST_KMR2" H 1000 4550 50  0001 C CNN
F 3 "CKN10246CT-ND" H 1000 4550 50  0001 C CNN
	1    1000 4350
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 5E5BB2BA
P 1300 4350
AR Path="/5E33BBDC/5E5BB2BA" Ref="R?"  Part="1" 
AR Path="/5E5BB2BA" Ref="R101"  Part="1" 
F 0 "R101" V 1505 4350 50  0000 C CNN
F 1 "330R" V 1414 4350 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 1300 4350 50  0001 C CNN
F 3 "541-3996-1-ND" H 1300 4350 50  0001 C CNN
	1    1300 4350
	0    -1   -1   0   
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5E5BB2C0
P 1400 4450
AR Path="/5E33BBDC/5E5BB2C0" Ref="C?"  Part="1" 
AR Path="/5E5BB2C0" Ref="C103"  Part="1" 
F 0 "C103" H 1492 4496 50  0000 L CNN
F 1 "0.1uF" H 1492 4405 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 1400 4450 50  0001 C CNN
F 3 "732-7487-1-ND" H 1400 4450 50  0001 C CNN
	1    1400 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E5BB2C6
P 1400 4550
AR Path="/5E33BBDC/5E5BB2C6" Ref="#PWR?"  Part="1" 
AR Path="/5E5BB2C6" Ref="#PWR0110"  Part="1" 
F 0 "#PWR0110" H 1400 4300 50  0001 C CNN
F 1 "GND" H 1405 4377 50  0000 C CNN
F 2 "" H 1400 4550 50  0001 C CNN
F 3 "" H 1400 4550 50  0001 C CNN
	1    1400 4550
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5E5BB2CC
P 800 4350
AR Path="/5E33BBDC/5E5BB2CC" Ref="#PWR?"  Part="1" 
AR Path="/5E5BB2CC" Ref="#PWR0101"  Part="1" 
F 0 "#PWR0101" H 800 4100 50  0001 C CNN
F 1 "GND" H 805 4177 50  0000 C CNN
F 2 "" H 800 4350 50  0001 C CNN
F 3 "" H 800 4350 50  0001 C CNN
	1    800  4350
	1    0    0    -1  
$EndComp
Text Label 2000 4350 2    50   ~ 0
nConfig
Wire Wire Line
	1400 4350 2000 4350
Connection ~ 1400 4350
$Sheet
S 6000 800  1450 2100
U 5E626C5F
F0 "FPGA1" 50
F1 "FPGA.sch" 50
F2 "CLK24_576" I L 6000 1650 50 
F3 "nConfig" I L 6000 1850 50 
F4 "tdi" I L 6000 2050 50 
F5 "tck" I L 6000 2150 50 
F6 "tms" I L 6000 2250 50 
F7 "tdo" O L 6000 2350 50 
F8 "sck" I L 6000 950 50 
F9 "mosi" I L 6000 1050 50 
F10 "ncs" I L 6000 1150 50 
F11 "miso" O L 6000 1250 50 
F12 "syncIn" I R 7450 1600 50 
F13 "syncOut" O R 7450 1800 50 
F14 "t[49..0]" O R 7450 1400 50 
F15 "red" O R 7450 900 50 
F16 "blue" O R 7450 1000 50 
F17 "green" O R 7450 1100 50 
F18 "+2.5V" O L 6000 1450 50 
F19 "as_asdo" O L 6000 2600 50 
F20 "as_ncs" O L 6000 2700 50 
F21 "as_dclk" O L 6000 2800 50 
F22 "as_data0" O L 6000 2500 50 
$EndSheet
$Sheet
S 650  6500 1600 1050
U 5E635EEC
F0 "Power" 50
F1 "Power.sch" 50
$EndSheet
Wire Wire Line
	6000 2050 5600 2050
Wire Wire Line
	6000 2150 5600 2150
Wire Wire Line
	6000 2250 5600 2250
Wire Wire Line
	6000 2350 5450 2350
Wire Wire Line
	5450 4400 6000 4400
Wire Wire Line
	6000 4500 5600 4500
Wire Wire Line
	6000 4600 5600 4600
Wire Wire Line
	6000 4700 5600 4700
Text Label 5600 2050 0    50   ~ 0
tdi
Text Label 5600 2150 0    50   ~ 0
tck
Text Label 5600 2250 0    50   ~ 0
tms
Text Label 5600 4500 0    50   ~ 0
tck
Text Label 5600 4600 0    50   ~ 0
tms
Text Label 5600 4700 0    50   ~ 0
tdo
Wire Wire Line
	6000 4050 5300 4050
Wire Wire Line
	6000 4250 5700 4250
Text Label 4800 4050 0    50   ~ 0
clk
Text Label 5700 4250 0    50   ~ 0
nConfig
Wire Wire Line
	6000 1850 5700 1850
Text Label 5700 1850 0    50   ~ 0
nConfig
Text Label 1850 1700 2    50   ~ 0
clk
Wire Wire Line
	6000 3350 5700 3350
Wire Wire Line
	6000 3550 5700 3550
Wire Wire Line
	6000 1150 5700 1150
Wire Wire Line
	6000 1050 5700 1050
Wire Wire Line
	6000 950  5700 950 
Text Label 5700 950  0    50   ~ 0
sck
Text Label 5700 1050 0    50   ~ 0
mosi
Text Label 5700 1150 0    50   ~ 0
ncs
Text Label 5700 3350 0    50   ~ 0
sck
Text Label 5700 3550 0    50   ~ 0
ncs
$Sheet
S 2750 6550 1550 950 
U 5E6CFC23
F0 "Raspberry PI" 50
F1 "raspberrypi.sch" 50
F2 "nCE0" O R 4300 6750 50 
F3 "miso" I R 4300 6850 50 
F4 "mosi" O R 4300 6950 50 
F5 "sclk" O R 4300 7050 50 
$EndSheet
Wire Wire Line
	4300 6750 4650 6750
Wire Wire Line
	4300 6950 4650 6950
Wire Wire Line
	4300 7050 4650 7050
Text Label 5300 6750 2    50   ~ 0
ncs
Text Label 5300 6950 2    50   ~ 0
mosi
Text Label 5300 7050 2    50   ~ 0
sck
$Comp
L Interface:AM26LV32xD U101
U 1 1 5EB8CC3F
P 9350 1750
F 0 "U101" H 9500 2900 50  0000 C CNN
F 1 "AM26LV32CDR" H 9700 2800 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 10350 800 50  0001 C CNN
F 3 "296-6794-1-ND" H 9350 1350 50  0001 C CNN
	1    9350 1750
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8850 1050 8500 1050
Wire Wire Line
	8850 1350 8500 1350
Wire Wire Line
	8850 2450 8500 2450
Wire Wire Line
	8850 2150 8500 2150
Text Label 8500 1050 0    50   ~ 0
ncs
Text Label 8500 1350 0    50   ~ 0
mosi
Text Label 8500 2150 0    50   ~ 0
sck
Text Label 8500 2450 0    50   ~ 0
syncIn
Wire Wire Line
	8550 3650 8900 3650
Wire Wire Line
	8550 3900 8900 3900
Wire Wire Line
	8550 4400 8900 4400
Wire Wire Line
	8550 4150 8900 4150
Text Label 8550 3650 0    50   ~ 0
ncs
Text Label 8550 3900 0    50   ~ 0
mosi
Text Label 8550 4150 0    50   ~ 0
sck
Text Label 8550 4400 0    50   ~ 0
syncOut
$Comp
L power:GND #PWR?
U 1 1 5EBA1F7D
P 9350 4850
AR Path="/5E33BBDC/5EBA1F7D" Ref="#PWR?"  Part="1" 
AR Path="/5EBA1F7D" Ref="#PWR0120"  Part="1" 
F 0 "#PWR0120" H 9350 4600 50  0001 C CNN
F 1 "GND" H 9355 4677 50  0000 C CNN
F 2 "" H 9350 4850 50  0001 C CNN
F 3 "" H 9350 4850 50  0001 C CNN
	1    9350 4850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EBA24B4
P 8750 4650
AR Path="/5E33BBDC/5EBA24B4" Ref="#PWR?"  Part="1" 
AR Path="/5EBA24B4" Ref="#PWR0115"  Part="1" 
F 0 "#PWR0115" H 8750 4400 50  0001 C CNN
F 1 "GND" H 8755 4477 50  0000 C CNN
F 2 "" H 8750 4650 50  0001 C CNN
F 3 "" H 8750 4650 50  0001 C CNN
	1    8750 4650
	0    1    1    0   
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 5EBA28FE
P 9350 3450
AR Path="/5E33BBDC/5EBA28FE" Ref="#PWR?"  Part="1" 
AR Path="/5EBA28FE" Ref="#PWR0119"  Part="1" 
F 0 "#PWR0119" H 9350 3300 50  0001 C CNN
F 1 "+3V0" H 9365 3623 50  0000 C CNN
F 2 "" H 9350 3450 50  0001 C CNN
F 3 "" H 9350 3450 50  0001 C CNN
	1    9350 3450
	1    0    0    -1  
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 5EBA3160
P 8900 4550
AR Path="/5E33BBDC/5EBA3160" Ref="#PWR?"  Part="1" 
AR Path="/5EBA3160" Ref="#PWR0116"  Part="1" 
F 0 "#PWR0116" H 8900 4400 50  0001 C CNN
F 1 "+3V0" H 8915 4723 50  0000 C CNN
F 2 "" H 8900 4550 50  0001 C CNN
F 3 "" H 8900 4550 50  0001 C CNN
	1    8900 4550
	0    -1   -1   0   
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 5EBA3A05
P 9850 1650
AR Path="/5E33BBDC/5EBA3A05" Ref="#PWR?"  Part="1" 
AR Path="/5EBA3A05" Ref="#PWR0121"  Part="1" 
F 0 "#PWR0121" H 9850 1500 50  0001 C CNN
F 1 "+3V0" H 9865 1823 50  0000 C CNN
F 2 "" H 9850 1650 50  0001 C CNN
F 3 "" H 9850 1650 50  0001 C CNN
	1    9850 1650
	0    1    -1   0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EBA4062
P 9850 1850
AR Path="/5E33BBDC/5EBA4062" Ref="#PWR?"  Part="1" 
AR Path="/5EBA4062" Ref="#PWR0122"  Part="1" 
F 0 "#PWR0122" H 9850 1600 50  0001 C CNN
F 1 "GND" H 9855 1677 50  0000 C CNN
F 2 "" H 9850 1850 50  0001 C CNN
F 3 "" H 9850 1850 50  0001 C CNN
	1    9850 1850
	0    -1   1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EBA43DA
P 9350 2750
AR Path="/5E33BBDC/5EBA43DA" Ref="#PWR?"  Part="1" 
AR Path="/5EBA43DA" Ref="#PWR0118"  Part="1" 
F 0 "#PWR0118" H 9350 2500 50  0001 C CNN
F 1 "GND" H 9355 2577 50  0000 C CNN
F 2 "" H 9350 2750 50  0001 C CNN
F 3 "" H 9350 2750 50  0001 C CNN
	1    9350 2750
	-1   0    0    -1  
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 5EBA4C8F
P 9350 750
AR Path="/5E33BBDC/5EBA4C8F" Ref="#PWR?"  Part="1" 
AR Path="/5EBA4C8F" Ref="#PWR0117"  Part="1" 
F 0 "#PWR0117" H 9350 600 50  0001 C CNN
F 1 "+3V0" H 9365 923 50  0000 C CNN
F 2 "" H 9350 750 50  0001 C CNN
F 3 "" H 9350 750 50  0001 C CNN
	1    9350 750 
	-1   0    0    -1  
$EndComp
$Comp
L holo:AM26LV31 U102
U 1 1 5EB9BA07
P 9350 3950
F 0 "U102" H 8950 4550 50  0000 C CNN
F 1 "AM26LV31" H 9100 4450 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 9350 3950 50  0001 C CNN
F 3 "296-25912-1-ND" H 9350 3950 50  0001 C CNN
	1    9350 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	9800 3650 10050 3650
Wire Wire Line
	9800 3750 10050 3750
Wire Wire Line
	9800 3900 10050 3900
Wire Wire Line
	9800 4000 10050 4000
Wire Wire Line
	9800 4150 10050 4150
Wire Wire Line
	9800 4250 10050 4250
Wire Wire Line
	9800 4400 10050 4400
Wire Wire Line
	9800 4500 10050 4500
Wire Wire Line
	9850 2550 9950 2550
Wire Wire Line
	9850 2350 9950 2350
Wire Wire Line
	9850 2250 9950 2250
Wire Wire Line
	9850 2050 9950 2050
Wire Wire Line
	9850 1450 9950 1450
Wire Wire Line
	9850 1250 9950 1250
Wire Wire Line
	10200 5650 9950 5650
Wire Wire Line
	9950 5750 10200 5750
Wire Wire Line
	10200 6350 9950 6350
Wire Wire Line
	10200 6250 9950 6250
Text Label 10100 950  2    50   ~ 0
1A
Text Label 10100 1150 2    50   ~ 0
1B
Text Label 10100 1250 2    50   ~ 0
2A
Text Label 10100 1450 2    50   ~ 0
2B
Text Label 10100 2050 2    50   ~ 0
3A
Text Label 10100 2250 2    50   ~ 0
3B
Text Label 10100 2350 2    50   ~ 0
4A
Text Label 10100 2550 2    50   ~ 0
4B
Text Label 9950 5950 0    50   ~ 0
1A
Text Label 9950 5850 0    50   ~ 0
1B
Text Label 9950 6050 0    50   ~ 0
4A
Text Label 9950 6150 0    50   ~ 0
4B
Text Label 10050 3650 2    50   ~ 0
1A
Text Label 10050 3750 2    50   ~ 0
1B
Text Label 10050 3900 2    50   ~ 0
2A
Text Label 10050 4000 2    50   ~ 0
2B
Text Label 10050 4150 2    50   ~ 0
3A
Text Label 10050 4250 2    50   ~ 0
3B
Text Label 10050 4400 2    50   ~ 0
4A
Text Label 10050 4500 2    50   ~ 0
4B
Wire Wire Line
	8750 4650 8900 4650
Wire Wire Line
	7450 1800 7800 1800
Wire Wire Line
	7800 1800 7800 2550
Wire Wire Line
	7800 3950 7450 3950
Wire Wire Line
	7450 1600 7700 1600
Text Label 7700 1600 2    50   ~ 0
syncIn
Text Label 7800 3950 2    50   ~ 0
syncIn
NoConn ~ 7450 4150
Text Label 7800 1800 2    50   ~ 0
syncOut
$Comp
L Device:R_Small_US R106
U 1 1 5EC2D99A
P 7800 2650
F 0 "R106" H 7868 2696 50  0000 L CNN
F 1 "0R" H 7868 2605 50  0000 L CNN
F 2 "Jumper:SolderJumper-2_P1.3mm_Open_TrianglePad1.0x1.5mm" H 7800 2650 50  0001 C CNN
F 3 "~" H 7800 2650 50  0001 C CNN
	1    7800 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 2750 7800 3950
Wire Bus Line
	7450 1400 7900 1400
Wire Bus Line
	7450 4550 7900 4550
Text Label 7900 4550 2    50   ~ 0
t[49..0]
Text Label 7900 1400 2    50   ~ 0
s[49..0]
$Sheet
S 3000 1400 1200 1550
U 5F4DFBB0
F0 "Transducers" 50
F1 "transducers.sch" 50
F2 "t[49..0]" I L 3000 2250 50 
F3 "s[49..0]" I L 3000 2400 50 
$EndSheet
Wire Bus Line
	3000 2250 2650 2250
Text Label 2650 2250 0    50   ~ 0
t[49..0]
Wire Wire Line
	1850 3150 2250 3150
Connection ~ 1850 3150
Wire Wire Line
	1950 2950 2250 2950
Connection ~ 1950 2950
Wire Wire Line
	1800 3250 2250 3250
Wire Wire Line
	1900 3350 2250 3350
Connection ~ 1900 3350
Text Label 2250 3350 2    50   ~ 0
tck
Text Label 2250 3250 2    50   ~ 0
tdo
Text Label 2250 3150 2    50   ~ 0
tms
Text Label 2250 2950 2    50   ~ 0
tdi
$Sheet
S 5900 6650 950  800 
U 5F528E57
F0 "LED" 50
F1 "LED.sch" 50
F2 "redDim" I L 5900 6850 50 
F3 "greenDim" I L 5900 7000 50 
F4 "blueDim" I L 5900 7150 50 
$EndSheet
Wire Wire Line
	5900 6850 5500 6850
Wire Wire Line
	5500 7150 5900 7150
Wire Wire Line
	5900 7000 5500 7000
Text Label 5500 6850 0    50   ~ 0
redDim
Text Label 5500 7150 0    50   ~ 0
blueDim
Text Label 5500 7000 0    50   ~ 0
greenDim
$Comp
L Device:C_Small C?
U 1 1 5F5B0188
P 1200 1000
AR Path="/5E33BBDC/5F5B0188" Ref="C?"  Part="1" 
AR Path="/5F5B0188" Ref="C102"  Part="1" 
F 0 "C102" H 1292 1046 50  0000 L CNN
F 1 "0.1uF" H 1292 955 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 1200 1000 50  0001 C CNN
F 3 "1276-1044-1-ND" H 1200 1000 50  0001 C CNN
	1    1200 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1200 1100 850  1100
Connection ~ 850  1100
Wire Wire Line
	1200 900  850  900 
Connection ~ 850  900 
$Comp
L Device:C_Small C?
U 1 1 5F5B87C1
P 10450 900
AR Path="/5E33BBDC/5F5B87C1" Ref="C?"  Part="1" 
AR Path="/5F5B87C1" Ref="C104"  Part="1" 
F 0 "C104" H 10542 946 50  0000 L CNN
F 1 "4.7uF" H 10542 855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 10450 900 50  0001 C CNN
F 3 "1276-1044-1-ND" H 10450 900 50  0001 C CNN
	1    10450 900 
	1    0    0    -1  
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 5F5B87C7
P 10450 800
AR Path="/5E33BBDC/5F5B87C7" Ref="#PWR?"  Part="1" 
AR Path="/5F5B87C7" Ref="#PWR0123"  Part="1" 
F 0 "#PWR0123" H 10450 650 50  0001 C CNN
F 1 "+3V0" H 10465 973 50  0000 C CNN
F 2 "" H 10450 800 50  0001 C CNN
F 3 "" H 10450 800 50  0001 C CNN
	1    10450 800 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F5B87CD
P 10450 1000
AR Path="/5E33BBDC/5F5B87CD" Ref="#PWR?"  Part="1" 
AR Path="/5F5B87CD" Ref="#PWR0124"  Part="1" 
F 0 "#PWR0124" H 10450 750 50  0001 C CNN
F 1 "GND" H 10455 827 50  0000 C CNN
F 2 "" H 10450 1000 50  0001 C CNN
F 3 "" H 10450 1000 50  0001 C CNN
	1    10450 1000
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 5F5B87D3
P 10800 900
AR Path="/5E33BBDC/5F5B87D3" Ref="C?"  Part="1" 
AR Path="/5F5B87D3" Ref="C105"  Part="1" 
F 0 "C105" H 10892 946 50  0000 L CNN
F 1 "0.1uF" H 10892 855 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 10800 900 50  0001 C CNN
F 3 "1276-1044-1-ND" H 10800 900 50  0001 C CNN
	1    10800 900 
	1    0    0    -1  
$EndComp
Wire Wire Line
	10800 1000 10450 1000
Connection ~ 10450 1000
Wire Wire Line
	10800 800  10450 800 
Connection ~ 10450 800 
Connection ~ 9950 950 
Wire Wire Line
	9950 950  10100 950 
Connection ~ 9950 1150
Wire Wire Line
	9950 1150 10100 1150
Wire Wire Line
	9850 1150 9950 1150
Wire Wire Line
	9850 950  9950 950 
$Comp
L Device:R_Small_US R107
U 1 1 5F5BF220
P 9950 1050
F 0 "R107" H 10018 1096 50  0000 L CNN
F 1 "100R" H 10018 1005 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 9950 1050 50  0001 C CNN
F 3 "A127223CT-ND" H 9950 1050 50  0001 C CNN
	1    9950 1050
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R108
U 1 1 5F5C013F
P 9950 1350
F 0 "R108" H 10018 1396 50  0000 L CNN
F 1 "100R" H 10018 1305 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 9950 1350 50  0001 C CNN
F 3 "A127223CT-ND" H 9950 1350 50  0001 C CNN
	1    9950 1350
	1    0    0    -1  
$EndComp
Connection ~ 9950 1250
Wire Wire Line
	9950 1250 10100 1250
Connection ~ 9950 1450
Wire Wire Line
	9950 1450 10100 1450
$Comp
L Device:R_Small_US R109
U 1 1 5F5C0716
P 9950 2150
F 0 "R109" H 10018 2196 50  0000 L CNN
F 1 "100R" H 10018 2105 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 9950 2150 50  0001 C CNN
F 3 "A127223CT-ND" H 9950 2150 50  0001 C CNN
	1    9950 2150
	1    0    0    -1  
$EndComp
Connection ~ 9950 2050
Wire Wire Line
	9950 2050 10100 2050
Connection ~ 9950 2250
Wire Wire Line
	9950 2250 10100 2250
$Comp
L Device:R_Small_US R110
U 1 1 5F5C0BF0
P 9950 2450
F 0 "R110" H 10018 2496 50  0000 L CNN
F 1 "100R" H 10018 2405 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 9950 2450 50  0001 C CNN
F 3 "A127223CT-ND" H 9950 2450 50  0001 C CNN
	1    9950 2450
	1    0    0    -1  
$EndComp
Connection ~ 9950 2350
Wire Wire Line
	9950 2350 10100 2350
Connection ~ 9950 2550
Wire Wire Line
	9950 2550 10100 2550
Wire Bus Line
	3000 2400 2650 2400
Text Label 2650 2400 0    50   ~ 0
s[49..0]
Text Label 9950 6250 0    50   ~ 0
3B
Text Label 9950 6350 0    50   ~ 0
3A
Wire Wire Line
	10200 6150 9950 6150
Wire Wire Line
	10200 6050 9950 6050
Text Label 9950 5750 0    50   ~ 0
2B
Text Label 9950 5650 0    50   ~ 0
2A
Wire Wire Line
	10200 5850 9950 5850
Wire Wire Line
	10200 5950 9950 5950
$Comp
L Connector_Generic:Conn_01x08 J102
U 1 1 5EE1C1C4
P 10400 5950
F 0 "J102" H 10480 5942 50  0000 L CNN
F 1 "Comms" H 10480 5851 50  0000 L CNN
F 2 "Connector_Hirose:Hirose_DF13-08P-1.25DS_1x08_P1.25mm_Horizontal" H 10400 5950 50  0001 C CNN
F 3 "H2205-ND" H 10400 5950 50  0001 C CNN
	1    10400 5950
	1    0    0    -1  
$EndComp
$Sheet
S 6000 3200 1450 2100
U 5E635C99
F0 "FPGA2" 50
F1 "FPGA.sch" 50
F2 "CLK24_576" I L 6000 4050 50 
F3 "nConfig" I L 6000 4250 50 
F4 "tdi" I L 6000 4400 50 
F5 "tck" I L 6000 4500 50 
F6 "tms" I L 6000 4600 50 
F7 "tdo" O L 6000 4700 50 
F8 "sck" I L 6000 3350 50 
F9 "mosi" I L 6000 3450 50 
F10 "ncs" I L 6000 3550 50 
F11 "miso" O L 6000 3650 50 
F12 "syncIn" I R 7450 3950 50 
F13 "syncOut" O R 7450 4150 50 
F14 "t[49..0]" O R 7450 4550 50 
F15 "red" O R 7450 4850 50 
F16 "blue" O R 7450 4950 50 
F17 "green" O R 7450 5050 50 
F18 "as_asdo" O L 6000 4850 50 
F19 "as_ncs" O L 6000 4950 50 
F20 "as_dclk" O L 6000 5050 50 
F21 "as_data0" O L 6000 5150 50 
$EndSheet
$Comp
L Device:R_Small_US R105
U 1 1 5EEF4180
P 5350 2350
F 0 "R105" H 5418 2396 50  0000 L CNN
F 1 "0R" H 5418 2305 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 5350 2350 50  0001 C CNN
F 3 "~" H 5350 2350 50  0001 C CNN
	1    5350 2350
	0    1    1    0   
$EndComp
Connection ~ 5450 2350
Wire Wire Line
	5250 2350 5050 2350
Text Label 5050 2350 0    50   ~ 0
tdo
Wire Wire Line
	6000 1250 4850 1250
Wire Wire Line
	4850 1250 4850 3450
Wire Wire Line
	4850 3450 6000 3450
Wire Notes Line
	8350 500  10250 500 
Wire Notes Line
	10250 500  10250 3050
Wire Notes Line
	10250 3050 8350 3050
Wire Notes Line
	8350 3050 8350 500 
Wire Notes Line
	8350 3150 10250 3150
Wire Notes Line
	10250 3150 10250 5150
Wire Notes Line
	10250 5150 8350 5150
Wire Notes Line
	8350 5150 8350 3150
Text Notes 10100 3000 2    50   ~ 0
A
Text Notes 10100 5000 2    50   ~ 0
B
Text Notes 10550 3150 2    50   ~ 0
Populate A or B\n
Wire Wire Line
	6000 1450 5700 1450
$Comp
L power:+2V5 #PWR0114
U 1 1 5FCCD7F7
P 5700 1450
F 0 "#PWR0114" H 5700 1300 50  0001 C CNN
F 1 "+2V5" V 5715 1578 50  0000 L CNN
F 2 "" H 5700 1450 50  0001 C CNN
F 3 "" H 5700 1450 50  0001 C CNN
	1    5700 1450
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6000 3650 5700 3650
Text Label 5700 3650 0    50   ~ 0
miso
Wire Wire Line
	4300 6850 4650 6850
Text Label 4650 6850 2    50   ~ 0
miso
$Comp
L Device:C_Small C?
U 1 1 60572F79
P 10500 1850
AR Path="/5E33BBDC/60572F79" Ref="C?"  Part="1" 
AR Path="/60572F79" Ref="C106"  Part="1" 
F 0 "C106" H 10592 1896 50  0000 L CNN
F 1 "4.7uF" H 10592 1805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 10500 1850 50  0001 C CNN
F 3 "1276-1044-1-ND" H 10500 1850 50  0001 C CNN
	1    10500 1850
	1    0    0    -1  
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 60572F7F
P 10500 1750
AR Path="/5E33BBDC/60572F7F" Ref="#PWR?"  Part="1" 
AR Path="/60572F7F" Ref="#PWR0125"  Part="1" 
F 0 "#PWR0125" H 10500 1600 50  0001 C CNN
F 1 "+3V0" H 10515 1923 50  0000 C CNN
F 2 "" H 10500 1750 50  0001 C CNN
F 3 "" H 10500 1750 50  0001 C CNN
	1    10500 1750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 60572F85
P 10500 1950
AR Path="/5E33BBDC/60572F85" Ref="#PWR?"  Part="1" 
AR Path="/60572F85" Ref="#PWR0126"  Part="1" 
F 0 "#PWR0126" H 10500 1700 50  0001 C CNN
F 1 "GND" H 10505 1777 50  0000 C CNN
F 2 "" H 10500 1950 50  0001 C CNN
F 3 "" H 10500 1950 50  0001 C CNN
	1    10500 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 60572F8B
P 10850 1850
AR Path="/5E33BBDC/60572F8B" Ref="C?"  Part="1" 
AR Path="/60572F8B" Ref="C107"  Part="1" 
F 0 "C107" H 10942 1896 50  0000 L CNN
F 1 "0.1uF" H 10942 1805 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 10850 1850 50  0001 C CNN
F 3 "1276-1044-1-ND" H 10850 1850 50  0001 C CNN
	1    10850 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	10850 1950 10500 1950
Connection ~ 10500 1950
Wire Wire Line
	10850 1750 10500 1750
Connection ~ 10500 1750
$Comp
L Device:R_Small_US R113
U 1 1 6059098F
P 5350 4400
F 0 "R113" H 5418 4446 50  0000 L CNN
F 1 "0R" H 5418 4355 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 5350 4400 50  0001 C CNN
F 3 "~" H 5350 4400 50  0001 C CNN
	1    5350 4400
	0    1    1    0   
$EndComp
Connection ~ 5450 4400
Wire Wire Line
	5250 4400 5100 4400
Text Label 5100 4400 0    50   ~ 0
tdi
$Comp
L Device:R_Small_US R112
U 1 1 605987C3
P 4750 3450
F 0 "R112" H 4818 3496 50  0000 L CNN
F 1 "0R" H 4818 3405 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4750 3450 50  0001 C CNN
F 3 "~" H 4750 3450 50  0001 C CNN
	1    4750 3450
	0    1    1    0   
$EndComp
Connection ~ 4850 3450
Wire Wire Line
	4650 3450 4300 3450
$Comp
L Device:R_Small_US R111
U 1 1 605A6639
P 4750 1250
F 0 "R111" H 4818 1296 50  0000 L CNN
F 1 "0R" H 4818 1205 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4750 1250 50  0001 C CNN
F 3 "~" H 4750 1250 50  0001 C CNN
	1    4750 1250
	0    1    1    0   
$EndComp
Connection ~ 4850 1250
Wire Wire Line
	4650 1250 4300 1250
Text Label 4300 1250 0    50   ~ 0
miso
Text Label 4300 3450 0    50   ~ 0
mosi
Text Label 8250 5050 2    50   ~ 0
greenDim
Text Label 8250 4950 2    50   ~ 0
blueDim
Text Label 8250 4850 2    50   ~ 0
redDim
Wire Wire Line
	7850 5050 8250 5050
Wire Wire Line
	8250 4950 7850 4950
Wire Wire Line
	7850 4850 8250 4850
$Comp
L Device:R_Small_US R114
U 1 1 605B128D
P 7750 4850
F 0 "R114" H 7818 4896 50  0000 L CNN
F 1 "0R" H 7818 4805 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 7750 4850 50  0001 C CNN
F 3 "~" H 7750 4850 50  0001 C CNN
	1    7750 4850
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R115
U 1 1 605B1A26
P 7750 4950
F 0 "R115" H 7818 4996 50  0000 L CNN
F 1 "0R" H 7818 4905 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 7750 4950 50  0001 C CNN
F 3 "~" H 7750 4950 50  0001 C CNN
	1    7750 4950
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R116
U 1 1 605B1FAB
P 7750 5050
F 0 "R116" H 7818 5096 50  0000 L CNN
F 1 "0R" H 7818 5005 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 7750 5050 50  0001 C CNN
F 3 "~" H 7750 5050 50  0001 C CNN
	1    7750 5050
	0    1    1    0   
$EndComp
Wire Wire Line
	7450 4850 7650 4850
Wire Wire Line
	7650 4950 7450 4950
Wire Wire Line
	7450 5050 7650 5050
Text Label 8250 1100 2    50   ~ 0
greenDim
Text Label 8250 1000 2    50   ~ 0
blueDim
Text Label 8250 900  2    50   ~ 0
redDim
Wire Wire Line
	7850 1100 8250 1100
Wire Wire Line
	8250 1000 7850 1000
Wire Wire Line
	7850 900  8250 900 
$Comp
L Device:R_Small_US R117
U 1 1 605E2A75
P 7750 900
F 0 "R117" H 7818 946 50  0000 L CNN
F 1 "0R" H 7818 855 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 7750 900 50  0001 C CNN
F 3 "~" H 7750 900 50  0001 C CNN
	1    7750 900 
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R118
U 1 1 605E2A7B
P 7750 1000
F 0 "R118" H 7818 1046 50  0000 L CNN
F 1 "0R" H 7818 955 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 7750 1000 50  0001 C CNN
F 3 "~" H 7750 1000 50  0001 C CNN
	1    7750 1000
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R119
U 1 1 605E2A81
P 7750 1100
F 0 "R119" H 7818 1146 50  0000 L CNN
F 1 "0R" H 7818 1055 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 7750 1100 50  0001 C CNN
F 3 "~" H 7750 1100 50  0001 C CNN
	1    7750 1100
	0    1    1    0   
$EndComp
Wire Wire Line
	7450 900  7650 900 
Wire Wire Line
	7650 1000 7450 1000
Wire Wire Line
	7450 1100 7650 1100
$Comp
L Device:R_Small_US R130
U 1 1 60699924
P 4750 6750
F 0 "R130" V 4650 6650 50  0000 L CNN
F 1 "100R" V 4650 6850 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4750 6750 50  0001 C CNN
F 3 "118-CR0402AJW-101GLFCT-ND" H 4750 6750 50  0001 C CNN
	1    4750 6750
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R131
U 1 1 606A5D68
P 4750 6950
F 0 "R131" V 4650 6850 50  0000 L CNN
F 1 "100R" V 4650 7050 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4750 6950 50  0001 C CNN
F 3 "118-CR0402AJW-101GLFCT-ND" H 4750 6950 50  0001 C CNN
	1    4750 6950
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R132
U 1 1 606A60CE
P 4750 7050
F 0 "R132" V 4850 6950 50  0000 L CNN
F 1 "100R" V 4850 7150 50  0000 L CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4750 7050 50  0001 C CNN
F 3 "118-CR0402AJW-101GLFCT-ND" H 4750 7050 50  0001 C CNN
	1    4750 7050
	0    1    1    0   
$EndComp
Wire Wire Line
	4850 6750 5300 6750
Wire Wire Line
	4850 6950 5300 6950
Wire Wire Line
	4850 7050 5300 7050
$Comp
L flicker:EPCQ16A U?
U 1 1 606E8FAC
P 2950 5200
AR Path="/5E33BBDC/606E8FAC" Ref="U?"  Part="1" 
AR Path="/606E8FAC" Ref="U103"  Part="1" 
AR Path="/5E626C5F/606E8FAC" Ref="U?"  Part="1" 
AR Path="/5E635C99/606E8FAC" Ref="U?"  Part="1" 
F 0 "U103" H 3328 5271 50  0000 L CNN
F 1 "EPCQ16A" H 3328 5180 50  0000 L CNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 3000 5300 50  0001 C CNN
F 3 "544-3440-ND" H 3000 5300 50  0001 C CNN
	1    2950 5200
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 606E8FB2
P 2900 5550
AR Path="/5E33BBDC/606E8FB2" Ref="#PWR?"  Part="1" 
AR Path="/606E8FB2" Ref="#PWR0132"  Part="1" 
AR Path="/5E626C5F/606E8FB2" Ref="#PWR?"  Part="1" 
AR Path="/5E635C99/606E8FB2" Ref="#PWR?"  Part="1" 
F 0 "#PWR0132" H 2900 5300 50  0001 C CNN
F 1 "GND" H 2905 5377 50  0000 C CNN
F 2 "" H 2900 5550 50  0001 C CNN
F 3 "" H 2900 5550 50  0001 C CNN
	1    2900 5550
	-1   0    0    -1  
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 606E8FB8
P 2900 4800
AR Path="/5E33BBDC/606E8FB8" Ref="#PWR?"  Part="1" 
AR Path="/606E8FB8" Ref="#PWR0133"  Part="1" 
AR Path="/5E626C5F/606E8FB8" Ref="#PWR?"  Part="1" 
AR Path="/5E635C99/606E8FB8" Ref="#PWR?"  Part="1" 
F 0 "#PWR0133" H 2900 4650 50  0001 C CNN
F 1 "+3V0" H 2915 4973 50  0000 C CNN
F 2 "" H 2900 4800 50  0001 C CNN
F 3 "" H 2900 4800 50  0001 C CNN
	1    2900 4800
	-1   0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 606E8FBE
P 3650 5050
AR Path="/5E33BBDC/606E8FBE" Ref="R?"  Part="1" 
AR Path="/606E8FBE" Ref="R120"  Part="1" 
AR Path="/5E626C5F/606E8FBE" Ref="R?"  Part="1" 
AR Path="/5E635C99/606E8FBE" Ref="R?"  Part="1" 
F 0 "R120" V 3445 5050 50  0000 C CNN
F 1 "24R9" V 3536 5050 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 3650 5050 50  0001 C CNN
F 3 "2037-PFR05S-24R9-FNHCT-ND" H 3650 5050 50  0001 C CNN
	1    3650 5050
	0    -1   1    0   
$EndComp
Wire Wire Line
	3000 4800 2900 4800
Wire Wire Line
	2900 4800 2800 4800
Wire Wire Line
	3550 5050 3400 5050
Connection ~ 2900 4800
$Comp
L Device:R_Small_US R?
U 1 1 606FA189
P 3650 5350
AR Path="/5E33BBDC/606FA189" Ref="R?"  Part="1" 
AR Path="/606FA189" Ref="R121"  Part="1" 
AR Path="/5E626C5F/606FA189" Ref="R?"  Part="1" 
AR Path="/5E635C99/606FA189" Ref="R?"  Part="1" 
F 0 "R121" V 3445 5350 50  0000 C CNN
F 1 "50R" V 3536 5350 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 3650 5350 50  0001 C CNN
F 3 "2037-PFR05S-24R9-FNHCT-ND" H 3650 5350 50  0001 C CNN
	1    3650 5350
	0    -1   1    0   
$EndComp
Wire Wire Line
	3400 5350 3550 5350
Wire Wire Line
	5450 2350 5450 4400
Wire Wire Line
	6000 2500 5550 2500
Wire Wire Line
	6000 2600 5550 2600
Wire Wire Line
	6000 2700 5550 2700
Wire Wire Line
	6000 2800 5550 2800
Wire Wire Line
	6000 4850 5550 4850
Wire Wire Line
	6000 4950 5550 4950
Wire Wire Line
	6000 5050 5550 5050
Wire Wire Line
	6000 5150 5550 5150
Text Label 5550 2600 0    50   ~ 0
as_asdo_1
Text Label 5550 2700 0    50   ~ 0
as_ncs_1
Text Label 5550 2800 0    50   ~ 0
as_dclk_1
Text Label 5550 4850 0    50   ~ 0
as_data0_2
Text Label 5550 4950 0    50   ~ 0
as_asdo_2
Text Label 5550 5050 0    50   ~ 0
as_ncs_2
Text Label 5550 5150 0    50   ~ 0
as_dclk_2
Text Label 5550 2500 0    50   ~ 0
as_data0_1
$Comp
L Device:R_Small_US R?
U 1 1 607CDB1C
P 4100 4400
AR Path="/5E33BBDC/607CDB1C" Ref="R?"  Part="1" 
AR Path="/607CDB1C" Ref="R122"  Part="1" 
AR Path="/5E626C5F/607CDB1C" Ref="R?"  Part="1" 
AR Path="/5E635C99/607CDB1C" Ref="R?"  Part="1" 
F 0 "R122" V 4000 4550 50  0000 C CNN
F 1 "SOT" V 4000 4400 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4100 4400 50  0001 C CNN
F 3 "" H 4100 4400 50  0001 C CNN
	1    4100 4400
	0    -1   1    0   
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 607CEA88
P 4100 4550
AR Path="/5E33BBDC/607CEA88" Ref="R?"  Part="1" 
AR Path="/607CEA88" Ref="R123"  Part="1" 
AR Path="/5E626C5F/607CEA88" Ref="R?"  Part="1" 
AR Path="/5E635C99/607CEA88" Ref="R?"  Part="1" 
F 0 "R123" V 4000 4700 50  0000 C CNN
F 1 "SOT" V 4000 4550 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4100 4550 50  0001 C CNN
F 3 "" H 4100 4550 50  0001 C CNN
	1    4100 4550
	0    -1   1    0   
$EndComp
Wire Wire Line
	3750 5050 3850 5050
Wire Wire Line
	3850 5050 3850 4550
Wire Wire Line
	3850 4400 4000 4400
Wire Wire Line
	4000 4550 3850 4550
Connection ~ 3850 4550
Wire Wire Line
	3850 4550 3850 4400
Wire Wire Line
	4200 4400 4600 4400
Wire Wire Line
	4200 4550 4600 4550
Text Label 4600 4400 2    50   ~ 0
as_data0_1
Text Label 4600 4550 2    50   ~ 0
as_data0_2
$Comp
L Device:R_Small_US R?
U 1 1 60820B2F
P 4250 4750
AR Path="/5E33BBDC/60820B2F" Ref="R?"  Part="1" 
AR Path="/60820B2F" Ref="R124"  Part="1" 
AR Path="/5E626C5F/60820B2F" Ref="R?"  Part="1" 
AR Path="/5E635C99/60820B2F" Ref="R?"  Part="1" 
F 0 "R124" V 4150 4900 50  0000 C CNN
F 1 "SOT" V 4150 4750 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4250 4750 50  0001 C CNN
F 3 "" H 4250 4750 50  0001 C CNN
	1    4250 4750
	0    -1   1    0   
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 60820B35
P 4250 4900
AR Path="/5E33BBDC/60820B35" Ref="R?"  Part="1" 
AR Path="/60820B35" Ref="R125"  Part="1" 
AR Path="/5E626C5F/60820B35" Ref="R?"  Part="1" 
AR Path="/5E635C99/60820B35" Ref="R?"  Part="1" 
F 0 "R125" V 4150 5050 50  0000 C CNN
F 1 "SOT" V 4150 4900 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4250 4900 50  0001 C CNN
F 3 "" H 4250 4900 50  0001 C CNN
	1    4250 4900
	0    -1   1    0   
$EndComp
Wire Wire Line
	4000 4750 4150 4750
Wire Wire Line
	4150 4900 4000 4900
Wire Wire Line
	4350 4750 4750 4750
Wire Wire Line
	4350 4900 4750 4900
Wire Wire Line
	3400 5150 4000 5150
Wire Wire Line
	4000 5150 4000 4900
Connection ~ 4000 4900
Wire Wire Line
	4000 4900 4000 4750
Text Label 4750 4750 2    50   ~ 0
as_asdo_1
Text Label 4750 4900 2    50   ~ 0
as_asdo_2
$Comp
L Device:R_Small_US R?
U 1 1 6083F216
P 4400 5100
AR Path="/5E33BBDC/6083F216" Ref="R?"  Part="1" 
AR Path="/6083F216" Ref="R128"  Part="1" 
AR Path="/5E626C5F/6083F216" Ref="R?"  Part="1" 
AR Path="/5E635C99/6083F216" Ref="R?"  Part="1" 
F 0 "R128" V 4300 5250 50  0000 C CNN
F 1 "SOT" V 4300 5100 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4400 5100 50  0001 C CNN
F 3 "" H 4400 5100 50  0001 C CNN
	1    4400 5100
	0    -1   1    0   
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 6083F21C
P 4400 5250
AR Path="/5E33BBDC/6083F21C" Ref="R?"  Part="1" 
AR Path="/6083F21C" Ref="R129"  Part="1" 
AR Path="/5E626C5F/6083F21C" Ref="R?"  Part="1" 
AR Path="/5E635C99/6083F21C" Ref="R?"  Part="1" 
F 0 "R129" V 4300 5400 50  0000 C CNN
F 1 "SOT" V 4300 5250 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4400 5250 50  0001 C CNN
F 3 "" H 4400 5250 50  0001 C CNN
	1    4400 5250
	0    -1   1    0   
$EndComp
Wire Wire Line
	4150 5100 4300 5100
Wire Wire Line
	4500 5100 4900 5100
Wire Wire Line
	4500 5250 4900 5250
Wire Wire Line
	3400 5250 4150 5250
Wire Wire Line
	4150 5100 4150 5250
Connection ~ 4150 5250
Wire Wire Line
	4150 5250 4300 5250
Text Label 4900 5100 2    50   ~ 0
as_ncs_1
Text Label 4900 5250 2    50   ~ 0
as_ncs_2
$Comp
L Device:R_Small_US R?
U 1 1 60855944
P 4250 5500
AR Path="/5E33BBDC/60855944" Ref="R?"  Part="1" 
AR Path="/60855944" Ref="R126"  Part="1" 
AR Path="/5E626C5F/60855944" Ref="R?"  Part="1" 
AR Path="/5E635C99/60855944" Ref="R?"  Part="1" 
F 0 "R126" V 4150 5650 50  0000 C CNN
F 1 "SOT" V 4150 5500 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4250 5500 50  0001 C CNN
F 3 "" H 4250 5500 50  0001 C CNN
	1    4250 5500
	0    -1   1    0   
$EndComp
$Comp
L Device:R_Small_US R?
U 1 1 6085594A
P 4250 5650
AR Path="/5E33BBDC/6085594A" Ref="R?"  Part="1" 
AR Path="/6085594A" Ref="R127"  Part="1" 
AR Path="/5E626C5F/6085594A" Ref="R?"  Part="1" 
AR Path="/5E635C99/6085594A" Ref="R?"  Part="1" 
F 0 "R127" V 4150 5800 50  0000 C CNN
F 1 "SOT" V 4150 5650 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 4250 5650 50  0001 C CNN
F 3 "" H 4250 5650 50  0001 C CNN
	1    4250 5650
	0    -1   1    0   
$EndComp
Wire Wire Line
	4000 5500 4150 5500
Wire Wire Line
	4150 5650 4000 5650
Wire Wire Line
	4350 5500 4750 5500
Wire Wire Line
	4350 5650 4750 5650
Wire Wire Line
	3750 5350 4000 5350
Wire Wire Line
	4000 5350 4000 5500
Connection ~ 4000 5500
Wire Wire Line
	4000 5500 4000 5650
Text Label 4750 5500 2    50   ~ 0
as_dclk_1
Text Label 4750 5650 2    50   ~ 0
as_dclk_2
$Comp
L Device:C_Small C?
U 1 1 608B9A6D
P 2900 4250
AR Path="/5E33BBDC/608B9A6D" Ref="C?"  Part="1" 
AR Path="/608B9A6D" Ref="C109"  Part="1" 
AR Path="/5E635C99/608B9A6D" Ref="C?"  Part="1" 
AR Path="/5E626C5F/608B9A6D" Ref="C?"  Part="1" 
F 0 "C109" H 2992 4296 50  0000 L CNN
F 1 "0.1uF" H 2992 4205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 2900 4250 50  0001 C CNN
F 3 "732-7487-1-ND" H 2900 4250 50  0001 C CNN
	1    2900 4250
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 608B9A73
P 3150 4250
AR Path="/5E33BBDC/608B9A73" Ref="C?"  Part="1" 
AR Path="/608B9A73" Ref="C110"  Part="1" 
AR Path="/5E635C99/608B9A73" Ref="C?"  Part="1" 
AR Path="/5E626C5F/608B9A73" Ref="C?"  Part="1" 
F 0 "C110" H 3242 4296 50  0000 L CNN
F 1 "0.1uF" H 3242 4205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0402_1005Metric" H 3150 4250 50  0001 C CNN
F 3 "732-7487-1-ND" H 3150 4250 50  0001 C CNN
	1    3150 4250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 608B9A79
P 2650 4350
AR Path="/5E33BBDC/608B9A79" Ref="#PWR?"  Part="1" 
AR Path="/608B9A79" Ref="#PWR0134"  Part="1" 
AR Path="/5E635C99/608B9A79" Ref="#PWR?"  Part="1" 
AR Path="/5E626C5F/608B9A79" Ref="#PWR?"  Part="1" 
F 0 "#PWR0134" H 2650 4100 50  0001 C CNN
F 1 "GND" H 2655 4177 50  0000 C CNN
F 2 "" H 2650 4350 50  0001 C CNN
F 3 "" H 2650 4350 50  0001 C CNN
	1    2650 4350
	1    0    0    -1  
$EndComp
$Comp
L power:+3V0 #PWR?
U 1 1 608B9A7F
P 2650 4150
AR Path="/5E33BBDC/608B9A7F" Ref="#PWR?"  Part="1" 
AR Path="/608B9A7F" Ref="#PWR0135"  Part="1" 
AR Path="/5E635C99/608B9A7F" Ref="#PWR?"  Part="1" 
AR Path="/5E626C5F/608B9A7F" Ref="#PWR?"  Part="1" 
F 0 "#PWR0135" H 2650 4000 50  0001 C CNN
F 1 "+3V0" H 2665 4323 50  0000 C CNN
F 2 "" H 2650 4150 50  0001 C CNN
F 3 "" H 2650 4150 50  0001 C CNN
	1    2650 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 4350 2900 4350
Wire Wire Line
	2900 4350 3150 4350
Wire Wire Line
	2650 4150 2900 4150
Wire Wire Line
	2900 4150 3150 4150
Connection ~ 2900 4350
Connection ~ 2900 4150
$Comp
L Device:C_Small C?
U 1 1 608B9A8B
P 2650 4250
AR Path="/5E33BBDC/608B9A8B" Ref="C?"  Part="1" 
AR Path="/608B9A8B" Ref="C108"  Part="1" 
AR Path="/5E635C99/608B9A8B" Ref="C?"  Part="1" 
AR Path="/5E626C5F/608B9A8B" Ref="C?"  Part="1" 
F 0 "C108" H 2742 4296 50  0000 L CNN
F 1 "4.7uF" H 2742 4205 50  0000 L CNN
F 2 "Capacitor_SMD:C_0603_1608Metric" H 2650 4250 50  0001 C CNN
F 3 "1276-1044-1-ND" H 2650 4250 50  0001 C CNN
	1    2650 4250
	1    0    0    -1  
$EndComp
Connection ~ 2650 4150
Connection ~ 2650 4350
$Comp
L Device:R_Small_US R?
U 1 1 60A41331
P 5200 4050
AR Path="/5E33BBDC/60A41331" Ref="R?"  Part="1" 
AR Path="/60A41331" Ref="R133"  Part="1" 
AR Path="/5E626C5F/60A41331" Ref="R?"  Part="1" 
AR Path="/5E635C99/60A41331" Ref="R?"  Part="1" 
F 0 "R133" V 5000 4050 50  0000 C CNN
F 1 "25R" V 5100 4050 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 5200 4050 50  0001 C CNN
F 3 "" H 5200 4050 50  0001 C CNN
	1    5200 4050
	0    -1   1    0   
$EndComp
Wire Wire Line
	5100 4050 4800 4050
Text Label 5050 1650 0    50   ~ 0
clk
$Comp
L Device:R_Small_US R?
U 1 1 60A677DB
P 5450 1650
AR Path="/5E33BBDC/60A677DB" Ref="R?"  Part="1" 
AR Path="/60A677DB" Ref="R134"  Part="1" 
AR Path="/5E626C5F/60A677DB" Ref="R?"  Part="1" 
AR Path="/5E635C99/60A677DB" Ref="R?"  Part="1" 
F 0 "R134" V 5350 1850 50  0000 C CNN
F 1 "25R" V 5350 1650 50  0000 C CNN
F 2 "Resistor_SMD:R_0402_1005Metric" H 5450 1650 50  0001 C CNN
F 3 "" H 5450 1650 50  0001 C CNN
	1    5450 1650
	0    -1   1    0   
$EndComp
Wire Wire Line
	5350 1650 5050 1650
Wire Wire Line
	5550 1650 6000 1650
$EndSCHEMATC
