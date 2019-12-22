// Used to draw black screen between letters to erase the previous
// letter being displayed
module clearScreen(clk,signal,colour);

	input clk;
	input signal;
	output reg [2:0] colour;

	always @(posedge clk)
	begin
		if(signal == 1'b1)
			begin
				colour <= 3'b000;
			end
		else
			begin
				colour <= 3'b101;
			end
	end
endmodule
