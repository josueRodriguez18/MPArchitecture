module ALU(input A, input B, input [1:0]S, output G, output Z, output N, output O, output C );
    wire andY, orY, addY;
    and g0(andY, A, B);
    or g1(orY, A, B);

    case (S):
        2'b00: 