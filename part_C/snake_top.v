

module snake_top
    ( input clk
    , input PS2Clk
    , input PS2Data
    , output [3:0] vgaRed
    , output [3:0] vgaBlue
    , output [3:0] vgaGreen
    , output Hsync
    , output Vsync
    );
    
    wire clk25;

    wire died; // 1 if the snake just died
    wire init_snake; //1 if the snake is to be set to init value
    wire screen_black; //1 if screen is set all black
    wire screen_pause; //1 for freeze (dead or pause) and 0 for running snake

    reg [11:0] rgb;
    
    wire key_pressed; // turns high for one ps2 clock cycle when a key is pressed
    wire [7:0] key_code; // the 8 bit code of the last key pressed

    clkdiv25 cd25 (clk, clk25);

    display display(.clk25(clk25), .rgb(rgb), .red_out(vgaRed),
                    .blue_out(vgaBlue), .green_out(vgaGreen),
                    .hSync(Hsync), .vSync(Vsync));

    ps2 keyboard(.clk(PS2Clk), .data(PS2Data), .key_pressed(key_pressed),
                 .last_pressed(key_code));
    
    //FSM that determines if anything is ouput on screen
    //game_state gs(clk, died, key_code, init_snake, screen_black, screen_pause);

    reg [11:0] x = 0, y = 0;
    reg [12:0] posX = 0, posY = 0;
    reg [3:0] delta = 5;
        
    always @(posedge clk25) begin
        x <= (x == 799) ? 0 : x + 1;
        y <= (x == 799) ? ((y == 524) ? 0 : y + 1) : y;
        if (((x > (posX) && (x < posX + 80))
            && ((y > posY) && (y < posY + 80))))
            rgb <= 12'h00F;
        else
            rgb <= 12'hF00;
    end
    
    always @(negedge Vsync) begin
    //left
    if (key_code == 8'h74) begin
        if (posX == (640 - 80)) begin
            posX <= posX;
        end
        else begin
            posX <= posX + delta;
        end
    end
    //right
    else if (key_code == 8'h6B) begin
        if (posX == 0) begin
            posX <= posX;
        end
        else begin
            posX <= posX - delta;
        end
    end
    //down
    else if (key_code == 8'h72) begin
        if (posY == (480 - 80)) begin
            posY <= posY;
        end
        else begin
            posY <= posY + delta;
        end
    end
    //up
    else if (key_code == 8'h75) begin
        if (posY == 0) begin
            posY <= posY;
        end
        else begin
            posY <= posY - delta;
        end
    end
    end

endmodule