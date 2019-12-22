// Displays 5-bit number (0-1F) on 2 HEX

module hx2display (hex_digits, segment2, segment1);
  input [4:0] hex_digits;
  output reg [6:0] segment1, segment2;

  always @ ( * )
    case (hex_digits)
      5'h0: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b100_0000;
      end
      5'h1: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b111_1001;
      end
      5'h2: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b010_0100;
      end
      5'h3: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b011_0000;
      end
      5'h4: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b001_1001;
      end
      5'h5: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b001_0010;
      end
      5'h6: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b000_0010;
      end
      5'h7: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b111_1000;
      end
      5'h8: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b000_0000;
      end
      5'h9: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b001_1000;
      end
      5'hA: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b000_1000;
      end
      5'hB: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b000_0011;
      end
      5'hC: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b100_0110;
      end
      5'hD: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b010_0001;
      end
      5'hE: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b000_0110;
      end
      5'hF: begin
          segment2 = 7'b100_0000;
          segment1 = 7'b000_1110;
      end
      5'h10: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b100_0000;
      end
      5'h11: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b111_1001;
      end
      5'h12: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b010_0100;
      end
      5'h13: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b011_0000;
      end
      5'h14: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b001_1001;
      end
      5'h15: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b001_0010;
      end
      5'h16: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b000_0010;
      end
      5'h17: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b111_1000;
      end
      5'h18: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b000_0000;
      end
      5'h19: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b001_1000;
      end
      5'h1A: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b000_1000;
      end
      5'h1B: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b000_0011;
      end
      5'h1C: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b100_0110;
      end
      5'h1D: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b010_0001;
      end
      5'h1E: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b000_0110;
      end
      5'h1F: begin
          segment2 = 7'b111_1001;
          segment1 = 7'b000_1110;
      end
      default: begin
          segment1 = 7'h7f;
          segment2 = 7'h7f;
      end
    endcase

endmodule // hx2display

module hxdisplay(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;

    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;
            default: segments = 7'h7f;
        endcase
endmodule
