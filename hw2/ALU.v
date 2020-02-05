module ALU(input [15:0]A, input [15:0]B, input [3:0]S, output G, output Z, output N, output V, output C );
    //basic logic
    case ([3:1]S):
        3'b000: begin
                    assign G = A+[0]S;
                    assign V = (~[15]A & [15]G) | ([15]A & ~[15]G)
        3'b001: begin
                    assign G = A + B + [0]S;
                    assign V = (~[15]A & ~[15]B & [15]G) | ([15]A & [15]B & ~[15]G);
                    //if both of same sign and G is not overflow
                end
        3'b010: begin
                    assign G =  A + ~B + [0]S;
                    assign V = (~[15]A & [15]B & [15]G) | ([15]A & ~[15]B & ~[15]G);
                end
        3'b011: assign G = A - 1 + [0]S;
        3'b100: assign G = A & B;
        3'b101: assign G = A | B;
        3'b110: assign G = A^B;
        3'b111: assign G = ~A + [0]S;
    endcase
    //zero detect
    case (G):
        16'b0: assign Z = 1;
        default: Z = 0;
    endcase
    //overflow
