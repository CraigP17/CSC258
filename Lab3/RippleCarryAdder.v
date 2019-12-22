// Writing a 4-bit ripple-carry adder (adding 2 4-bit numbers)
// using full adders

module RippleCarryAdder(SW,LEDR);
  input [9:0] SW;
  output [5:0] LEDR;

  wire c0;
  wire c1;
  wire c2;

  full_adds u0(
    .a(SW[4]),
    .b(SW[0]),
    .c_in(SW[9]),
    .sum(LEDR[0]),
    .c_out(c0)
    );

  full_adds u1(
    .a(SW[5]),
    .b(SW[1]),
    .c_in(c0),
    .sum(LEDR[1]),
    .c_out(c1)
    );

  full_adds u2(
    .a(SW[6]),
    .b(SW[2]),
    .c_in(c1),
    .sum(LEDR[2]),
    .c_out(c2)
    );

  full_adds u3(
    .a(SW[7]),
    .b(SW[3]),
    .c_in(c2),
    .sum(LEDR[3]),
    .c_out(LEDR[5])
    );

endmodule // carryadder

module full_adds (a,b,c_in,sum,c_out);

  input a,b,c_in;
  output sum, c_out;

  assign sum = a^b^c_in;
  assign c_out = (a&b) | (c_in & (a^b));

endmodule // full_adds
