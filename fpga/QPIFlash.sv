module QPIFlash(
	input clk,
	input nReset,
	
	output reg f_sck,
	inout [3:0] f_io,
	output reg f_ncs,
	
	input [7:0] writeData,
	output reg [7:0] readData,
	output reg rdRdy,
	input fifoWrReq,
	input fifoClr,
	
	output reg busy,
	input [2:0] cmd,
	input [15:0] page
	
);
	
	
	
	logic [3:0] commState;
	logic done;
	logic send;
	logic receive;
	logic [7:0] dataOutShift;
	logic [7:0] dataOut;
	logic [7:0] dataIn;
	logic [3:0] dataInHi;
	
	logic fifoRdReq;
	logic fifoFull;
	logic fifoEmpty;
	logic [7:0] fifoQ;
	
	logic [5:0] state;
		
	assign f_ncs = !((commState == 1 || commState == 2) || ((commState == 3 || commState == 4) && receive)) ;
	assign f_sck = !clk && !f_ncs;
 	assign f_io = (commState == 1 || commState == 2) ? dataOutShift[7:4] : 4'bZ;
	
	assign busy = state != 0 || commState != 0;
	assign dataIn = {dataInHi, f_io};
	
	always@(posedge clk) begin
		if(!nReset) begin
			commState <= '0;
			done <= '0;
		end else begin
			case (commState) 
				0: 
					begin
						done <= '0;
						if(send) begin
							dataOutShift <= dataOut;
							commState <= 1;
						end
					end
				1:
					begin
						dataOutShift <= dataOutShift << 4;
						done <= '1;
						commState <= 2;
					end
				2:
					begin
						done <= '0;
						if(receive)
							commState <= 3;
						else if(send) begin
								dataOutShift <= dataOut;
								commState <= 1;
							end
						else
							commState <= 0;
					end
				3:
					begin
						commState <= receive ? 4 : 0;
						done <= receive ? 1 : 0;
						dataInHi <= f_io;
					end
				4:
					begin
						
						done <= 0;
						commState <= 3;
					end	
			endcase
		end
	
	end

	localparam CMD_NOOP  =			3'd0;
	localparam CMD_ERASE = 			3'd1;
	localparam CMD_WRITE = 			3'd2;
	localparam CMD_READ	=			3'd3;
	localparam CMD_BLOCK_ERASE = 	3'd4;
	
	localparam FLASH_WREN 			= 	8'h06;
	localparam FLASH_CHIP_ERASE 	= 	8'h60;
	localparam FLASH_BLOCK_ERASE 	= 	8'hdc;
	localparam FLASH_PAGE_PROGRAM = 	8'h12;
	localparam FLASH_PAGE_READ		=	8'hec;
	localparam FLASH_READ_SR1 		=	8'h05;

	logic [3:0] cnt;
	
	
	
	always@(posedge clk) begin
		if(!nReset) begin
			state <= 0;
			fifoRdReq <= '0;
		end else begin
			case(state)
				0:
					begin
						rdRdy <= '0;
						case(cmd)
							CMD_ERASE:
								state <= 1;
							CMD_BLOCK_ERASE:
								state <= 10;
							CMD_WRITE:
								state <= 18;
							CMD_READ:
								state <= 30;
							
						endcase
					end
				
				1:	//CHIP_ERASE
					begin
						dataOut <= FLASH_WREN;
						send <= '1;
						state <= 2;
					end
				2:
					begin
						send <= '0;
						if(done) begin
							dataOut <= FLASH_CHIP_ERASE;
							send <= '1;
							state <= 3;
						end
					end
				3:
					begin
						send <= '0;
						if(done)
							state <= 4;
					end
					
				4:	//wait for write in progress
					begin
						dataOut <= FLASH_READ_SR1;
						send <= '1;
						state<= 5;
					end
				5:
					begin
						send <= '0;
						receive <= '1;
						if(done)
							state <= 6;
					end
				6:
					begin
						if(done) begin
							if(dataIn[0] == 0) begin
								receive <= '0;
								state <= '0;
							end
						end
					end
					
					
				10:	//block erase
					begin
						dataOut <= FLASH_WREN;
						send <= '1;
						state <= 11;
					end
				11:
					begin
						send <= '0;
						if(done) begin
							dataOut <= FLASH_BLOCK_ERASE;
							send <= '1;
							state <= 12;
						end
					end
				12:
					begin
						dataOut <= '0;
						if(done)
							state <= 13;
					end
				13:
					begin
						dataOut <= page[15:8];
						if(done)
							state <= 14;
					end
				14:
					begin
						dataOut <= page[7:0];
						if(done)
							state <= 15;
					end
				15:
					begin
						dataOut <= '0;
						if(done) begin
							send <= '0;
							state <= 16;
						end
					end
				16:
					state <= 4;
					
				
				18:	//Page program
					begin
						dataOut <= FLASH_WREN;
						send <= '1;
						state <= 19;
					end
				19:
					begin
						send <= '0;
						if(done) begin
							dataOut <= FLASH_PAGE_PROGRAM;
							send <= '1;
							state <= 20;
						end
					end
				20:
					begin
						dataOut <= '0;
						if(done)
							state <= 21;
					end
				21:
					begin
						dataOut <= page[15:8];
						if(done)
							state <= 22;
					end
				22:
					begin
						dataOut <= page[7:0];
						if(done)
							state <= 23;
					end
				23:
					begin
						dataOut <= '0;
						if(done) 
							state <= 24;
					end
				24:
					begin
						dataOut <= fifoQ;
						fifoRdReq <= '1;
						state <= 25;
					end
				25:
					begin
						fifoRdReq <= '0;
						
						if(fifoEmpty) 
							send <= '0;
								
						if(done) begin
							if(fifoEmpty) begin
								state <= 26;
							end else begin
								state <= 24;
							end
						end
					end
				26:
					state <= 4;
					
				30:	//read page
					begin
						dataOut <= FLASH_PAGE_READ;
						send <= '1;
						state <= 31;
					end
				31:
					begin
						dataOut <= '0;
						if(done)
							state <= 32;
					end
				32:
					begin
						dataOut <= page[15:8];
						if(done)
							state <= 33;
					end
				33:
					begin
						dataOut <= page[7:0];
						if(done)
							state <= 34;
					end
				34:
					begin
						dataOut <= '0;
						if(done) begin 
							state <= 35;
						end
					end
				35:
					begin
						dataOut <= 8'h00;		//mode
						if(done) begin 
							state <= 36;
						end
					end
				36:
					begin
						if(done) begin
							cnt <= '0;
							send <= '0;
							receive <= '1;
							state <= 37;
						end
					end
				37:
					begin
						
						if(done) begin
							cnt <= cnt + 1;
							if(cnt== 2) begin
								state <= 38;
								
							end
						end
					end
				38:
					if(done)
						state <= 39;
				39:
					begin
						rdRdy <= '0;
						if(done) begin
							readData <= dataIn;
							rdRdy <= '1;
							if(cmd != CMD_READ) begin
								receive <= '0;
								state <= '0;
							end 
						end
					end
			endcase
		end
	end
	

	
	FlashFifo flashFifo(
		.clock(clk),
		.data(writeData),
		.rdreq(fifoRdReq),
		.wrreq(fifoWrReq),
		.empty(fifoEmpty),
		.full(fifoFull),
		.q(fifoQ),
		.aclr(fifoClr)
	);
endmodule


	