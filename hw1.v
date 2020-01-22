module hw1(input a, input b, input c, output Y);
    wire b_not, o1_y;

    not inv (b, b_not); //not b
    or o1 (o1_y, b_not, c); //(not b) OR c
    and o2 (Y, o1_y, a); // a AND ((not b) OR c)

    //assign Y = a & (!b + c)

endmodule