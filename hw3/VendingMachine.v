module VendingMachine(input [4:0]cash, input reg [4:0]coins, input [5:0]coke, input clk)
    parameter price = 1.5;
    parameter running = 0;
    parameter STATE0;
    //need to do states
    case(cash): begin
            5'b10000: assign running = running + 1;
            5'b01000: assign running = running + .5;
            5'b00100: assign running = running + .25;
            5'b00010: assign running = running + .10;
            5'b00001: assign running = running + .05;
    end 
    
    
    
    
    
    
    if(cash > price): begin
        case(coins): begin
            5'b10000: begin
                        assign running = cash - 50;
                        end
                    endcase
        end
    


endmodule

//dollars half-dollars quarters dimes nickels