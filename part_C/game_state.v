


module game_state
    ( input clk
    , input died
    , input [7:0] key_code
    , output reg init_snake
    , output reg screen_black
    , output reg screen_pause
    );
    
    reg [1:0] State_cur = 0, State_next = 0;
    
always @(*)
begin
    case(State_cur)
        0: begin //state "black"
            if (key_code == 8'h1B) begin //input S
                init_snake = 1;
                State_next = 1;
                screen_black = 0;
                screen_pause = 0;
            end
            else begin // stay black 
                screen_black = 1;
                init_snake = 0;
                screen_pause = 0;
                State_next = State_cur;
            end
        end
        1 : begin // state "run"
            if (key_code == 8'h1B) begin //input S
                init_snake = 1;
                screen_black = 0;
                screen_pause = 0;
                State_next = State_cur;
            end
            else if (key_code == 8'h76) begin //input Esc
                screen_black = 1;
                State_next = 0;
                init_snake = 0;
                screen_pause = 0;
            end
            else if (key_code == 8'h4D) begin // input P
                screen_pause = 1;
                State_next = 2;
                init_snake = 0;
                screen_black = 0;
            end
            else if (died == 1) begin
                screen_pause = 1;
                State_next = 3;
                init_snake = 0;
                screen_black = 0;
            end
            else begin //keep running 
                screen_pause = 0;
                State_next = State_cur;
                init_snake = 0;
                screen_black = 0;
            end
        end
        2 : begin // state "pause"
            if (key_code == 8'h1B) begin //input S
                init_snake = 1;
                State_next = 1;
                screen_black = 0;
                screen_pause = 0;
            end
            else if (key_code == 8'h2D) begin //input R
                State_next = 1;
                init_snake = 0;
                screen_black = 0;
                screen_pause = 0;
            end
            else if (key_code == 8'h76) begin //input Esc
                screen_black = 1;
                State_next = 0;
                init_snake = 0;
                screen_pause = 0;
            end
            else begin // stay at pause
                screen_pause = 1;
                init_snake = 0;
                screen_black = 0;
                State_next = State_cur;
            end
        end
        3 : begin // state "game over"
            if (key_code == 8'h1B) begin //input S
                init_snake = 1;
                State_next = 1;
                screen_black = 0;
                screen_pause = 0;
            end
            else if (key_code == 8'h76) begin //input Esc
                screen_black = 1;
                State_next = 0;
                init_snake = 0;
                screen_pause = 0;
            end
            else begin // stay at game over
                screen_pause = 1;
                init_snake = 0;
                screen_black = 0;
                State_next = State_cur;
            end
        end
    endcase
end

always @(negedge clk)
begin
    State_cur <= State_next;
end
 
endmodule