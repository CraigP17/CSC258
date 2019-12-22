// Creating an 8-bit shift-register
// has an optional arithmetic shift right for sign extension
// has parallel load

// SW[7−0] as the inputs LoadVal[7−0]
// SW[9] as a synchronous active low reset (reset n).
// KEY[0] as the clock (clk)
// KEY[1] as the Load n input,
// KEY[2] as the ShiftRight input
// KEY[3] as the ASR input
// LEDR[7:0] for outputs

module shifter(SW,LEDR, KEY);
  input [9:0] SW;
  input [3:0] KEY;
  output [7:0] LEDR;

  shifter8 s8s(
    .ASR(KEY[3]),
    .LoadVal(SW[7:0]),
    .ShiftRight(KEY[2]),
    .Load_n(KEY[1]),
    .clk(KEY[0]),
    .reset_n(SW[9]),
    .shift_out(LEDR[7:0])
    );
endmodule // total_thing

module shifter8(ASR, LoadVal, ShiftRight, Load_n, clk, reset_n, shift_out);
  input ASR;
  input [7:0] LoadVal;
  input ShiftRight;
  input Load_n;
  input clk;
  input reset_n;
  output [7:0] shift_out;

  wire asr_shift;

  mux2to1 asr(
    .x(ASR),
    .y(shift_out[7]),
    .s(ASR),
    .m(asr_shift)
    );

  shift sb7 (
		.s_loadval(LoadVal[7]),
		.s_in(asr_shift),
		.s_out(shift_out[7]),
    .s_shift(ShiftRight),
		.s_load_n(Load_n),
		.s_clk(clk),
		.s_reset_n(reset_n)
	);

  shift sb6 (
		.s_loadval(LoadVal[6]),
		.s_in(shift_out[7]),
		.s_out(shift_out[6]),
    .s_shift(ShiftRight),
		.s_load_n(Load_n),
		.s_clk(clk),
		.s_reset_n(reset_n)
	);

  shift sb5 (
		.s_loadval(LoadVal[5]),
		.s_in(shift_out[6]),
		.s_out(shift_out[5]),
    .s_shift(ShiftRight),
		.s_load_n(Load_n),
		.s_clk(clk),
		.s_reset_n(reset_n)
	);

  shift sb4 (
		.s_loadval(LoadVal[4]),
		.s_in(shift_out[5]),
		.s_out(shift_out[4]),
    .s_shift(ShiftRight),
		.s_load_n(Load_n),
		.s_clk(clk),
		.s_reset_n(reset_n)
	);

  shift sb3 (
		.s_loadval(LoadVal[3]),
		.s_in(shift_out[4]),
		.s_out(shift_out[3]),
    .s_shift(ShiftRight),
		.s_load_n(Load_n),
		.s_clk(clk),
		.s_reset_n(reset_n)
	);

  shift sb2 (
		.s_loadval(LoadVal[2]),
		.s_in(shift_out[3]),
		.s_out(shift_out[2]),
    .s_shift(ShiftRight),
		.s_load_n(Load_n),
		.s_clk(clk),
		.s_reset_n(reset_n)
	);

  shift sb1 (
		.s_loadval(LoadVal[1]),
		.s_in(shift_out[2]),
		.s_out(shift_out[1]),
    .s_shift(ShiftRight),
		.s_load_n(Load_n),
		.s_clk(clk),
		.s_reset_n(reset_n)
	);

  shift sb0 (
		.s_loadval(LoadVal[0]),
		.s_in(shift_out[1]),
		.s_out(shift_out[0]),
    .s_shift(ShiftRight),
		.s_load_n(Load_n),
		.s_clk(clk),
		.s_reset_n(reset_n)
	);

endmodule // shifter8

module shift(s_loadval,s_in,s_out,s_shift,s_load_n,s_clk,s_reset_n);
  input s_loadval;
  input s_in;
  output s_out;
  input s_shift;
  input s_load_n;
  input s_clk;
  input s_reset_n;

  wire mux_mux;
  wire mux_flop;

  mux2to1 m0 (
    .x(s_out),                // output fed back into input
    .y(s_in),                 // input from other shifter
    .s(s_shift),              // ShiftRight
    .m(mux_mux)               // output to second mux
    );
  mux2to1 m1 (
    .x(s_loadval),            // parallel load value
    .y(mux_mux),              // input from 1st mux
    .s(s_load_n),
    .m(mux_flop)              // output to flipflop
    );

  flipflop f0 (
    .d(mux_flop),             // input to flip−flop
    .q(s_out),                // output from flip −flop
    .clock(s_clk),            // clock signal
    .reset(s_reset_n)         // synchronous active low reset
    );
endmodule // shift

module mux2to1(x,y,s,m);
  input x; //selected when s is 0
  input y; //selected when s is 1
  input s; //select signal
  output m; //output

  assign m = s & y | ~s & x;
endmodule // mux2to1

module flipflop(d,q,clock,reset);
  input d;
  output q;
  input clock;
  input reset;
  reg q;

  always @(posedge clock) // Triggered every time clock rises
  begin
    if (reset == 1'b0)      // When reset is 0
                            // Note this is tested on every rising clock edge
      q <= 0 ;              // Set q to 0 .
    else                    // When resetn is not 0
      q <= d ;              // Store the value of d in q
  end
endmodule // flipflop
