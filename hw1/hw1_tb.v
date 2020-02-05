`timescale 1ns/1ps
module hw1_tb();
    reg a = 0;
    reg b = 0;
    reg c = 0;
    wire y0;
    hw1 uut(a,b,c, y0);
    initial begin
      a = 0;
      b = 0;
      c = 0;
    end
      #10
      a = 0;
      b = 0;
      c = 1;
      #10
      a = 0;
      b = 1;
      c = 0;
      #10
      a = 0;
      b = 1;
      c = 1;
      #10
      a = 1;
      b = 0;
      c = 0;
      #10
      a = 1;
      b = 0;
      c = 1;
      #10
      a = 1;
      b = 1;
      c = 0;
      #10
      a = 1;
      b = 1;
      c = 1;
      #10




endmodule