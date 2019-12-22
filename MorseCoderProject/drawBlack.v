// module used to draw black screen by sending x and y coordinates
// iterating over the screen to clear the previous letter displayed

module drawBlack
    (
        clk,                        //    On Board 50 MHz
        signal,
		    outX,
		    outY,
        finished
    );

    input clk;                //    50 MHz
	  input signal;

    output reg finished;

    wire reset = 1'b1;

    reg [13:0] counter;
    reg [2:0] state = 3'b000;
    wire [7:0] startX;
	  assign startX = 8'b001010;
    wire [6:0] startY;
	  assign startY = 7'b0000101;


    output reg [7:0] outX;
    output reg [6:0] outY;
  always @ (posedge clk)
	 begin
  		if(signal == 1'b1)
  			begin
  				if (counter <= 14'b11111111111111)
					begin
						outX <= startX + counter[6:0];
						outY <= startY + counter[13:7];
						counter <= counter + 1'b1;
					end
				else
					begin
						outX <= outX;
						outY <= outY;
						counter <= 14'b00000000000000;
					end
  			end

  end

endmodule
