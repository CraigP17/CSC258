// A counter that counts from 0 to F, at different speeds depending on input
// 4 Clock speeds corresponding to 2 switch inputs

module counterClock (HEX0, SW, CLOCK_50);
  output [6:0] HEX0;
  input [3:0] SW;
  input CLOCK_50;
  wire [27:0] rdfullo, rd1o, rd05o, rd025o;
  wire [3:0] display;
  reg enble;

  RateDivider rdfull(CLOCK_50, SW[3], SW[2], 1'b0, 28'b0000000000000000000000000000, rdfullo);
  RateDivider    rd1(CLOCK_50, SW[3], SW[2], 1'b1, 28'b0010111110101111000001111111, rd1o);
  RateDivider   rd05(CLOCK_50, SW[3], SW[2], 1'b1, 28'b0101111101011110000011111111, rd05o);
  RateDivider  rd025(CLOCK_50, SW[3], SW[2], 1'b1, 28'b1011111010111100000111111111, rd025o);

  always @(*)
    begin
      case(SW[1:0])
        2'b00 : enble = (rdfullo == 28'b0000000000000000000000000000) ? 1'b1 : 1'b0;
        2'b01 : enble = (rd1o == 28'b0000000000000000000000000000) ? 1'b1 : 1'b0;
        2'b10 : enble = (rd05o == 28'b0000000000000000000000000000) ? 1'b1 : 1'b0;
        2'b11 : enble = (rd025o == 28'b0000000000000000000000000000) ? 1'b1 : 1'b0;
        default: enble = 1'b0;
      endcase
    end

  counterDisplay cd(
    .enable(enble),
    .clock(CLOCK_50),
    .resetn(SW[2]),
    .q_out(display)
    );

  seven_seg_decoder ssd (
    .SW(display),
    .HEX0(HEX0[6:0])
    );
endmodule // counterClock

module RateDivider (Clock, ParLoad, Reset, Go, Starter, Counter);
  input Clock;
  input ParLoad;
  input Reset;
  input Go;                 // Subtract when Go is 1
  input [27:0] Starter;     // Value that counter starts from
  output [27:0] Counter;
  reg [27:0] Counter;

  always @(posedge Clock)
    begin
      if (Reset == 1'b0)        // Because Reset is active low when pressed
        Counter <= 0;
      else if (ParLoad == 1'b1) // Load counter with start number
        Counter <= Starter;
      else if (Counter == 28'b0000000000000000000000000000)
        Counter <= Starter;     // Reset counter after reaching limit
      else if (Go == 1'b1)      // Counter runs when Go is on
        Counter <= Counter - 1'b1;
      else if (Go == 1'b0)      // Counter should not count when Go is off
        Counter <= Counter;
    end
endmodule // RateDivider

module counterDisplay (enable, clock, resetn, q_out);
  input enable;
  input clock;
  input resetn;
  output [3:0] q_out;
  reg [3:0] q_out;

  always @(posedge clock)       // Triggered every time clock rises
    begin
      if (resetn == 1'b0)
        q_out <= 0 ;                    // Set q_out to 0
      else if (enable == 1'b1)          // Increment q_out only when enable is 1
        q_out <= q_out + 1'b1;          // Increment q_out
      else if (enable == 1'b0)
        q_out <= q_out;                 // q_out stays same
    end

endmodule // counterDisplay

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
