module ALU( input clock, input [15:0]A, input [15:0]B, input [3:0]S, output reg [15:0]G, output reg Zr, output reg N, output reg V, output C );
    //basic 
    
 always @(clock) begin
    Zr = 0; N = 0; V = 0;
    case({S[3], S[2], S[1]})
        3'b000: begin
                     G = A+S[0];
                     V = ( ~A[15] & G[15]) | (A[15] & ~G[15] );
                end
        3'b001: begin
                     G = A + B + S[0];
                     V = ( ~A[15] & ~B[15] & G[15] ) | ( A[15] & B[15] & ~G[15] );
                    //if both of same sign and G is not overflow
                end
        3'b010: begin
                     G =  A + ~B + S[0];
                     V = (~A[15] & B[15] & G[15]) | (A[15] & ~B[15] & ~G[15]);
                end
        3'b011:  G = A - 1 + S[0];
        3'b100:  G = A & B;
        3'b101:  G = A | B;
        3'b110:  G = A^B;
        3'b111:  G = ~A + S[0];
        
    endcase
    //zero detect
    end
always @G begin    
    if (G == 0) begin 
        Zr = 1;
    end
    //overflow
end    
endmodule