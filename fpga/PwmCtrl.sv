 module PwmCtrl #(parameter NUM_CHANNELS, CLK_FREQ, OUT_FREQ ) (
		input clk,
		input nReset,
		input [$clog2(CLK_FREQ/OUT_FREQ)-1:0] phase [NUM_CHANNELS],
		input en[NUM_CHANNELS],
		
		input syncin,
		
		output [NUM_CHANNELS-1:0] out,
		output cycleStart
	);

	localparam CLK_CNT_MAX = CLK_FREQ/OUT_FREQ;
	
	logic syncInSync;
	logic syncInSync_pipe;
	always @(posedge clk)
		{ syncInSync, syncInSync_pipe } <= { syncInSync_pipe, syncin };
		
	logic syncState;
	logic syncDetected;
	always@(posedge clk) begin
		if(!nReset) begin
				syncState <= '0;
				syncDetected <= '0;
			end
		else begin
			case(syncState) 
				0:
					begin
						syncDetected <= '0;
						if(syncInSync)
							syncState <= '1;
					end
				1:
					begin
						if(!syncInSync) begin
							syncState <= '0;
							syncDetected <= '1;
						end
					end
			endcase
		end
	end
		
	reg [$clog2(CLK_CNT_MAX)-1:0] cnt;
	
	always@(posedge clk) begin
		if(!nReset || syncDetected)
			cnt <= '0;
		else
			cnt <= cnt == CLK_CNT_MAX-1 ? CLK_CNT_MAX-1 : cnt + 1;
	end
	
	assign cycleStart = cnt == CLK_CNT_MAX-2;
	
	PWM #(.CLK_FREQ(CLK_FREQ), .OUT_FREQ(OUT_FREQ)) pwm[NUM_CHANNELS-1:0] (
		.clk,
		.nReset,
		.cnt,
		.phase,
		.en,
		.out
	);
	
	
endmodule

	
 