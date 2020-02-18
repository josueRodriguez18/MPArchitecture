module VendingMachine(input [4:0]cash, input reg [4:0]coin, input [5:0]coke, input clk, input );
    reg [5:0]sel;
    assign coke = sel;
    parameter price = 150;
    parameter running = 0;
    parameter IDLE;
    parameter FIVE;
    parameter TEN;
    parameter FIFTEEN;
    parameter TWENTY;
    parameter TWENTYFIVE;
    parameter counter = 0;
    parameter NICKEL;
    parameter DIME;
    parameter QUARTER;
    parameter HALFD;
    parameter FULLD;
    //need to do states
    wire item[2:0];
    reg state, reg next_state;
    always @(state or coin or count)
        begin
        next_state = IDLE;
            case(state)
                IDLE:
                    case(coin)
                        NICKEL: next_state = FIVE;
                        DIME: next_state = 10;
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
                                counter = counter + 1
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
        if (counter >= 6) // change calculation
            begin
                change = (6 - counter)*25 + state
            end
    
    
//max change is 95 cents
    
    
    
    if(running >= price): begin
        case(coins): begin
            5'b10000: //half dollar
                begin
                    assign running = cash - 50;
                end
            
                    endcase
        end
    


endmodule

//dollars half-dollars quarters dimes nickels