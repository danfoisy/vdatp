module Rotate1D #(parameter POS_BIT_SIZE) (
	input clk,
	
	input [POS_BIT_SIZE-1:0] x,
	input [POS_BIT_SIZE-1:0] y,
	input [POS_BIT_SIZE-1:0] z,
	
	input [7:0] coeff1,
	input [7:0] coeff2,
	input [7:0] coeff3,
	
	input [POS_BIT_SIZE-1:0] translate,
	
	output [POS_BIT_SIZE-1:0] result 
 
);
	logic [20:0] mult1;
	logic [20:0] mult2;
	logic [20:0] mult3;

	//clk 1
	CoeffMult coeff1Mult(
		.clock(clk),
		.dataa(x),
		.datab(coeff1),
		.result(mult1)
	);
	
	CoeffMult coeff2Mult(
		.clock(clk),
		.dataa(y),
		.datab(coeff2),
		.result(mult2)
	);
	
	CoeffMult coeff3Mult(
		.clock(clk),
		.dataa(z),
		.datab(coeff3),
		.result(mult3)
	);
	
	
	logic cout;
	logic [20:0] add1;
	logic [20:0] add2;
	
	//clk2
	CoeffAdd coeffAdd1(
		.cin(0),
		.clock(clk),
		.dataa(mult1),
		.datab(mult2),
		.cout,
		.result(add1)
	);
	
	//clk3
	CoeffAdd coeffAdd2(
		.cin(cout),
		.clock(clk),
		.dataa(add1),
		.datab(mult3),
		.result(add2)
	);
	
	//clk4
	lpm_add_sub #(.lpm_width(POS_BIT_SIZE), .lpm_direction("ADD"), .lpm_pipeline(1)) 
		resultOp(
			.clock(clk),
			.dataa(add2 >>> (21-POS_BIT_SIZE-1)),
			.datab(translate),
			.result(result)
	);

endmodule

