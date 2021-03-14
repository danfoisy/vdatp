`timescale 1 ps / 1 ps
module PwmCtrl_tb (

		output   reg	clk,
		output start
	);
	localparam NUM_CHANNELS = 16;

	logic [NUM_CHANNELS-1:0] out;

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


	
	/*logic [7:0] phase[NUM_CHANNELS] = '{
		8'd0,    8'd16,    8'd32,    8'd48,   8'd64,   8'd80,  8'd96,  8'd112,
		8'd128,    8'd144,    8'd160,    8'd176,   8'd192,   8'd208,  8'd224,  8'd240
	};*/

	logic [7:0] phase[NUM_CHANNELS] = '{
		8'd0,    8'd0,    8'd0,    8'd0,   8'd0,   8'd0,  8'd0,  8'd0,
		8'd0,    8'd0,    8'd0,    8'd0,   8'd0,   8'd0,  8'd0,  8'd0
	};

	logic [6:0] amp [NUM_CHANNELS] = '{
		7'd124,	7'd112,	7'd104,	7'd96,	7'd88,	7'd80,	7'd72,	7'd64,	
		7'd56,	7'd48,	7'd40,	7'd32,	7'd24,	7'd16,	7'd8,	7'd1
	};

	PwmCtrl #(.NUM_CHANNELS(NUM_CHANNELS)) pwmCtrl (
		.clk,
		.nReset,
		.phase,
		.amp,
		
		.out,
		.start
	);
	

	
endmodule
