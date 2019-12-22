// This module takes in input from the player of whether they pressed
//   a long or short key or submit ltetter btn.
// Using an FSM the series of keys pressed corresponds to a letter of the
// 	 alphabet using morse code
// Once the letter it submitted, the checker module checks whether the inputted
// 	combination of keys is correctly matches the letter being displayed

module morsing (CLOCK_50,KEY,SW,displaySig, a,b,c,dd);
	input CLOCK_50;

  input [3:0] KEY;
  input [1:0] SW;
  wire [4:0] letter;
  input a,b,c,dd;

  output displaySig;


  // The Finite State Machine that decodes the morse input
  inputFSM data(b, ~KEY[0], c, dd, a, letter);

  checking checker(SW[1:0],letter, displaySig);

  // Displays the morse letter on the HEX display
  //hx2display hexer(letter, HEX1, HEX0);
endmodule // morser

module inputFSM (clk, resetn, Kspace, Kenter, Ks, result);
	input clk;
  input resetn;
  input Kspace, Kenter, Ks; // dash, dot, submit
  output reg [4:0] result;

  localparam      start = 5'd0,
                      A = 5'd1,
                      B = 5'd2,
                      C = 5'd3,
                      D = 5'd4,
                      E = 5'd5,
                      F = 5'd6,
                      G = 5'd7,
                      H = 5'd8,
                      I = 5'd9,
                      J = 5'd10,
                      K = 5'd11,
                      L = 5'd12,
                      M = 5'd13,
                      N = 5'd14,
                      O = 5'd15,
                      P = 5'd16,
                      Q = 5'd17,
                      R = 5'd18,
                      S = 5'd19,
                      T = 5'd20,
                      U = 5'd21,
                      V = 5'd22,
                      W = 5'd23,
                      X = 5'd24,
                      Y = 5'd25,
                      Z = 5'd26,
              Submitted = 5'd27;
  reg [4:0] currentState, nextState;
  reg submit;

  // This code block is the state table / next state logic
  always @ (*)
    begin
      case (currentState)
        start:
          begin
            if (Ks == 1'b1) nextState = start;
            else if (Kenter == 1'b1) nextState = E;
            else if (Kspace == 1'b1) nextState = T;
          end
        E: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = I;
            else if (Kspace == 2'b11) nextState = A;
           end
        I: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = S;
            else if (Kspace == 1'b1) nextState = U;
           end
        S: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = H;
            else if (Kspace == 1'b1) nextState = V;
           end
        H: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = H;
            else if (Kspace == 1'b1) nextState = H;
           end
        A: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = R;
            else if (Kspace == 1'b1) nextState = W;
           end
        W: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = P;
            else if (Kspace == 1'b1) nextState = J;
           end
        J: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = J;
            else if (Kspace == 1'b1) nextState = J;
           end
        P: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = P;
            else if (Kspace == 1'b1) nextState = P;
           end
        R: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = L;
            else if (Kspace == 1'b1) nextState = R;
           end
        L: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = L;
            else if (Kspace == 1'b1) nextState = L;
           end
        U: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = F;
            else if (Kspace == 1'b1) nextState = U;
           end
        F: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = F;
            else if (Kspace == 1'b1) nextState = F;
           end
        V: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = V;
            else if (Kspace == 1'b1) nextState = V;
           end
        T: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = N;
            else if (Kspace == 1'b1) nextState = M;
           end
        N: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = D;
            else if (Kspace == 1'b1) nextState = K;
           end
        D: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = B;
            else if (Kspace == 1'b1) nextState = X;
           end
        B: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = B;
            else if (Kspace == 1'b1) nextState = B;
           end
        X: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = X;
            else if (Kspace == 1'b1) nextState = X;
           end
        K: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = C;
            else if (Kspace == 1'b1) nextState = Y;
           end
        C: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = C;
            else if (Kspace == 1'b1) nextState = C;
           end
        Y: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 2'b01) nextState = Y;
            else if (Kspace == 2'b11) nextState = Y;
           end
        M: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = G;
            else if (Kspace == 1'b1) nextState = O;
           end
        G: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = Z;
            else if (Kspace == 1'b1) nextState = Q;
           end
        Z: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = Z;
            else if (Kspace == 1'b1) nextState = Z;
           end
        Q: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = Q;
            else if (Kspace == 1'b1) nextState = Q;
           end
        O: begin
            if (Ks == 1'b1)
              begin
                submit = 1'b1;
                nextState = Submitted;
              end
            else if (Kenter == 1'b1) nextState = O;
            else if (Kspace == 1'b1) nextState = O;
           end
        Submitted: begin
          nextState = start;
          submit = 1'b0;
          end
        default: nextState = start;
      endcase
    end

  // This code block is the output logic, all our datapath output signals
  always @ ( * )
    begin
      case (currentState)
        start: result = 5'd0;
            A: result = submit ? A : 5'd0;
            B: result = submit ? B : 5'd0;
            C: result = submit ? C : 5'd0;
            D: result = submit ? D : 5'd0;
            E: result = submit ? E : 5'd0;
            F: result = submit ? F : 5'd0;
            G: result = submit ? G : 5'd0;
            H: result = submit ? H : 5'd0;
            I: result = submit ? I : 5'd0;
            J: result = submit ? J : 5'd0;
            K: result = submit ? K : 5'd0;
            L: result = submit ? L : 5'd0;
            M: result = submit ? M : 5'd0;
            N: result = submit ? N : 5'd0;
            O: result = submit ? O : 5'd0;
            P: result = submit ? P : 5'd0;
            Q: result = submit ? Q : 5'd0;
            R: result = submit ? R : 5'd0;
            S: result = submit ? S : 5'd0;
            T: result = submit ? T : 5'd0;
            U: result = submit ? U : 5'd0;
            V: result = submit ? V : 5'd0;
            W: result = submit ? W : 5'd0;
            X: result = submit ? X : 5'd0;
            Y: result = submit ? Y : 5'd0;
            Z: result = submit ? Z : 5'd0;
         // default: ; All cases are assigned, therefore default not needed
      endcase
    end

    always @ (posedge clk)
      begin
        if (resetn) currentState <= start;
        else currentState <= nextState;
      end


endmodule // FSM


module checking(state,submittedLetter,MoveSignal);
    input [1:0]state;
    input [4:0]submittedLetter;
    output reg MoveSignal;

    always @ (*)
        begin
            if(state == 2'b00)
                begin
                    if(5'd3 == submittedLetter)
                        begin
                            MoveSignal <= 1'b1;
                        end
                    else
                        begin
                            MoveSignal <= 1'b0;
                        end
                end
            else if(state == 2'b01)
                begin
                    if(5'd5 == submittedLetter)
                        begin
                            MoveSignal <= 1'b1;
                        end
                    else
                        begin
                            MoveSignal <= 1'b0;
                        end
                end
            else if(state == 2'b10)
                begin
                    if(5'd6 == submittedLetter)
                        begin
                            MoveSignal <= 1'b1;
                        end
                    else
                        begin
                            MoveSignal <= 1'b0;
                        end
                end
            else if(state == 2'b11)
                begin
                    if(5'd8 == submittedLetter)
                        begin
                            MoveSignal <= 1'b1;
                        end
                    else
                        begin
                            MoveSignal <= 1'b0;
                        end
                end
        end

endmodule




// This module is to display the letters in numbers
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
