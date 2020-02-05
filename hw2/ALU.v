module ALU(input A, input B, input [3:0]S, output G, output Z, output N, output O, output C );

    case ([3:1]S):
        3'b000: assign G = A + [0]S
        3'b001: assign G = A + B + [0]S
        3'b010: assign G =  A + ~B + [0]S
        3'b011: assign G = A - 1 + [0]S
        3'b100: assign G = A & B
        3'b101: assign G = A | B
        3'b110: assign G = A^B
        3'b000: assign G = ~A + [0]S
    endcase