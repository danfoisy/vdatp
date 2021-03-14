module Reset(
		input clk,
		output reg nReset
	);
	
	// reset logic
	reg [3:0] cnt;
	always_ff@(posedge clk) begin	: reset_logic
	
		if(cnt<4'd15) begin
			cnt <= cnt + 1'd1;
			nReset <= '0;
		end else begin
			nReset <= '1;
		end
	end
	
endmodule