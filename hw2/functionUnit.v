module functionUnit(input clock, input [15:0]A, input [15:0]B, input [3:0]S, input MF,
output reg [15:0]data, output V, output C, output Zr, output N, output Il, output Ir);
    wire [15:0]Aout, Sout;
    ALU a1(clock, A, B, S, Aout, Zr, N, V, C);
    shifter s1(clock, B, S, Sout, Il, Ir);
    always @clock begin
    
        case (MF)
            1'b0: data = Aout;
            1'b1: data = Sout;
        endcase
    end

endmodule