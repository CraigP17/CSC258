// Morse Code Display
// This module takes an input in SW switches which corrrespond to letters,
//  and displays the respective morse code representation of of the letters
//  displaying the long and short parts of the letter on LEDR[0]

module morse (SW, KEY, LEDR, CLOCK_50);
  input [2:0] SW;
  input [1:0] KEY;
  output LEDR[0];
  input CLOCK_50;
  wire inv_clock = ~ KEY[1];
  wire [27:0] countdown;
  wire enable;
  wire [13:0] morsed;
  wire out;

  LUT l0 (
    .letter_sw(SW[2:0]),
    .morse(morse_code)
    );

  RateDivider rd0 (
    .Clock(CLOCK_50),
    .Reset(KEY[0]),
    .Starter(28'b0001011111010111100000111111),
    .Counter(countdown)
    );
  always @ ( * ) begin
    enable = (countdown == 0 ? 1'b1 : 1'b0);
  end
  assign enable = (countdown == 0 ? 1'b1 : 1'b0);

  Shifter sr (
    .morse_codes(morsed),
    .ins(1'b0),
    .outs(out),
    .shifts(1'b1),
    .loads(inv_clock),
    .clocks(enable),
    .resets(KEY[0])
    );

endmodule // morse

module LUT (letter_sw, morse);
  input [2:0] letter_sw;
  output [13:0] morse;
  reg [13:0] morse;

  @always @ ( * ) begin
    case (letter_sw)
      3'b000: morse = 00000000010101; // S
      3'b001: morse = 00000000000111; // T
      3'b010: morse = 00000001110101; // U
      3'b011: morse = 00011101010101; // V
      3'b100: morse = 00011101010111; // X
      3'b101: morse = 01110111010111; // Y
      3'b111: morse = 00010101110111; // Z
      default: morse = 00000000000000;
    endcase
  end
endmodule // LUT

module RateDivider (Clock, Reset, Starter, Counter);
  input Clock;
  input Reset;
  input [27:0] Starter;     // Value that counter starts from
  output [27:0] Counter;
  reg [27:0] Counter;

  always @(posedge Clock)
    begin
      if (Reset == 1'b0) // Because KEY become 1'b0 when pressed
        Counter <= 0;
      else if (Counter == 0)
        Counter <= Starter;
      else
        Counter = Counter - 1'b1;
    end
endmodule // RateDivider

module Shifter (morse_codes, ins, outs, shifts, loads, clocks, resets);
  input [13:0] morse_codes;
  input ins;
  output outs;
  input shifts;
  input loads;
  input clocks;
  input resets;

  wire in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13;
  wire out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13;

  assign outs = out0;

  shift s13 (morse_codes[13], ins, out13, shifts, loads, clocks, resets);
  shift s12 (morse_codes[12], out13, out12, shifts, loads, clocks, resets);
  shift s11 (morse_codes[11], out12, out11, shifts, loads, clocks, resets);
  shift s10 (morse_codes[10], out11, out10, shifts, loads, clocks, resets);
  shift s9 (morse_codes[9], out10, out9, shifts, loads, clocks, resets);
  shift s8 (morse_codes[8], out9, out8, shifts, loads, clocks, resets);
  shift s7 (morse_codes[7], out8, out7, shifts, loads, clocks, resets);
  shift s6 (morse_codes[6], out7, out6, shifts, loads, clocks, resets);
  shift s5 (morse_codes[5], out6, out5, shifts, loads, clocks, resets);
  shift s4 (morse_codes[4], out5, out4, shifts, loads, clocks, resets);
  shift s3 (morse_codes[3], out4, out3, shifts, loads, clocks, resets);
  shift s2 (morse_codes[2], out3, out2, shifts, loads, clocks, resets);
  shift s1 (morse_codes[1], out2, out1, shifts, loads, clocks, resets);
  shift s0 (morse_codes[0], out1, out0, shifts, loads, clocks, resets);
endmodule // Shifter

module shift(s_loadval,s_in,s_out,s_shift,s_load_n,s_clk,s_resetn);
  input s_loadval;
  input s_in;
  output s_out;
  input s_shift;
  input s_load_n;
  input s_clk;
  input s_resetn;
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
    .d(mux_flop),
    .q(s_out),
    .clock(s_clk),
    .reset(s_resetn)
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
