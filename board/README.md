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
- each board requires a max of 2A at 24V
- to allow the config device to program the FPGAs
-- JP201/JP202 must be left unpopulated
-- JP11001/JP11002 must be cut and msel0/1 must be connected to ground with jumper
- each FPGA must have jumpers configured to tell it which transducers it is responsible for
-- top board: populate R11004
-- bottom board: populate R11003, R203, R204


