module LED #(parameter CLK_FREQ = 20480000, OUT_FREQ = 100000)(
	input 		clk,
	input			nReset,
	input	[7:0]	duty,
	input 		LEDen,
	output 		out
);

	localparam CLK_CNT_MAX = CLK_FREQ/OUT_FREQ;
	
	reg [$clog2(CLK_CNT_MAX)-1:0] cnt;
	
	always@(posedge clk) begin
		if(!nReset )
			cnt <= '0;
		else
			cnt <= cnt == CLK_CNT_MAX-1 ? 0 : cnt + 1;
	end
	
	assign out = duty > cnt && LEDen;

endmodule