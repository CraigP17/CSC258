// Seven to One Multiplexer for BCD inputs from 0 to 9
// SW[6:0] data inputs
// SW[9:7] select signals

module sevenOneMux (LEDR, SW);
  input [9:0] SW;
  output [9:0] LEDR;

  mux7to1 u0(
    .in(SW[6:0]),
    .MuxSelect(SW[9:7]),
    .out(LEDR[0])
    );
endmodule // mux

module mux7to1 (in,MuxSelect,out);
  input [6:0] in;
  input [2:0] MuxSelect;
  output out;
  reg out; // declare the output signal from the always block

  always @(*) // declare always block
  begin
    case (MuxSelect [2:0] ) // start case statement
    3'b000: out = in[0]; // case 0
    3'b001: out = in[1]; // case 1
    3'b010: out = in[2]; // case 2
    3'b011: out = in[3]; // case 3
    3'b100: out = in[4]; // case 4
    3'b101: out = in[5]; // case 5
    3'b110: out = in[6]; // case 6
    default: out = 1'b0; // default case
    endcase
  end

endmodule // mux7to1
