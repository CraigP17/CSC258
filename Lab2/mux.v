// This lab is creating a 4-to-1 multiplexer using a 2-to-1 multiplexer

// SW[2:0] data inputs
// SW[9] select signal

// LEDR[0] output display

module mux(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;

    mux4to1 u0(
        .u(SW[0]),
        .v(SW[1]),
		  .w(SW[2]),
		  .x(SW[3]),
        .s1(SW[9]),
		  .s0(SW[8]),
        .m(LEDR[0])
        );
endmodule

//4-to-1 multiplexer
module mux4to1(u,v,w,x,s1,s0,m);
	input u,v,w,x,s1,s0;
	output m;
	wire connect1,connect2;
	mux2to1 mux1(u,w,s1,connect1);
	mux2to1 mux2(v,x,s1,connect2);
	mux2to1 mux3(connect1,connect2,s0,m);

endmodule

//2-to-1 multiplexer
module mux2to1(in1, in2, switch, outp);
    input in1; //selected when s1 is 0
    input in2; //selected when s1 is 1
    input switch; //select signal
    output outp; //output

    assign outp = switch & in2 | ~switch & in1;
    // OR
    // assign m = s ? y : x;

endmodule
