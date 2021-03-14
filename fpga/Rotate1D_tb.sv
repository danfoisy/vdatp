`timescale 1 ps / 1 ps
module Rotate1D_tb (
	output   reg	clk,
	output [12:0] result
);

initial #0 begin

    		clk=0;
end

always begin
	#10 	clk=!clk;
end

	
Rotate1D #(.POS_BIT_SIZE(13)) rotate(
	.clk,
	
	.x(13'sd70),
	.y(13'sd70),
	.z(13'sd0),
	
	.coeff1(8'sd89),
	.coeff2(-8'sd90),
	.coeff3(8'd0),
	
	.translate(13'sd100),
	
	.result 
 
);

endmodule