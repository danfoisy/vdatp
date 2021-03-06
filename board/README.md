# Board

Herein lives the Kicad schedmatics, PCB and BOM files.  If looking to replicate, I highly recommend you look at `errata.txt` for a list of mistakes I made that should be fixed on the next spin of the board.

Some notes:
- SPI goes to all 4 FPGAs simultaneously.  MISO is not used
- there are jumpers in place to allow the board to operate with only one FPGA installed (and only 50 transducers) but to run both FPGAs, the following jumpers must be configured:
-- R122, R123, R124, R126, R127, R128 <= populated
-- R125, R129 <= not populated
-- R105, R111, R113 <= not populated
-- R112 <= populated
- Raspberry Pi W installed on top board only. Top board needs 5V DC/DC converter populated, leave unpopulated on bottom board
-- Rasberry Pi header soldered on backside of Pi 
- U101 and U102 are soldered on top board (note errata on U101). Only U101 populated on bottom board
-- only simple twisted pair required for each RS485 connection
- LEDs only connect on top board (populate LED drivers and connectors)
- each board requires a max of 2A at 24V. No power sequencing required
- to allow the config device to program the FPGAs
-- JP201/JP202 must be left unpopulated
-- JP11001/JP11002 must be cut and msel0/1 must be connected to ground with jumper
- each FPGA must have jumpers configured to tell it which transducers it is responsible for
-- top board: populate R11004
-- bottom board: populate R11003, R203, R204
- original ultrasonic transducer is no available on aliexpress but https://manorshi.en.alibaba.com/product/60248714908-801018150/Manorshi_10mm_40khz_piezo_ultrasonic_Transmitter_Receiver_sensor.html should work but I've not tested (make sure to order the transmitter version)
- distance between boards is not super critical - mine are set up 145mm apart but other distance work just as well
- FPGAs can be programmed with a USB blaster type device.  I use https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No=46
-- all FPGAs get the same program
- the transducers have a polarity marked on them - but don't trust the markings as they are wrong much of the time.  As well, I've been informed that there are phase discrepancies inherent in most of these cheap transducers.  I corrected for polarity errors by testing each transducer individually but did not correct for phase errors - this may be the cause of some of the distortions I saw.  I did check for these phase discrepancies and found a maximum of about 3% phase error across the transducers.  I don't know if this is enough to cause serious distortions but it may be worthwhile for someone to investigate.  If this is of concern, a simple LUT can be implemented to compensate for these errors on a transducer by transducer basis
- running these boards at 15V causes the drivers to get really hot - I suggest running them at 10V.



