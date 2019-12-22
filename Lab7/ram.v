// Creating a RAM block
// consists of a memory block, address register, data register, control register

// Input of memory address and write or read value to either write a value
// to be stored, or read the value from that memory address, displayed on 2 HEX

module ram (SW, KEY, HEX0, HEX2, HEX4, HEX5);
  input [9:0] SW;
  input [0:0] KEY;
  output [6:0] HEX0, HEX2, HEX4, HEX5;
  wire click = ~KEY[0];
  wire [3:0] thing;

  ram32x4 rem0(SW[8:4], click, SW[3:0], SW[9], thing);

  hx2display hx20(SW[8:4], HEX5, HEX4);
  hxdisplay hdata(SW[3:0], HEX2);
  hxdisplay hout(thing, HEX0);

endmodule // ram


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module ram32x4 (
	address,
	clock,
	data,
	wren,
	q);

	input	[4:0]  address;
	input	  clock;
	input	[3:0]  data;
	input	  wren;
	output	[3:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  clock;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [3:0] sub_wire0;
	wire [3:0] q = sub_wire0[3:0];

	altsyncram	altsyncram_component (
				.address_a (address),
				.clock0 (clock),
				.data_a (data),
				.wren_a (wren),
				.q_a (sub_wire0),
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.address_b (1'b1),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
				.byteena_a (1'b1),
				.byteena_b (1'b1),
				.clock1 (1'b1),
				.clocken0 (1'b1),
				.clocken1 (1'b1),
				.clocken2 (1'b1),
				.clocken3 (1'b1),
				.data_b (1'b1),
				.eccstatus (),
				.q_b (),
				.rden_a (1'b1),
				.rden_b (1'b1),
				.wren_b (1'b0));
	defparam
		altsyncram_component.clock_enable_input_a = "BYPASS",
		altsyncram_component.clock_enable_output_a = "BYPASS",
		altsyncram_component.intended_device_family = "Cyclone V",
		altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.numwords_a = 32,
		altsyncram_component.operation_mode = "SINGLE_PORT",
		altsyncram_component.outdata_aclr_a = "NONE",
		altsyncram_component.outdata_reg_a = "UNREGISTERED",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.widthad_a = 5,
		altsyncram_component.width_a = 4,
		altsyncram_component.width_byteena_a = 1;


endmodule

// Displaying 5-bit number(0 to 1F) on 2 HEX
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
