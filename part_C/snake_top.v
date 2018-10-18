

module snake_top(

);

wire died; // 1 if the snake just died
wire init_snake; //1 if the snake is to be set to init value
wire screen_black; //1 if screen is set all black
wire screen_pause; //1 for freeze (dead or pause) and 0 for running snake





//FSM that determines if anything is ouput on screen
game_state gs(clk, died, key_code, init_snake, screen_black, screen_pause);

endmodule