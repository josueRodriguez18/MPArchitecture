


module InstructionDecoder(input [31:0]INST, output reg [14:0]IDOUT );
    // IDOUT[14:9] = FS = OPCODE[4:0]
    parameter ADD = 7'b0000010;
    parameter SUB = 7'b0000101;
    parameter SLT = 7'b1100101; // SET IF LESS THAN
    parameter AND = 7'b0001000;
    parameter OR  = 7'b0001010;
    parameter XOR = 7'b0001010;
    parameter ST  = 7'b0000001; // STORE
    parameter LD  = 7'b0100001; // LOAD
    parameter ADI = 7'b0100010; // ADD IMMEDIATE
    parameter SBI = 7'b0100101; // SUB IMMEDIATE
    parameter NOT = 7'b0101110;
    parameter ANI = 7'b0101000; // AND IMMEDIATE
    parameter ORI = 7'b0101010; // OR  IMMEDIATE
    parameter XRI = 7'b0101100; // XOR IMMEDIATE
    parameter AIU = 7'b1100010; // ADD IMMEDIATE UNSIGNED
    parameter SIU = 7'b1000101;
    parameter MOV = 7'b1000000; // MOVE
    parameter LSL = 7'b0110000; //LOGICAL LEFT SHIFT BY SH BITS
    parameter LSR = 7'b0110001;
    parameter JMR = 7'b1100001;
    parameter BZ  = 7'b0100000; // BRANCH ON ZERO
    parameter BNZ = 7'b1100000; // BRANCH ON NONZERO
    parameter JMP = 7'b1000100;
    parameter JML = 7'b0110001; // JUMP AND LINK
    
    always@* begin
        case(INST[31:24])
            ADD: IDOUT = 15'b100000000010000;
            SUB: IDOUT = 15'b100000000101000;
            SLT: IDOUT = 15'b110000000101000;
            AND: IDOUT = 15'b100000001000000;
            OR : IDOUT = 15'b100000001010000;
            XOR: IDOUT = 15'b100000001100000;
            ST : IDOUT = 15'b000000100000000;
            LD : IDOUT = 15'b101000000000000;
            ADI: IDOUT = 15'b100000000010101;
            SBI: IDOUT = 15'b100000000101101;
            NOT: IDOUT = 15'b100000001110000;
            ANI: IDOUT = 15'b100000001000100;
            ORI: IDOUT = 15'b100000001010100;
            XRI: IDOUT = 15'b100000001100100;
            AIU: IDOUT = 15'b100000000010100;
            SIU: IDOUT = 15'b100000000101100;
            MOV: IDOUT = 15'b100000000000000;
            LSL: IDOUT = 15'b100000010000000;
            LSR: IDOUT = 15'b100000010001000;
            JMR: IDOUT = 15'b000100000000000;
            BZ : IDOUT = 15'b000010000000101;
            BNZ: IDOUT = 15'b000011000000101;
            JMP: IDOUT = 15'b000110000000101;
            JML: IDOUT = 15'b100110000111111;            
        endcase
    end
endmodule

