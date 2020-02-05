module shifter(input [15:0]B, input [1:0]S, output H, output Il, output Ir);
    case S:
        2'b00: assign H = B
        2'b01:  begin
                    assign Il = [15]B;
                    assign H = B << 1;
                end
        2'b10: begin
                    assign Ir = [0]B;  
                    assign H = B >> 1;
                end

    endcase