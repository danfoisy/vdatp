module CalcPhase #(parameter NUM_CHANNELS, MAX_PHASE_CNT, POS_BIT_SIZE, PHASE_BIT_SIZE) (
		input clk,
		input nReset,
		input [POS_BIT_SIZE-1:0] x,
		input [POS_BIT_SIZE-1:0] y,
		input [POS_BIT_SIZE-1:0] z,
		
		input start,
		
		input [POS_BIT_SIZE-1:0] halfHeight,
		input [22:0] XZradiusSquared,
		
		output reg [$clog2(MAX_PHASE_CNT)-1:0] phase [NUM_CHANNELS],
		output reg  phaseEnabled [NUM_CHANNELS],
		output reg done,
		
		input top,
		input left,
		input cycleStart
	);
	
	localparam NEG_WAVE_K_DIV10 = 32'hBD96104F; 	//(2*M_PI*PIEZO_FREQ/(1000*WAVE_C)) /10   <= /10 'cause input units are in tenths of a millimeter
	
	localparam SCALE_CNST = 32'h42A2F983;				//MAX_PHASE_CNT / (2*3.14159)   MAX_PHASE_CNT=512
	//localparam SCALE_CNST = 32'h43747645;				//MAX_PHASE_CNT / (2*3.14159)   MAX_PHASE_CNT=1536
	
	typedef logic [31:0] float;
	

	
	
	//note all units in 0.1mm units
		
	logic [POS_BIT_SIZE-1:0] xTransducerLeftTop [NUM_CHANNELS] = '{
		450,	450,	450,	450,	450,	450,	450,	450,	450,	450,	
		350,	350,	350,	350,	350,	350,	350,	350,	350,	350,	
		250,	250,	250,	250,	250,	250,	250,	250,	250,	250,	
		150,	150,	150,	150,	150,	150,	150,	150,	150,	150,	
		50,	50,	50,	50,	50,	50,	50,	50,	50,	50
	};
	
	logic [POS_BIT_SIZE-1:0] xTransducerRightTop [NUM_CHANNELS] = '{
		-50,	-50,	-50,	-50,	-50,	-50,	-50,	-50,	-50,	-50,	
		-150,	-150,	-150,	-150,	-150,	-150,	-150,	-150,	-150,	-150,	
		-250,	-250,	-250,	-250,	-250,	-250,	-250,	-250,	-250,	-250,	
		-350,	-350,	-350,	-350,	-350,	-350,	-350,	-350,	-350,	-350,	
		-450,	-450,	-450,	-450,	-450,	-450,	-450,	-450,	-450,	-450
	};
		
	logic [POS_BIT_SIZE-1:0] xTransducerRightBottom [NUM_CHANNELS] = '{
		-450,	-450,	-450,	-450,	-450,	-450,	-450,	-450,	-450,	-450,	
		-350,	-350,	-350,	-350,	-350,	-350,	-350,	-350,	-350,	-350,	
		-250,	-250,	-250,	-250,	-250,	-250,	-250,	-250,	-250,	-250,	
		-150,	-150,	-150,	-150,	-150,	-150,	-150,	-150,	-150,	-150,	
		-50,	-50,	-50,	-50,	-50,	-50,	-50,	-50,	-50,	-50
	};	
		
	logic [POS_BIT_SIZE-1:0] xTransducerLeftBottom [NUM_CHANNELS] = '{
		50,	50,	50,	50,	50,	50,	50,	50,	50,	50,	
		150,	150,	150,	150,	150,	150,	150,	150,	150,	150,	
		250,	250,	250,	250,	250,	250,	250,	250,	250,	250,	
		350,	350,	350,	350,	350,	350,	350,	350,	350,	350,	
		450,	450,	450,	450,	450,	450,	450,	450,	450,	450
	};	
		

	logic [POS_BIT_SIZE-1:0] zTransducer [NUM_CHANNELS] = '{
		-450,	-350,	-250,	-150,	-50,	50,	150,	250,	350,	450,	
		-450,	-350,	-250,	-150,	-50,	50,	150,	250,	350,	450,	
		-450,	-350,	-250,	-150,	-50,	50,	150,	250,	350,	450,	
		-450,	-350,	-250,	-150,	-50,	50,	150,	250,	350,	450,	
		-450,	-350,	-250,	-150,	-50,	50,	150,	250,	350,	450
	};

	logic [$clog2(NUM_CHANNELS) : 0] idx;
	logic [5:0] state;
	

	
	//------------------------------------------------------------------------------------------------
	logic [POS_BIT_SIZE-1:0] xDiff, yDiff, zDiff;
	
	//xDiff
	lpm_add_sub #(.lpm_width(POS_BIT_SIZE), .lpm_direction("SUB"), .lpm_pipeline(1)) 
		xSubOp(
			.clock(clk),
			.dataa(x),
			.datab( !top ? 
								left ? xTransducerLeftTop[idx] : xTransducerRightTop[idx]
							:
								left ? xTransducerLeftBottom[idx] : xTransducerRightBottom[idx]
					),
			.result(xDiff)
	);
	
	//yDiff
	lpm_add_sub #(.lpm_width(POS_BIT_SIZE), .lpm_direction("SUB"), .lpm_pipeline(1)) 
		ySubOp(
			.clock(clk),
			.dataa(y),
			//.datab(yTransducer[top]),
			.datab(!top ? halfHeight : -halfHeight),
			.result(yDiff)
	);
	
	//zDiff
	lpm_add_sub #(.lpm_width(POS_BIT_SIZE), .lpm_direction("SUB"), .lpm_pipeline(1)) 
		zSubOp(
			.clock(clk),
			.dataa(z),
			.datab(zTransducer[idx]),
			.result(zDiff)
	);
	
	
	//------------------------------------------------------------------------------------------------
	logic [22:0] xSqr, ySqr, zSqr;
	
	//xDiff * xDiff
	altsquare #(.data_width(POS_BIT_SIZE), .result_width(23), .pipeline(1), .representation("SIGNED")) 
		xSqrOp(
			.clock(clk),
			.data(xDiff),
			.result(xSqr),
			.aclr (1'b0),
			.ena (1'b1)
	);
	
	//yDiff * yDiff
	altsquare #(.data_width(POS_BIT_SIZE), .result_width(23), .pipeline(1), .representation("SIGNED")) 
		ySqrOp(
			.clock(clk),
			.data(yDiff),
			.result(ySqr),
			.aclr (1'b0),
			.ena (1'b1)
	);
	
	//zDiff * zDiff
	altsquare #(.data_width(POS_BIT_SIZE), .result_width(23), .pipeline(1), .representation("SIGNED"))  
		zSqrOp(
			.clock(clk),
			.data(zDiff),
			.result(zSqr),
			.aclr (1'b0),
			.ena (1'b1)
	);
	
	
	//------------------------------------------------------------------------------------------------
	logic [22:0] sumXZ;
	//xDiff * xDiff + yDiff * yDiff + zDiff * zDiff
	lpm_add_sub #(.lpm_width(23), .lpm_direction("ADD"), .lpm_pipeline(1)) 
		sumXZop(
		.clock(clk),
		.dataa(xSqr),
		.datab(zSqr),
		.result(sumXZ)
	);
	
	logic [22:0] sumXYZ;
	lpm_add_sub #(.lpm_width(23), .lpm_direction("ADD"), .lpm_pipeline(1)) 
		sumXYZop(
		.clock(clk),
		.dataa(sumXZ),
		.datab(ySqr),
		.result(sumXYZ)
	);
	
	
	//------------------------------------------------------------------------------------------------
	float sumF, sqrtF, multKF, scaleF;
	
	//(float)(xDiff * xDiff + yDiff * yDiff + zDiff * zDiff)
	Int2Float int2Float(
		.clock(clk),
		.dataa(sumXYZ),
		.result(sumF)
	);
	
	//sqrtf((float)(xDiff * xDiff + yDiff * yDiff + zDiff * zDiff)) => r
	Sqrtf sqrtfOp(
		.clock(clk),
		.data(sumF),
		.result(sqrtF)
	);

	//-r * WAVE_K
	MultK multKop(
		.clock(clk),
		.dataa(sqrtF),
		.datab(NEG_WAVE_K_DIV10),
		.result(multKF)
	);
	
	//(-r * WAVE_K) * (MaxPhaseCnt/(2*M_PI))
	MultK scaleOp(
		.clock(clk),
		.dataa(multKF),
		.datab(SCALE_CNST),
		.result(scaleF)
	);
	
	//(int) scaleF
	logic [31:0] scaleInt;
	Float2Int float2Int(
		.clock(clk),
		.dataa(scaleF),
		.result(scaleInt)
	);
	
	logic [31:0] scaleInt_delayed;
	logic [31:0] scaleInt_inverted;
	always@(posedge clk) begin
		scaleInt_delayed <= scaleInt;
		scaleInt_inverted <= scaleInt + MAX_PHASE_CNT/2;
	end
	//mod(scaleInt, MaxPhaseCnt) => mod
	logic [PHASE_BIT_SIZE:0] remain;
	lpm_divide #(.lpm_drepresentation("UNSIGNED"), .lpm_hint("LPM_REMAINDERPOSITIVE=FALSE"), .lpm_nrepresentation("SIGNED"), .lpm_pipeline(1), .lpm_widthd(PHASE_BIT_SIZE+1), .lpm_widthn(32))
		mod (
				.clock (clk),
				.denom (MAX_PHASE_CNT),
				.numer (top ? scaleInt_delayed : scaleInt_inverted),
				
				.remain(remain)
	);
				
	
	//mod + MaxPhaseCnt
	logic [PHASE_BIT_SIZE:0] phaseInt;
	
	lpm_add_sub #(.lpm_width(PHASE_BIT_SIZE+1), .lpm_direction("ADD"), .lpm_pipeline(1)) 
		normalize(
			.clock(clk),
			.dataa(remain),
			.datab(MAX_PHASE_CNT),
			.result(phaseInt)
	);
	
	always@(posedge clk) begin
		if(!nReset) begin
			state <= '0;
			idx <= '0;
		end else begin
			case(state)
				0:
					begin
						idx <= 0;
						if(start) begin
							state <= 1;
							idx <= idx + 1;
						end
					end
				1: 
					begin
						idx <= idx + 1;
						if(idx == NUM_CHANNELS-1)
							state <= 0;
					end
				default:
					state <= 0;
			endcase
		end
	end
	
	logic [$clog2(NUM_CHANNELS)-1 : 0] cIdx;
	logic [5:0] cState;
	always@(posedge clk) begin
		if(!nReset) begin
			cState <= '0;
			cIdx <= '0;
		end else begin
			case(cState)
				0:
					begin
						cIdx <= 0;
						if(state==1) begin
							cState <= 1;
						end
					end
				1:
					begin
							cState <= 2;
					end
				2: 
					begin
						cIdx <= cIdx + 1;
						phaseEnabled[cIdx] <= sumXZ < XZradiusSquared;
						if(cIdx == NUM_CHANNELS-1) 
							cState <= 3;
					end
				3:
					begin
						cState <= 0;
					end
			endcase

		end
	end
	
	
	logic [$clog2(NUM_CHANNELS)-1 : 0] rIdx;
	logic [5:0] rState;
	logic [5:0] rDelay;
	always@(posedge clk) begin
		if(!nReset) begin
			rState <= '0;
			rIdx <= '0;
			done <= '0;
		end else begin
			case(rState)
				0:
					begin
						rIdx <= 0;
						rDelay <= 0;
						if(state==1) begin
							rState <= 1;
							done <= 0;
						end
					end
				1:
					begin
						rDelay <= rDelay + 1;
						if(rDelay == 42)
							rState <= 2;
					end
				2: 
					begin
						rIdx <= rIdx + 1;
						phase[rIdx] <= phaseInt[PHASE_BIT_SIZE-1:0];
						if(rIdx == NUM_CHANNELS-1) 
							rState <= 3;
					end
				3:
					begin
						done <= 1;
						rState <= 0;
					end
			endcase
			if(cycleStart)
				done <= '0;
		end
	end
	
endmodule
