// Seven segment decoder for BCD inputs from 0 to 9
// Takes 4 bit input and displays the corresponding output on a segment of the
//  HEX display

// SW[3:0] data inputs
// HEX[6:0] 7 segment output

module seven_seg_decoder(SW,HEX0);
  input [3:0] SW;
  output [6:0] HEX0;

  assign HEX0[0] = (~SW[3]&~SW[2]&~SW[1]&SW[0]) | (~SW[3]&SW[2]&~SW[1]&~SW[0]) | (SW[3]&SW[2]&~SW[1]&SW[0]) | (SW[3]&~SW[2]&SW[1]&SW[0]);
  assign HEX0[1] = (SW[3]&SW[1]&SW[0]) | (SW[3]&SW[2]&~SW[0]) | (SW[2]&SW[1]&~SW[0]) | (~SW[3]&SW[2]&~SW[1]&SW[0]);
  assign HEX0[2] = (SW[3]&SW[2]&~SW[0]) | (SW[3]&SW[2]&SW[1]) | (~SW[3]&~SW[2]&SW[1]&~SW[0]);
  assign HEX0[3] = (SW[2]&SW[1]&SW[0]) | (~SW[2]&~SW[1]&SW[0]) | (~SW[3]&SW[2]&~SW[1]&~SW[0]) | (SW[3]&~SW[2]&SW[1]&~SW[0]);
  assign HEX0[4] = (~SW[3]&SW[0]) | (~SW[3]&SW[2]&~SW[1]) | (~SW[2]&~SW[1]&SW[0]);
  assign HEX0[5] = (~SW[3]&~SW[2]&SW[1]) | (~SW[3]&~SW[2]&SW[0]) | (~SW[3]&SW[1]&SW[0]) | (SW[3]&SW[2]&~SW[1]&SW[0]);
  assign HEX0[6] = (~SW[3]&~SW[2]&~SW[1]) | (SW[3]&SW[2]&~SW[1]&~SW[0]) | (~SW[3]&SW[2]&SW[1]&SW[0]);

endmodule
