module shifter(input clock, input [15:0]B, input [3:0]S, output reg [15:0]H, output reg Il, output reg Ir);
    always @clock begin
    case (S)
        3'b0000: H = B;
        3'b0010:  begin
                    Il = B[15];
                    H = B << 1;
                end
        3'b0100: begin
                    Ir = B[0];  
                    H = B >> 1;
                end

    endcase
end
endmodule