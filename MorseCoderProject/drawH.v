// Drawing H on VGA display by outputting x and y coordinates
module drawH
    (
      clk,                        //    On Board 50 MHz
      signal,
		  outX,
		  outY,
      finished
    );
    input clk;                //    50 MHz
    input signal;
    output reg [7:0] outX;
    output reg [6:0] outY;
    output reg finished;

    wire reset = 1'b1;

    reg [4:0] counter;
    reg [3:0] stateH = 4'b0000;
    wire [7:0] startX;
    assign startX = 8'b00111010;
    wire [6:0] startY;
    assign startY = 7'b0011101;

    always @ (posedge clk)
  	 begin
    		if(signal == 1'b1)
    			begin
    				 if (stateH == 4'b0000)
    					begin
    						 if (counter < 5'b11111)
    							begin
    							  outX <= startX;
    							  outY <= startY;
    							  counter <= counter + 1'b1;
    							end
    						 else
    							begin
    							  stateH <= 4'b0001;
    							  counter <= 5'b00000;
    							end
    					 end
      			 else if (stateH == 4'b0001)
      				 begin
      					 if (counter < 5'b11111)
      						begin
      						  outX <= startX;
      						  outY <= startY;
      						  counter <= counter + 1'b1;
      						end
      					 else
      						begin
      						  stateH <= 4'b0010;
      						  counter <= 5'b00000;
      						end
      				  end
  				 else if (stateH == 4'b0010)
  					 begin
  						 if (counter < 5'b11111)
  							begin
  							  outX <= startX;
  							  outY <= startY + counter;
  							  counter <= counter + 1'b1;
  							end
  						 else
  							begin
  							  stateH <= 4'b0011;
  							  counter <= 5'b00000;
  							end
  					 end
  				 else if (stateH == 4'b0011)
  					  begin
  						 if (counter < 5'b11111)
  							begin
  							  outX <= startX;
  							  outY <= startY + counter;
  							  counter <= counter + 1'b1;
  							end
  						 else
  							begin
  							  stateH <= 4'b0100;
  							  counter <= 5'b00000;
  							end
  					  end
  				 else if (stateH == 4'b0100)
  					  begin
  						 if (counter < 5'b11111)
  							begin
  							  outX <= startX + counter;
  							  outY <= startY + 5'b10000;
  							  counter <= counter + 1'b1;
  							end
  						 else
  							begin
  							  stateH <= 4'b0101;
  							  counter <= 5'b00000;
  							end
  					  end
  				 else if (stateH == 4'b0101)
  					  begin
  						 if (counter < 5'b11111)
  							begin
  							  outX <= startX + counter;
  							  outY <= startY + 5'b10000;
  							  counter <= counter + 1'b1;
  							end
  						 else
  							begin
  							  stateH <= 4'b0110;
  							  counter <= 5'b00000;
  							end
  					end
  				 else if (stateH == 4'b0110)
  					begin
  					 if (counter < 5'b11111)
  					  begin
  						 outX <= startX;
  						 outY <= startY;
  						 counter <= counter + 1'b1;
  					  end
  					 else
  					  begin
  						 stateH <= 4'b0111;
  						 counter <= 5'b00000;
  					  end
  					end
  				 else if (stateH == 4'b0111)
  					begin
  					 if (counter < 5'b11111)
  					  begin
  						 outX <= startX;
  						 outY <= startY;
  						 counter <= counter + 1'b1;
  					  end
  					 else
  					  begin
  						 stateH <= 4'b1000;
  						 counter <= 5'b00000;
  					  end
  					end
  				 else if (stateH == 4'b1000)
  					begin
  					 if (counter < 5'b11111)
  					  begin
  						 outX <= startX + 5'b11111;
  						 outY <= startY + counter;
  						 counter <= counter + 1'b1;
  					  end
  					 else
  					  begin
  						 stateH <= 4'b1001;
  						 counter <= 5'b00000;
  					  end
  					end
  				 else if (stateH == 4'b1001)
  					begin
  					 if (counter < 5'b11111)
  					  begin
  						 outX <= startX + 5'b11111;
  						 outY <= startY + counter;
  						 counter <= counter + 1'b1;
  					  end
  					 else
  					  begin
  						 stateH <= 4'b1010;
  						 counter <= 5'b00000;
  					  end
  					end
            else
              begin
               if (counter < 5'b11111)
                begin
                  outX <= startX;
                  outY <= startY;
                  counter <= counter + 1'b1;
  					 finished <= 1'b1;
                end
               else
                begin
  					 outX <= 8'b00000000;
  					 outY <= 7'b0000000;
                  stateH <= 4'b0000;
                  counter <= 5'b00000;
                end
              end
    			end

    end

endmodule
