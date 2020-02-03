module shifter(input [3:0]B, input [1:0]S, output H, output Il, output Ir);
    case S:
        2'b00: H = B
        2'b01: Il = [3]B; | H = B << 1;
        2'b10: Ir = [0]B; | H = B >> 1;