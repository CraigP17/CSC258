// Top-level module
// This is a morse encoder and decoder game where the user is shown a letter on
//    the VGA monitor and they need to input the morse pattern associated with
//    the letter shown using the keyboard for short and long inputs.

module morseDecoder
    (
		    CLOCK_50,
        KEY,                        //    On Board 50 MHz
		    SW,
        // The ports below are for the VGA output.  Do not change.
        VGA_CLK,                           //    VGA Clock
        VGA_HS,                            //    VGA H_SYNC
        VGA_VS,                            //    VGA V_SYNC
        VGA_BLANK_N,                       //    VGA BLANK
        VGA_SYNC_N,                        //    VGA SYNC
        VGA_R,                             //    VGA Red[9:0]
        VGA_G,                             //    VGA Green[9:0]
        VGA_B,                             //    VGA Blue[9:0]
		    PS2_DAT,                           //    Keyboard
		    PS2_CLK,                           //    Keyboard clock
		    LEDR                               //    LEDR to signal correct answer
    );
	  input CLOCK_50;
    input [3:0]KEY;                //    50 MHz
	  input [1:0]SW;
    // Declare your inputs and outputs here
    // Do not change the following outputs
    output            VGA_CLK;                   //    VGA Clock
    output            VGA_HS;                    //    VGA H_SYNC
    output            VGA_VS;                    //    VGA V_SYNC
    output            VGA_BLANK_N;                //    VGA BLANK
    output            VGA_SYNC_N;                //    VGA SYNC
    output    [7:0]    VGA_R;                   //    VGA Red[7:0] Changed from 10 to 8-bit DAC
    output    [7:0]    VGA_G;                     //    VGA Green[7:0]
    output    [7:0]    VGA_B;                   //    VGA Blue[7:0

	  inout PS2_DAT;
	  inout PS2_CLK;
	  output [9:0] LEDR;
	  wire fin;

    wire reset = KEY[1];
	  wire signal;

	  wire Cdrawer;
	  wire Edrawer;
	  wire Fdrawer;
	  wire Hdrawer;
	  wire Clear;

	  reg [7:0]X;
	  reg [6:0]Y;

	  wire [7:0]xC;
	  wire [7:0]xE;
	  wire [7:0]xF;
	  wire [7:0]xH;
	  wire [7:0]xClear;
	  wire [6:0]yC;
	  wire [6:0]yE;
	  wire [6:0]yF;
	  wire [6:0]yH;
	  wire [6:0]yClear;

	  wire fin1, fin2, fin3, fin0;

	  reg [1:0] current_State = 2'b00;

	  wire outSig;

	  wire [2:0]color;

	 always @(posedge CLOCK_50) begin
		if (Cdrawer)
			begin
				X <= xC;
				Y <= yC;
			end
		if (Edrawer)
			begin
				X <= xE;
				Y <= yE;
			end
		if (Fdrawer)
			begin
				X <= xF;
				Y <= yF;
			end
		if (Hdrawer)
			begin
				X <= xH;
				Y <= yH;
			end
		if (Clear)
			begin
				X <= xClear;
				Y <= yClear;
			end
	 end


    // Create an Instance of a VGA controller - there can be only one!
    // Define the number of colours as well as the initial background
    // image file (.MIF) for the controller.
    vga_adapter VGA(
            .resetn(reset),
            .clock(CLOCK_50),
            .colour(color),
            .x(X),
            .y(Y),
            .plot(1'b1),
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

  	wire Ka, Kw, Ks, Kd, Kleft, Kright, Kup, Kdown, Kspace, Kenter;
  	assign LEDR[3] = Ks;
  	assign LEDR[2] = Kd;
  	assign LEDR[1] = Kspace;
  	assign LEDR[0] = Kenter;

	 keyboard_tracker #(.PULSE_OR_HOLD(0)) kybrd(
	     .clock(CLOCK_50),
		  .reset(KEY[0]),
		  .PS2_CLK(PS2_CLK),
		  .PS2_DAT(PS2_DAT),
		  .w(Kw),
		  .a(Ka),
		  .s(Ks),
		  .d(Kd),
		  .left(Kleft),
		  .right(Kright),
		  .up(Kup),
		  .down(Kdown),
		  .space(Kspace),
		  .enter(Kenter)
		  );


	morsing KBoard(CLOCK_50, KEY, current_State, outSig, Ks, Kd, Kspace, Kenter);

	  assign LEDR[0] = outSig;
  	always @(*)
  		begin
  			if (outSig == 1'b1)
  				begin
  					current_State <= current_State + 2'b01;
  				end
  		end

	letterManager manage(
				.clk(outSig),
				.moveOn(1'b1),
				.resetn(~KEY[1]),
				.Csig(Cdrawer),
				.Esig(Edrawer),
				.Fsig(Fdrawer),
				.Hsig(Hdrawer),
				.EnableClear(Clear)
				);

	clearScreen clr(
				.clk(CLOCK_50),
				.signal(Clear),
				.colour(color)
				);

	drawC drawingC(
				.clk(CLOCK_50),
				.signal(Cdrawer),
				.outX(xC),
				.outY(yC),
				.finished(fin0),
				);
	drawE drawingE(
			  .clk(CLOCK_50),
			  .signal(Edrawer),
			  .outX(xE),
			  .outY(yE),
			  .finished(fin1)
			  );
	drawF drawingF(
			  .clk(CLOCK_50),
			  .signal(Fdrawer),
			  .outX(xF),
			  .outY(yF),
			  .finished(fin2)
			  );
  drawH drawingH(
			.clk(CLOCK_50),
			.signal(Hdrawer),
			.outX(xH),
			.outY(yH),
			.finished(fin)
			);
	drawBlack drawingBlack(
			  .clk(CLOCK_50),
			  .signal(Clear),
			  .outX(xClear),
			  .outY(yClear),
			  .finished(fin3)
			  );

endmodule
