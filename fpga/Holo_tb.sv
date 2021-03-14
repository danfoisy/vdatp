`timescale 1 ps / 1 ps
module Holo_tb (

		output   reg	clk,
		output [49:0] t
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



	Holo holo(
		.clk,
		.nReset,
	
		.t
 	);	
endmodule