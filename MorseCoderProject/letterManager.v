// This module determines which letter should displayed on the VGA and the
// 		current level letter the user is on. Uses an FSM to move through levels
 
module letterManager(clk,moveOn, resetn,Csig,Esig,Fsig,Hsig, EnableClear);
	input clk;
	input moveOn, resetn;
	//output reg signal;
	output reg Csig;
	output reg Esig;
	output reg Fsig;
	output reg Hsig;
	output reg EnableClear;

	localparam  						 C = 5'd0,
											C_Wait = 5'd1,
											 		 E = 5'd2,
											E_Wait = 5'd3,
											     F = 5'd4,
											F_Wait = 5'd5,
											     H = 5'd6,
											H_Wait = 5'd7,
											   End = 5'd8;
	reg [4:0] currentState, nextState;


	always @ ( * ) begin
		case (currentState)
			C: 			nextState = moveOn ? C_Wait : C;
			C_Wait: nextState = moveOn ? E : C_Wait;
			E: 			nextState = moveOn ? E_Wait : E;
			E_Wait: nextState = moveOn ? F : E_Wait;
			F: 			nextState = moveOn ? F_Wait : F;
			F_Wait: nextState = moveOn ? H : F_Wait;
			H: 			nextState = moveOn ? H_Wait : H;
			H_Wait: nextState = moveOn ? End : H_Wait;
			End  : nextState = C;
			default: nextState = C;
		endcase
	end

	always @ ( * ) begin
		 Csig <= 1'b0;
		 Esig <= 1'b0;
		 Fsig <= 1'b0;
		 Hsig <= 1'b0;
		 EnableClear <= 1'b0;

		case (currentState)
					 C: Csig <= 1'b1;
			C_Wait:	EnableClear <= 1'b1;
					 E: Esig <= 1'b1;
			E_Wait: EnableClear <= 1'b1;
					 F:	Fsig <= 1'b1;
			F_Wait: EnableClear <= 1'b1;
					 H:	Hsig <= 1'b1;
			H_Wait: EnableClear <= 1'b1;
				 End: begin
								Csig <= 1'b0;
								Esig <= 1'b0;
								Fsig <= 1'b0;
								Hsig <= 1'b0;
								EnableClear <= 1'b0;
						  end
		endcase
	end

	always @ (posedge clk) begin
		if (resetn)
			currentState <= C;
		else
			currentState <= nextState;
	end

endmodule
