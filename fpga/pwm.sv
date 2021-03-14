module PWM #(parameter CLK_FREQ , OUT_FREQ) (	
		input 		clk,
		input 		nReset,
		input	[$clog2(CLK_FREQ/OUT_FREQ)-1:0] cnt,
		input [$clog2(CLK_FREQ/OUT_FREQ)-1:0]	phase,	//0-511
		input 		en,
		output 		out
	);
	
	localparam CLK_CNT_MAX = CLK_FREQ/OUT_FREQ;		//512

	logic [$clog2(CLK_CNT_MAX)-1:0] endCnt;
	logic outRaw;	

	assign endCnt = phase + CLK_CNT_MAX/2;
	assign out = outRaw & en;

	always@(posedge clk) begin
		if(!nReset)
			outRaw <= '0;
		else begin
			if(!outRaw)
				outRaw <= cnt == phase;
			else
				outRaw <= !(cnt == endCnt);
		end
		
	end
	
endmodule
