#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import math
from pcbnew import *

pcb = GetBoard()

ToUnits = ToMM
FromUnits = FromMM

NumDrivers = 100
Width = 10
StartSheet = 7
TransducerDiameter = 10
TextDim = 0.6

def place():
	for i in range(NumDrivers):
		sheetPrefix = str(StartSheet + i)

		positionTransducer(i, sheetPrefix)
		positionDriver(i, sheetPrefix)
		positionSmallCap(i, sheetPrefix)
		positionLargeCap(i, sheetPrefix)

	Refresh()

def positionTransducer(i, sheetPrefix):
	transducerRef = "LS" + sheetPrefix + "01"
	transducer = pcb.FindModuleByReference(transducerRef)
	
	y = math.floor(i / Width) * TransducerDiameter
	x = (i % Width) * TransducerDiameter
	transducer.SetPosition(wxPoint(FromUnits(x), FromUnits(y)))
	
	ref = transducer.Reference()
	ref.SetTextAngle(0)
	ref.SetPosition(wxPoint(FromUnits(x - TransducerDiameter/2), FromUnits(y - TransducerDiameter/2 + TextDim ))) 
	ref.SetTextHeight(FromUnits(TextDim))
	ref.SetTextWidth(FromUnits(TextDim))
	
	transducer.SetLocked(True)
	
def positionDriver(i, sheetPrefix):
	driverRef = "U" + sheetPrefix + "01"
	driver = pcb.FindModuleByReference(driverRef)
	
	y = math.floor(i / Width) * TransducerDiameter +5.035
	x = (i % Width) * TransducerDiameter + 0.65
	driver.SetPosition(wxPoint(FromUnits(x), FromUnits(y)))
	driver.Flip(wxPoint(FromUnits(x), FromUnits(y)))
	driver.SetOrientation(90*10.0)
	
	ref = driver.Reference()
	ref.SetTextAngle(90 * 10)
	ref.SetPosition(wxPoint(FromUnits(x), FromUnits(y + 4.07))) 
	ref.SetTextHeight(FromUnits(TextDim))
	ref.SetTextWidth(FromUnits(TextDim))
	
	driver.SetLocked(True)
	

def positionSmallCap(i, sheetPrefix):
	capRef = "C" + sheetPrefix + "02"
	cap = pcb.FindModuleByReference(capRef)
	
	y = math.floor(i / Width) * TransducerDiameter + 4.9
	x = (i % Width) * TransducerDiameter -3.05
	cap.SetPosition(wxPoint(FromUnits(x), FromUnits(y)))
	cap.Flip(wxPoint(FromUnits(x), FromUnits(y)))
	cap.SetOrientation(-90*10.0)
	
	ref = cap.Reference()
	ref.SetTextAngle(0)
	ref.SetPosition(wxPoint(FromUnits(x - 0.94), FromUnits(y - 3.5))) 
	ref.SetTextHeight(FromUnits(TextDim))
	ref.SetTextWidth(FromUnits(TextDim))
	
	cap.SetLocked(True)

def positionLargeCap(i, sheetPrefix):
	capRef = "C" + sheetPrefix + "01"
	cap = pcb.FindModuleByReference(capRef)
	
	y = math.floor(i / Width) * TransducerDiameter + 5.34
	x = (i % Width) * TransducerDiameter - 5.15
	cap.SetPosition(wxPoint(FromUnits(x), FromUnits(y)))
	cap.Flip(wxPoint(FromUnits(x), FromUnits(y)))
	cap.SetOrientation(-90*10.0)
	
	ref = cap.Reference()
	ref.SetTextAngle(0)
	ref.SetPosition(wxPoint(FromUnits(x), FromUnits(y - 3.8 ))) 
	ref.SetTextHeight(FromUnits(TextDim))
	ref.SetTextWidth(FromUnits(TextDim))
	
	cap.SetLocked(True)
	
	
	
