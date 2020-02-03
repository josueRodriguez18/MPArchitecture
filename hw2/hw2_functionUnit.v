module functionUnit(input clock, input A, input B, input [2:0]S, input MF,
output data, output v, output c, output z, output n);
    wire Aout, Sout;
    ALU(A, B, S, Aout, z, o, c);
    shifter(B, S, Sout);
    case MF:
        1'b0: assign data = Aout;
        1'b1: assign data = Sout;


endmodule