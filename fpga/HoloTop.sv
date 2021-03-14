 module HoloTop (
	input CLK_24M576,
	
	output [49:0] t,
	
	output blue,
	output green,
	output red,
	
	input mosi,
	input sck,
	input ncs,
	
	output syncout,
	input syncin,
	
	input top,
	input left
 );
 
	localparam IN_CLK_FREQ = 24576000;
	localparam CLK_FREQ = 20480000;
	localparam OUT_FREQ = 40000;
	localparam NUM_CHANNELS = 50;
	
	logic clk;
	logic nReset;
	logic mathClk;
	Pll pll(
		.inclk0(CLK_24M576),
		.c0(clk),
		.c1(mathClk)
	);
	
	Reset reset(
		.clk,
		.nReset
	);
		
	logic [2:0] LEDpwm;
	assign red   =	LEDpwm[0];
	assign green = LEDpwm[1];
	assign blue  =	LEDpwm[2];
	
	//generate syncout signal
	localparam CLK_CNT_MAX = CLK_FREQ/OUT_FREQ;
	reg [$clog2(CLK_CNT_MAX)-1:0] cnt;
	always@(posedge clk) begin
		if(!nReset) begin
				cnt <= '0;
				syncout <= '0;
			end
		else begin
			cnt <= cnt == (CLK_CNT_MAX-1) ? 0 : cnt + 1;
			syncout <= (cnt < CLK_CNT_MAX/2) ? '1 : '0;
		end
	end
	
	Holo #(.CLK_FREQ(CLK_FREQ), .OUT_FREQ(OUT_FREQ), .NUM_CHANNELS(NUM_CHANNELS)) holo(
		.clk,
		.nReset,
		.mathClk(clk),
		
		.t,
		.LEDpwm,
		
		.mosi,
		.sck,
		.ncs,
		
		.syncin,
		.top,
		.left
	);
 
 endmodule
 