`timescale 1 ps / 1 ps
module CalcPhase_tb (

		output   reg	clk
	);
	
	localparam NUM_CHANNELS = 50;
	localparam CLK_FREQ = 20480000;//61440000;
	localparam OUT_FREQ = 40000;
	localparam POS_BIT_SIZE = 13;
	localparam PHASE_BIT_SIZE = $clog2(CLK_FREQ/OUT_FREQ);

	reg nReset;
	reg start;
	initial #0 begin

    		clk=0;
		nReset=1;
    	#30 	nReset=0;
	#50 	nReset=1;
  	end

	initial #0 begin
	#0	start=0;
	#100	start=1;
	#20	start=0;
	end

  	always begin
    	#10 	clk=!clk;
  	end

	logic [PHASE_BIT_SIZE-1:0] phase [NUM_CHANNELS];
	logic done;

	CalcPhase #(.NUM_CHANNELS(NUM_CHANNELS), .MAX_PHASE_CNT(CLK_FREQ/OUT_FREQ), .POS_BIT_SIZE(POS_BIT_SIZE), .PHASE_BIT_SIZE(PHASE_BIT_SIZE)) calcPhase(
		.clk,
		.nReset,
		.x(13'd100),
		.y(13'd0),
		.z(13'd0),
		.XZradiusSquared(23'd200000),
		.halfHeight(13'd1000),
		.start,
		.phase,
		.done,
		.top('1),
		.left('1)
	);	
endmodule
