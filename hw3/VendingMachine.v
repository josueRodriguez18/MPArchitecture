module VendingMachine(input [4:0]cash, input [4:0]coin, input [5:0]coke, input clk);
    reg [5:0]sel;
    assign coke = sel;
    parameter price = 150;
    parameter running = 0;
    parameter IDLE = 0;
    parameter FIVE = 1;
    parameter TEN = 2;
    parameter FIFTEEN = 3;
    parameter TWENTY = 4;
    parameter TWENTYFIVE = 5;
    parameter NICKEL =  5'b00001;
    parameter DIME =    5'b00010;
    parameter QUARTER = 5'b00100;
    parameter HALFD =   5'b01000;
    parameter FULLD =   5'b10000;
    //need to do states
    reg state; reg next_state = IDLE; reg [2:0]counter = 3'b0; reg [6:0]change;
    always @(state or coin)
        begin
            case(state)
                IDLE:
                    case(coin)
                        NICKEL: next_state = FIVE;
                        DIME: next_state = 10;
                        QUARTER: 
                            begin
                                next_state = state;
                               counter = counter + 1'b1;
                            end
                        HALFD:
                            begin 
                                next_state = state;
                                counter = counter + 2;
                            end
                        FULLD:
                            begin
                                next_state = state;
                                counter = counter + 4;
                            end
                        default: next_state = IDLE;
                    endcase
                FIVE: 
                    case(coin) 
                        NICKEL: next_state=TEN; 
                        DIME: next_state=FIFTEEN; 
                        QUARTER:    
                            begin
                                next_state=state;
                                counter = counter + 1; //change=NICKEL 
                            end
                        HALFD:
                            begin
                                next_state = state;
                                counter = counter + 2;
                            end
                        FULLD:
                            begin
                                next_state = state;
                                counter = counter + 4;
                            end
                        default: next_state=FIVE; 
                    endcase 
                TEN: 
                    case(coin) 
                        NICKEL: next_state=FIFTEEN;
                        DIME: next_state=TWENTY; 
                        QUARTER: 
                            begin
                                next_state = state;
                                counter = counter + 1;
                            end
                        HALFD:
                            begin
                                next_state = state;
                                counter = counter + 2;
                            end
                        FULLD:
                            begin
                                next_state = state;
                                counter = counter + 4;
                            end
                        default: next_state=TEN; 
                    endcase 
                FIFTEEN: 
                    case(coin) 
                        NICKEL: next_state=TWENTY; 
                        DIME:
                            begin 
                                next_state=state; 
                            end
                        QUARTER:    
                            begin
                                next_state=state;
                                counter = counter + 1; //change=NICKEL 
                            end
                        HALFD:
                            begin
                                next_state = state;
                                counter = counter + 2;
                            end
                        FULLD:
                            begin
                                next_state = state;
                                counter = counter + 4;
                            end
                        default: next_state=FIFTEEN; 
                    endcase 
                TWENTY: 
                    case(coin) 
                        NICKEL: 
                            begin
                                next_state=state;
                                counter = counter + 1;
                            end
                        QUARTER:    
                            begin
                                next_state=state;
                                counter = counter + 1; 
                            end
                        HALFD:
                            begin
                                next_state = state;
                                counter = counter + 2;
                            end
                        FULLD:
                            begin
                                next_state = state;
                                counter = counter + 4;
                            end
                        default: next_state=TWENTY;
                        endcase
            endcase
        if(counter >= 6)
            begin
                change = (6 - counter)*25 + state;
            end
    
end
//max change is 95 cents
    
    


endmodule

//dollars half-dollars quarters dimes nickels