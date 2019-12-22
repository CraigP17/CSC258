// Draw a 4x4pixel box on the VGA monitor.
// Input 8-bit x-coordinate, then 7-bit y-coordinate, then 3-bit colour

module drawBox
	(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
        KEY,
        SW,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input   [9:0]   SW;
	input   [3:0]   KEY;

	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]

	wire resetn;
	assign resetn = KEY[0];

	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	wire writer;

	wire c_x, c_y;

	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writer),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "black.mif";



	// Put your code here. Your code should produce signals x,y,colour and writeEn/plot
	// for the VGA controller, in addition to any other functionality your design may require.

  // Instansiate datapath
	datapath d0(
		.clk(CLOCK_50),
		.resetn(resetn),
		.enable(writer),
		.data_in(SW[6:0]),
		.loadx(c_x),
		.x_out(x),
		.loady(c_y),
		.y_out(y),
		.loadcolor(c_c),
		.color(SW[9:7]),
		.color_out(colour)
	);

	// Instansiate FSM control
  control c0(
	.clk(CLOCK_50),
	.resetn(resetn),
	.go(KEY[3]),
	.plot(~KEY[1]), //Reverse Key?
	.ld_x(c_x),
	.ld_y(c_y),
	.ld_c(c_c),
	.writer(writer)
	);

endmodule

module datapath (
		input clk,
		input resetn,
		input enable,
		input [6:0] data_in,
		input loadx,
		output reg [7:0] x_out,
		input loady,
		output reg [6:0] y_out,
		input loadcolor,
		input [2:0] color,
		output reg [2:0] color_out
		);

		// Counter for going through 16 pixels
		reg [3:0] counter;
		// Store x and y original inputted values
		reg [7:0] x;
		reg [6:0] y;

		// Loading x y and color values
		always @ (posedge clk)
			begin
				// Make all values 0 on active low reset
				if (!resetn)
					begin
						x <= 8'b0;
						y <= 7'b0;
						color_out <= 3'b0;
					end
				else
					begin
						if (loadcolor)
							color_out <= color;
						if (loadx)
							x <= data_in;
						if (loady)
							y <= data_in;
					end
			end

		// Counter to increment x and y values
		always @ (posedge clk)
			begin
				if (!resetn)
					begin
						counter <= 4'b0;
					end
				if (enable)
					begin
						if (counter == 4'b1111)
							begin
								counter <= 4'b0000;
							end
						else
							begin
								counter <= counter + 1'b1;
							end
					end
			end

		// Make the x and y values increment to make a square
		always @ (posedge clk)
			begin
				if (!resetn)
					begin
						x_out <= 8'b0;
						y_out <= 7'b0;
					end
				if (loadx)
					begin
						x_out <= x + counter[1:0];
					end
				if (loady)
					begin
						y_out <= y + counter[3:2];
					end
			end

endmodule // datapath

module control (
	input clk,
	input resetn,
	input go,
	input plot,
	output reg loader_x, loader_y, loader_color,
	output reg writer
	);

	reg [3:0] current_state, next_state;
	localparam  S_LOAD_X        = 4'd0,
							S_LOAD_X_WAIT   = 4'd1,
							S_LOAD_Y        = 4'd2,
							S_LOAD_Y_WAIT   = 4'd3,
							S_CYCLE_0       = 4'd4,
							S_CYCLE_1				= 4'd5;

	// Next state logic / State Table
	always @ ( * )
		begin: state_table
			case (current_state)
				S_LOAD_X: next_state = go ? S_LOAD_X_WAIT : S_LOAD_X; // Loop in current state until value is input
				S_LOAD_X_WAIT: next_state = go ? S_LOAD_X_WAIT : S_LOAD_X; // Loop in current state until go signal goes low
				S_LOAD_Y: next_state = plot ? S_LOAD_Y_WAIT : S_LOAD_Y; // Loop in current state until value is input
				S_LOAD_Y_WAIT: next_state = plot ? S_CYCLE_0 : S_LOAD_Y_WAIT; // Loop in current state until go signal goes low
				S_CYCLE_0: next_state = S_CYCLE_1; // we will be done our two operations, start over after
				S_CYCLE_1: next_state = S_LOAD_X;
				default:     next_state = S_LOAD_Y_WAIT;
			endcase
		end // state_table

	always @ ( * )
		begin: enable_signals
			loader_x = 1'b0;
			loader_y = 1'b0;
			loader_color = 1'b0;
			writer = 1'b0;

			case (current_state)
				S_LOAD_X: begin
					loader_x = 1'b1;
					loader_color = 1'b0;
					loader_y = 1'b0;
					end
				S_LOAD_Y: begin
					loader_y = 1'b1;
					loader_color = 1'b1;
					loader_x = 1'b0;
					end
				S_CYCLE_0: begin
					writer = 1'b1;
					loader_x = 1'b0;
					loader_y = 1'b0;
					loader_color = 1'b0;
					end
				S_CYCLE_1: begin
					writer = 1'b1;
					loader_x = 1'b0;
					loader_y = 1'b0;
					loader_color = 1'b0;
				end
			endcase
		end //enable_signals

	always @ (posedge clk)
		begin: state_FFs
			if(!resetn)
				current_state <= S_LOAD_X;
			else
				current_state <= next_state;
		end // state_FFs

endmodule // control
