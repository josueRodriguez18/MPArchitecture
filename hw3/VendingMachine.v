module VendingMachine(input [5:0]item_select, input [4:0]bank, input [4:0]coin, input [5:0]coke_inventory, input clk, input reset, output [5:0]dispend_change, output reg [5:0]dispend_coke);
                                        //coin input    coke_inventory inventory  clock       reset
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
    parameter VENDING = 5'b11111;
    parameter VOID_TRANSACTION = 5'b01111;
    //need to do states
    reg state; reg next_state = IDLE; reg [2:0]quarter_counter = 3'b0; reg [6:0]running_change; reg vend = 0; reg [5:0]temp;
    always @(state or coin)
        begin
            case(state)
                IDLE:
                    case(coin)
                        NICKEL:
                            begin 
                                next_state = FIVE;
                                temp = 5'b000001; // one nickel
                            end
                        DIME: 
                            begin
                                next_state = 10;
                                temp = 5'b000010;
                            end
                        QUARTER: 
                            begin
                                next_state = state;
                               quarter_counter = quarter_counter + 1'b1;
                            end
                        HALFD:
                            begin 
                                next_state = state;
                                quarter_counter = quarter_counter + 2;
                            end
                        FULLD:
                            begin
                                next_state = state;
                                quarter_counter = quarter_counter + 4;
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
                                quarter_counter = quarter_counter + 1; //running_change=NICKEL 
                            end
                        HALFD:
                            begin
                                next_state = state;
                                quarter_counter = quarter_counter + 2;
                            end
                        FULLD:
                            begin
                                next_state = state;
                                quarter_counter = quarter_counter + 4;
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
                                quarter_counter = quarter_counter + 1;
                            end
                        HALFD:
                            begin
                                next_state = state;
                                quarter_counter = quarter_counter + 2;
                            end
                        FULLD:
                            begin
                                next_state = state;
                                quarter_counter = quarter_counter + 4;
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
                                quarter_counter = quarter_counter + 1; //running_change=NICKEL 
                            end
                        HALFD:
                            begin
                                next_state = state;
                                quarter_counter = quarter_counter + 2;
                            end
                        FULLD:
                            begin
                                next_state = state;
                                quarter_counter = quarter_counter + 4;
                            end
                        default: next_state=FIFTEEN; 
                    endcase 
                TWENTY: 
                    case(coin) 
                        NICKEL: 
                            begin
                                next_state=state;
                                quarter_counter = quarter_counter + 1;
                            end
                        QUARTER:    
                            begin
                                next_state=state;
                                quarter_counter = quarter_counter + 1; 
                            end
                        HALFD:
                            begin
                                next_state = state;
                                quarter_counter = quarter_counter + 2;
                            end
                        FULLD:
                            begin
                                next_state = state;
                                quarter_counter = quarter_counter + 4;
                            end
                        default: next_state=TWENTY;
                        endcase
            endcase
    
end
//max running_change is 95 cents
always @(posedge clk)
    begin
        if(reset) //reset switch
            begin
                state = IDLE;
                quarter_counter = 0;
                
            end
    if(quarter_counter >= 6 &(coke_inventory & item_select)) //the right amount of money and item is available
            begin
                //running_change = 6 - quarter_counter;
                quarter_counter = 6 - quarter_counter;
                running_change = state

                state = VENDING;
            end
     else state = VOID_TRANSACTION;
     
     case(state)
        VENDING:
            begin
                dispend_coke = item_select;
                case(quarter_counter)
                    2:  
                        case(bank)
                            5'b1xxxx: quarter_counter = quarter_counter - 4; //dollar
                            5'b01xxx: quarter_counter = quarter_counter - 2; //half dollar
                            5'b001xx: quarter_counter = quarter_counter - 1; //quarter
                            5'b0001x: 
                                begin 
                                    case(running_change)
                                        FIVE:
                                            begin 
                                                running_change = TWENTY;
                                                quarter_counter = quarter_counter - 1;
                                            end
                                        TEN: 
                                            begin
                                                running_change = 0;
                                                quarter_counter = quarter_counter - 1;
                                            end 
                                        FIFTEEN: running_change = FIVE;
                                        TWENTY: running_change = TEN;
                                    endcase
                                end    
                            5'b00001:
                                begin
                                    case(running_change)
                                        begin
                                            FIVE:
                                                begin 
                                                    running_change = 0;
                                                    quarter_counter = quarter_counter - 1;
                                                end
                                            TEN: running_change = FIVE;
                                            FIFTEEN: running_change = TEN;
                                            TWENTY: running_change = FIFTEEN;
                    1:
                        begin
                            case(bank)
                                5'bxx1xx: quarter_counter = quarter_counter - 1; //quarter
                                5'bxx01x:
                                    begin
                                        case(running_change)
                                                FIVE:
                                                    begin
                                                        running_change = TWENTY;
                                                        quarter_counter = quarter_counter - 1;
                                                    end
                                                TEN: 
                                                    begin
                                                        running_change = 0;
                                                        quarter_counter = quarter_counter - 1;
                                                    end
                                                FIFTEEN: running_change = FIVE;
                                                TWENTY: running_change = TEN;
                                        endcase
                                    end
                        end
                    0:
                        begin
                            case(bank)
                                begin
                                    5'bxxx10:
                                        case(running_change)
                                            FIVE: next_state = VOID_TRANSACTION;
                                            TEN: running_change = 0;
                                            FIFTEEN: running_change = FIVE;
                                            TWENTY: running_change = TEN;
                                        endcase
                                    5'bxxx01:
                                        case(running_change)
                                            FIVE: running_change = 0;
                                            TEN: running_change = FIVE;
                                            FIFTEEN: running_change = TEN;
                                            TWENTY: running_change = FIFTEEN;
                                end
                        end

                                    

                                        

                next_state = VENDING;
                
            end
        VOID_TRANSACTION:
            begin
                dispend_coke = 5'b0;
            end
        
        
        default state = next_state;
        endcase
    end
    


endmodule
//dollars half-dollars quarters dimes nickels