# def getDriverAngle(idx):
    # if(idx < NumDrivers/2):
        # angle = 90.0 + HalfAngle / (NumDrivers/2.0) * idx + HalfAngle / (NumDrivers/2.0) / 2
    # else:
        # #angle = 90.0 - HalfAngle / (NumDrivers/2.0) * (idx - NumDrivers/2.0 + 1) + HalfAngle / (NumDrivers/2.0) / 2 - (HalfAngle / (NumLEDs/2.0) )
        # angle = 90.0 - HalfAngle / (NumDrivers/2.0) * (idx - NumDrivers/2.0 + 1) + HalfAngle / (NumDrivers/2.0) / 2  - (HalfAngle / (NumLEDs/2.0)/2 )
    # return angle

# def positionCap(idx, sheetName):
    # angle = getDriverAngle(idx)

    # if(idx % 2):
        # part1 = pcb.FindModuleByReference("C" + sheetName + "06")
        # part2 = pcb.FindModuleByReference("C" + sheetName + "10")
    # else:
        # part1 = pcb.FindModuleByReference("C" + sheetName + "01")
        # part2 = pcb.FindModuleByReference("C" + sheetName + "05")

    # x1 = math.cos(math.radians(angle-CapAngle)) * CapRadius + CenterX
    # y1 = -math.sin(math.radians(angle-CapAngle)) * CapRadius + CenterY
    # part1.SetPosition(wxPoint(FromUnits(x1), FromUnits(y1)))
    # part1.SetOrientation((angle+180) * 10.0)
    # part1.SetLocked(True)

    # x2 = math.cos(math.radians(angle+CapAngle)) * CapRadius + CenterX
    # y2 = -math.sin(math.radians(angle+CapAngle)) * CapRadius + CenterY
    # part2.SetPosition(wxPoint(FromUnits(x2), FromUnits(y2)))
    # part2.SetOrientation((angle+180) * 10.0)
    # part2.SetLocked(True)

# def positionDriver(idx, partName):
    
    # part = pcb.FindModuleByReference(partName)
    # angle = getDriverAngle(idx)

    # if(idx < NumDrivers/2):
        # part.SetOrientation((angle+90.0)*10.0)
    # else:
        # part.SetOrientation((angle+90.0) *10.0)

    
    # angleRad = math.radians(angle)

    # x = math.cos(angleRad) * DriverRadius + CenterX
    # y = -math.sin(angleRad) * DriverRadius + CenterY

    
    # part.SetPosition(wxPoint(FromUnits(x), FromUnits(y)))
    # part.SetLocked(True)
    

# def positionLED(idx, partName):
    # if idx < NumLEDs/2:
        # angle =  90.0 + HalfAngle / (NumLEDs/2.0) * idx
    # else:
        # angle = 90.0 - HalfAngle / (NumLEDs/2.0) * (((math.floor(idx/16)+1)*16 - idx % 16) - NumLEDs/2.0) - (HalfAngle / (NumLEDs/2.0) / 2 )

    # angleRad = math.radians(angle)

    # x = math.cos(angleRad) * Radius + CenterX
    # y = -math.sin(angleRad) * Radius + CenterY

    # part = pcb.FindModuleByReference(partName)
    # part.SetPosition(wxPoint(FromUnits(x), FromUnits(y)))
    # part.SetOrientation((angle-90.0)*10.0)
    # part.SetLocked(True)

    # ref = part.Reference()
    # ref.SetKeepUpright(False)
    # ref.SetTextAngle(900)

    # xr = math.cos(angleRad) * (Radius - CompHeight) + CenterX
    # yr = -math.sin(angleRad) * (Radius - CompHeight) + CenterY
    # ref.SetPosition(wxPoint(FromUnits(xr), FromUnits(yr))) 

    # ref.SetTextHeight(FromUnits(0.6))
    # ref.SetTextWidth(FromUnits(0.6))

    # #print "> Part %d: %f %s at %s"%(idx, angle, part.GetReference(),part.GetPosition())









