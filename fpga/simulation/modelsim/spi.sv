`timescale 1 ps / 1 ps
module LedCtrl_tb (

		output   reg	clk
		
		
	);

	reg nReset;
	initial #0 begin

    		clk=0;
		nReset=1;
    	#30 	nReset=0;
	#50 	nReset=1;
  	end

  	always begin
    	#10 	clk=!clk;
  	end

	logic [15:0] spiBuf;
	logic ncs;
	logic mosi;

	
	initial #0 begin
		#0   ncs = '1;
		#100 ncs = '0;
		     mosi = '1;
		#20 mosi = '0;
		#20 mosi = '0;
		#20 mosi = '0;
		#20 mosi = '1;
		#20 mosi = '1;
		#20 mosi = '0;
		#20 mosi = '1;


		#20 mosi = '1;
		#20 mosi = '1;
		#20 mosi = '1;
		#20 mosi = '1;
		#20 mosi = '0;
		#20 mosi = '0;
		#20 mosi = '1;
		#20 mosi = '1;

		#20 ncs = '1;
	end
	
	SPI spi
	(
		.shiftin(mosi),
		.clock(clk),
		.enable(!ncs),
		.q(spiBuf)
	);
	
endmodule

