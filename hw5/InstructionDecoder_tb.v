module InstructionDecoder_tb();
    reg [31:0]instruction= 32'd25; wire [14:0]outty;
    InstructionDecoder proc(instruction, outty);
endmodule
