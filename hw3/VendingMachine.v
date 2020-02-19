module VendingMachine(input [5:0]item_select, input [4:0]bank, input [4:0]coin, input [5:0]coke_inventory, input clk, input reset, output reg [5:0]dispend_change, output reg [5:0]dispend_coke);
                                        //coin input    coke_inventory inventory  clock       reset
    parameter IDLE = 0;
    parameter FIVE = 1;
    parameter TEN = 2;
    parameter FIFTEEN = 3;
    parameter TWENTY = 4;
    parameter NICKEL =  5'b00001;
    parameter DIME =    5'b00010;
    parameter QUARTER = 5'b00100;
    parameter HALFD =   5'b01000;
    parameter FULLD =   5'b10000;
    parameter VENDING = 5'b11111; //random state value
    parameter VOID_TRANSACTION = 5'b01111; //random state value
    //need to do states
    reg state = IDLE; reg next_state = IDLE; reg [2:0]quarter_counter = 3'b0; reg [2:0]running_change; reg vend = 0;
    always @(state or coin)
        begin
            case(state)
                IDLE: //nothing has happened
                    case(coin)
                        NICKEL: next_state = FIVE; //total is 5 no quarters
                        DIME: next_state = TEN; //total is 10 no quarters
                        QUARTER: 
                            begin
                                next_state = state; //total is 25 (1 quarter)
                               quarter_counter = quarter_counter + 1'b1;
                            end
                        HALFD:
                            begin 
                                next_state = state; //total is 50 (2 quarters)
                                quarter_counter = quarter_counter + 2;
                            end
                        FULLD:
                            begin
                                next_state = state; //total is 100 (4 quarters)
                                quarter_counter = quarter_counter + 4;
                            end
                        default: next_state = IDLE; //no new coins have been added return to IDLE
                    endcase
                FIVE: 
                    case(coin) 
                        NICKEL: next_state=TEN; // total is TEN + Quarters
                        DIME: next_state=FIFTEEN; //total is FIFTEEN + Quarters
                        QUARTER:    
                            begin
                                next_state=state; //total is current amount + (1+previous) Quarters
                                quarter_counter = quarter_counter + 1; //increment quarter counter
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
                default:next_state = state;
            endcase
    
end
//max running_change is 95 cents
always @(posedge clk)
    begin
        if(reset)
            begin
                state = IDLE;
                quarter_counter = 0;
            end
        else if(quarter_counter >= 6 &(coke_inventory & item_select)) //the right amount of money and item is available
            begin
                quarter_counter = 6 - quarter_counter;
                running_change = state;
                state = VENDING;
                dispend_coke = item_select;
            end
        else state = VOID_TRANSACTION;
        case(state)
            VENDING:
                case(quarter_counter) // max change is only ever 95 cents (3 quarters + 20 cents)
                    3:
                        case(bank)
                            5'bx1xxx: 
                                begin
                                    quarter_counter = quarter_counter - 2; //half dollar
                                    dispend_change = 5'b01000; //dispend half dollar
                                end
                            5'bx01xx: 
                                begin
                                    quarter_counter = quarter_counter - 1; //quarter
                                    dispend_change = 5'b00100;
                                end
                            5'bx001x:
                                        begin
                                            dispend_change = 5'b00010;
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
                            5'bx0001:
                                    begin
                                        dispend_change = 5'b00001;
                                        case(running_change)
                                            FIVE: 
                                                begin
                                                    running_change = 0;
                                                    quarter_counter = quarter_counter - 1;
                                                end
                                            TEN: running_change = FIVE;
                                            FIFTEEN: running_change = TEN;
                                            TWENTY: running_change = FIFTEEN;
                                        endcase
                                    end
                        endcase
                    
                    
                    
                    2:
                        case(bank)
                                5'bx1xxx: 
                                    begin
                                        quarter_counter = quarter_counter - 2; //half dollar
                                        dispend_change = 5'b01000; //dispend half dollar
                                    end
                                5'bx01xx: 
                                    begin
                                        quarter_counter = quarter_counter - 1; //quarter
                                        dispend_change = 5'b00100;
                                    end
                                5'bx001x:
                                        begin
                                            dispend_change = 5'b00010;
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
                                5'bx0001:
                                        begin
                                            dispend_change = 5'b00001;
                                            case(running_change)
                                                FIVE: 
                                                    begin
                                                        running_change = 0;
                                                        quarter_counter = quarter_counter - 1;
                                                    end
                                                TEN: running_change = FIVE;
                                                FIFTEEN: running_change = TEN;
                                                TWENTY: running_change = FIFTEEN;
                                            endcase
                                        end
                        endcase
                    1:
                        case(bank)
                            5'bxx1xx: 
                                begin
                                    quarter_counter = quarter_counter - 1; //quarter
                                    dispend_change = 5'b00100;
                                end
                            5'bxx01x:
                                begin
                                    dispend_change = 5'b00010;
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
                            5'bxx001:
                                begin
                                    dispend_change = 5'b00001;
                                    case(running_change)
                                                FIVE: 
                                                    begin
                                                        running_change = 0;
                                                        quarter_counter = quarter_counter - 1;
                                                    end
                                                TEN: running_change = FIVE;
                                                FIFTEEN: running_change = TEN;
                                                TWENTY: running_change = FIFTEEN;
                                        endcase
                                end
                        endcase
                        
                    0:
                        case(bank)
                            5'bxxx10:
                                begin
                                    dispend_change = 5'b00010;
                                    case(running_change)
                                        FIVE: next_state = VOID_TRANSACTION;
                                        TEN: running_change = 0;
                                        FIFTEEN: running_change = FIVE;
                                        TWENTY: running_change = TEN;
                                    endcase
                                end
                            5'bxxx01:
                                begin
                                    dispend_change = 5'b00001;
                                    case(running_change)
                                        FIVE: running_change = 0;
                                        TEN: running_change = FIVE;
                                        FIFTEEN: running_change = TEN;
                                        TWENTY: running_change = FIFTEEN;
                                    endcase
                                end
                        endcase
            
                endcase
            VOID_TRANSACTION:
                begin
                    dispend_coke = 5'b0;
                
                end
        endcase
    end    

endmodule
