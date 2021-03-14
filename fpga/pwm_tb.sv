`timescale 1 ps / 1 ps
module pwm_tb (

		output   reg	clk,
		output out,
		output start
	);

	reg nReset;
	reg [8:0] cnt;
	initial #0 begin

    		clk=0;
		nReset=1;
    	#30 	nReset=0;
	#50 	nReset=1;
  	end

  	always begin
    	#10 	clk=!clk;
  	end

	PWM pwm(
		.clk,
		.nReset,
		.cnt,
		.phase(8'd125),
		.amp(7'd60),
		.out
	);
	

	always@(posedge clk) begin
		if(!nReset)
			cnt <= '0;
		else
			cnt <= cnt == 499 ? 0 : cnt + 1;
	end

	
	assign start = cnt==0;
	
endmodule



