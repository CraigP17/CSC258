// Creating an 8-bit counter using 8 T-flip flops

module flpCounter (SW, KEY, HEX0, HEX1);
  input [1:0] SW;
  input [0:0] KEY;
  input [6:0] HEX0;
  input [6:0] HEX1;
  wire [7:0] outhex;

  counter c0 (
    .Enable(SW[1]),
    .Clock(inv_clock),
    .Clear(SW[0]),
    .Out(outhex)
    );

  seven_seg_decoder hexy0(
    .SW(outhex[3:0]),
    .HEX0(HEX0[6:0])
    );

  seven_seg_decoder hexy1(
    .SW(outhex[7:4]),
    .HEX0(HEX1[6:0])
  );

endmodule // counter

module counter (Enable, Clock, Clear, Out);
  input Enable;
  input Clock;
  input Clear;
  output [7:0] Out;

  wire in1, in2, in3, in4, in5, in6, in7;
  wire out0, out1, out2, out3, out4, out5, out6, out7;

  tflipflop t0(
    .Clk(Clock),
    .Clear_b(Clear),
    .T(Enable),
    .Q(out0)
    );
  and(in1, Enable, out0); // AND Gate connecting t0 and t1
  assign Out[0] = out0;

  tflipflop t1(
    .Clk(Clock),
    .Clear_b(Clear),
    .T(in1),
    .Q(out1)
    );
  and a(in2, in1, out1);
  assign Out[1] = out1;

  tflipflop t2(
    .Clk(Clock),
    .Clear_b(Clear),
    .T(in2),
    .Q(out2)
    );
  and(in3, in2, out2);
  assign Out[2] = out2;

  tflipflop t3(
    .Clk(Clock),
    .Clear_b(Clear),
    .T(in3),
    .Q(out3)
    );
  and(in4, in3, out3);
  assign Out[3] = out3;

  tflipflop t4(
    .Clk(Clock),
    .Clear_b(Clear),
    .T(in4),
    .Q(out4)
    );
  and(in5, in4, out4);
  assign Out[4] = out4;

  tflipflop t5(
    .Clk(Clock),
    .Clear_b(Clear),
    .T(in5),
    .Q(out5)
    );
  and(in6, in5, out5);
  assign Out[5] = out5;

  tflipflop t6(
    .Clk(Clock),
    .Clear_b(Clear),
    .T(in6),
    .Q(out6)
    );
  and(in7, in6, out6);
  assign Out[6] = out6;

  tflipflop t7(
    .Clk(Clock),
    .Clear_b(Clear),
    .T(in7),
    .Q(out7)
    );
  assign Out[7] = out7;


endmodule // counter

module tflipflop (Clk, Clear_b, T, Q);
  input Clk;
  input Clear_b;
  input T;
  output Q;
  reg Q;

  always @(posedge Clk, negedge Clear_b)
    begin
      if (Clear_b == 1'b0)
        Q <= 1'b0;
      else
        Q <= Q ^ T;
    end

endmodule // tflipflop

// Seven Segment Decoder, takes binary input and outputs it in hex
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

endmodule //seven_seg_decoder
