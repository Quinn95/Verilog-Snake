


module game_state
    ( input clk
    , input died
    , input key_code
    , output init_snake
    , output screen_black
    , output screen_pause
    );
    
    reg [1:0] State_cur, State_next;
    
always @(*)
begin
    case(State_cur) begin
    
    end
end
 
endmodule