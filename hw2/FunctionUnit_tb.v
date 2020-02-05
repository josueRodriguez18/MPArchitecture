`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2020 04:07:17 AM
// Design Name: 
// Module Name: FunctionUnit_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FunctionUnit_tb(

    );
    reg clock; reg [15:0]A; reg [15:0]B; reg [3:0]S; reg MF;
    wire [15:0]data; wire V, C, Zr, N, Il, Ir;
    
    functionUnit uut(clock, A, B, S, MF, data, V, C, Zr, N, Il, Ir);
    initial begin
        clock = 0;
        A = 16'd0;
        B = 16'd0;
        S = 4'd0;
        MF = 0;    
    end
    
    always begin
        #10 //transfer
        clock = ~clock;
        A = 16'd15;
        #10 //increment
        S = 4'b0001;
        clock = ~clock;
        A = 16'd15;
        #10 //addition
        S = 4'b0010;
        B = 16'd11;
        clock = ~clock;
        #10 //Positive addition with overflow
        S = 4'b0010;
        A = 16'd32760;
        clock = ~clock;
        #10 // addition with carry in
        A = 16'd15;
        S = 4'b0011;
        clock = ~clock;
        #10 // A + ~B
        S = 4'b0100;
        clock = ~clock;
        #10 // A + ~B + 1 (2's comp of b)
        S = 4'b0101;
        clock = ~clock;
        #10 // Decrement A
        S = 4'b0110;
        clock = ~clock;
        #10 //Transfer
        S = 4'b0111;
        clock = ~clock;
        #10 //AND
        S = 4'b1000;
        clock = ~clock;
        #10 //or
        S = 4'b1010;
        clock = ~clock;
        #10 //xor
        S = 4'b1100;
        clock = ~clock;
        #10 //not
        S = 4'b1110;
        clock = ~clock;
        #10
        MF = 1;
        S = 4'b0010;
        clock = ~clock;
        #10
        S = 4'b0100;
        clock = ~clock;
        
        
    
    
    
    
    end
    
    
    
    
    
    
    
    
endmodule
