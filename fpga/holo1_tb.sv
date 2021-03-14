`timescale 1 ps / 1 ps
module holo1_tb (

		output [49:0] t
	);
	
	reg clk;

	initial #0 begin

    		clk=0;
		
  	end

  	always begin
    	#10 	clk=!clk;
  	end


	holo1 holo(
		.CLK_24M576(clk),
	
		.t
	);	
endmodule