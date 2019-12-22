// Creating a simple ALU with a register circuit
// Functions:
// A+1, A+B, A+B using Verilog '+', {AX+RB,A|B}, Contains 1, Swap A and B

module totalALU(KEY,SW,LEDR,HEX0,HEX4,HEX5);
  input [0:0] KEY;
  input [9:0] SW;
  output [7:0] LEDR;
  output [6:0] HEX0;
  output [6:0] HEX4, HEX5;
  wire [7:0] reg_out;
  wire [7:0] to_reg;

  // Using the Arithmetic Logic Unit
  alu alu1(
    .A(SW[3:0]),
    .B(reg_out[3:0]),
    .btn(SW[7:5]),
    .al_out(to_reg)
  );

  register rstr(
    .clock(KEY[0]),
    .resetn(SW[9]),
    .d(to_reg),
    .q(reg_out)
    );
  assign LEDR[7:0] = reg_out;

  // Displays value of A on HEX0
  seven_seg_decoder hexy0(
    .SW(SW[3:0]),
    .HEX0(HEX0[6:0])
  );

  // Displaying output of register on HEX4 and HEX5
  seven_seg_decoder hexy4(
    .SW(reg_out[3:0]),
    .HEX0(HEX4[6:0])
  );
  seven_seg_decoder hexy5(
    .SW(reg_out[7:4]),
    .HEX0(HEX5[6:0])
  );

endmodule // total_alu


// Determines which function to output
module alu(A, B, btn, al_out);
  input [3:0] A;          //SW[3:0]
  input [3:0] B;
  input [2:0] btn;        //SW[7:5]
  output [7:0] al_out;    //LEDR[7:0]
  reg [7:0] al_out;

  // Invert the button as unpressed button is 1 and pressed button is 0
  wire [2:0] in_btn;
  assign in_btn[2] = btn[2];
  assign in_btn[1] = btn[1];
  assign in_btn[0] = btn[0];

  // Connect four_adder output to al_out
  wire carry_0;
  wire [3:0] sum_0;

  // Output of case 1 ripple carry adder
  wire carry_1;
  wire [3:0] sum_1;

  four_adder case0(
      .A(A[3:0]),
      .B(4'b0001),
      .c_in(1'b0),
      .c_out(carry_0),
      .sum(sum_0[3:0])
    );

  four_adder case1(
    .A(A[3:0]),
    .B(B[3:0]),
    .c_in(1'b0),
    .c_out(carry_1),
    .sum(sum_1[3:0])
    );

  always @(*)
  begin
    case (in_btn)
      3'b000 : begin                       // A + 1
                  al_out[3:0] = sum_0;
                  al_out[4] = carry_0;
                  al_out[7:5] = 3'b000;
               end
      3'b001 : begin                       // A + B with four_adder
                  al_out[3:0] = sum_1;
                  al_out[4] = carry_1;
                  al_out[7:5] = 3'b000;
               end
      3'b010 : al_out = {4'b000,A + B};    // A + B using Verilog
      3'b011 : al_out = {A|B,A^B} ;         // A OR B plus A XOR B
      3'b100 : begin                       // If contains 1, output 1
                  if (A|B == 4'b0000)
                    al_out = 8'b00000000;
                  else
                    al_out = 8'b00000001;
               end
      3'b101 : al_out = B << A;            // Left Shifts B by A bits
      3'b110 : al_out = B >> A;            // Right Shifts B by A bits
      3'b111 : al_out = A * B;             // A x B
      default : al_out = 8'b00000000;      // default case, output 0
    endcase
  end
endmodule // alu

// Flipflop master slave
module register(clock,resetn,d,q);
  input clock;
  input resetn;
  input [7:0] d;
  output [7:0] q;
  reg [7:0] q;

  always @(posedge clock) // Triggered every time clock rises
  begin
    if (resetn == 1'b0)     // When resetn is 0
                            // Note this is tested on every rising clock edge
      q <= 0 ;              // Set q to 0 .
    else                    // When resetn is not 0
      q <= d ;              // Store the value of d in q
  end
endmodule // register

// Ripply carry adder
module four_adder(A,B,c_in,c_out,sum);
  input [3:0] A;
  input [3:0] B;
  input c_in;
  output c_out;
  output [3:0] sum;

  wire c0;
  wire c1;
  wire c2;

  full_adds u0(
    .a(A[0]),
    .b(B[0]),
    .c_ins(c_in),
    .sums(sum[0]),
    .c_outs(c0)
    );

  full_adds u1(
    .a(A[1]),
    .b(B[1]),
    .c_ins(c0),
    .sums(sum[1]),
    .c_outs(c1)
    );

  full_adds u2(
    .a(A[2]),
    .b(B[2]),
    .c_ins(c1),
    .sums(sum[2]),
    .c_outs(c2)
    );

  full_adds u3(
    .a(A[3]),
    .b(B[3]),
    .c_ins(c2),
    .sums(sum[3]),
    .c_outs(c_out)
    );

endmodule // four_adder

// Full adder, adds two 1-bit numbers
module full_adds (a,b,c_ins,sums,c_outs);

  input a,b,c_ins;
  output sums, c_outs;

  assign sums = a^b^c_ins;
  assign c_outs = (a&b) | (c_ins & (a^b));

endmodule // full_adds

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
