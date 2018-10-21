`define SNAKE_MAX 100

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
    
    reg [10:0] tx, ty;
    reg text[63:0][47:0];
    
    initial begin
        for (tx = 0; tx < 64; tx = tx + 1) begin
            for (ty = 0; ty < 48; ty = ty + 1) begin
                text[tx][ty] = 0;
            end
        end
        text[3][5] = 1;
        text[4][5] = 1;
        text[5][5] = 1;
        text[6][5] = 1;
        text[7][5] = 1;
        text[8][5] = 1;
        text[9][5] = 1;
        text[10][5] = 1;
        text[13][5] = 1;
        text[14][5] = 1;
        text[22][5] = 1;
        text[32][5] = 1;
        text[33][5] = 1;
        text[43][5] = 1;
        text[48][5] = 1;
        text[49][5] = 1;
        text[52][5] = 1;
        text[53][5] = 1;
        text[54][5] = 1;
        text[55][5] = 1;
        text[56][5] = 1;
        text[57][5] = 1;
        text[58][5] = 1;
        text[3][6] = 1;
        text[13][6] = 1;
        text[14][6] = 1;
        text[15][6] = 1;
        text[22][6] = 1;
        text[31][6] = 1;
        text[32][6] = 1;
        text[33][6] = 1;
        text[34][6] = 1;
        text[43][6] = 1;
        text[47][6] = 1;
        text[48][6] = 1;
        text[52][6] = 1;
        text[3][7] = 1;
        text[13][7] = 1;
        text[15][7] = 1;
        text[16][7] = 1;
        text[22][7] = 1;
        text[30][7] = 1;
        text[31][7] = 1;
        text[34][7] = 1;
        text[35][7] = 1;
        text[43][7] = 1;
        text[46][7] = 1;
        text[47][7] = 1;
        text[52][7] = 1;
        text[3][8] = 1;
        text[13][8] = 1;
        text[16][8] = 1;
        text[17][8] = 1;
        text[22][8] = 1;
        text[29][8] = 1;
        text[30][8] = 1;
        text[35][8] = 1;
        text[36][8] = 1;
        text[43][8] = 1;
        text[45][8] = 1;
        text[46][8] = 1;
        text[52][8] = 1;
        text[3][9] = 1;
        text[4][9] = 1;
        text[5][9] = 1;
        text[6][9] = 1;
        text[7][9] = 1;
        text[8][9] = 1;
        text[9][9] = 1;
        text[10][9] = 1;
        text[13][9] = 1;
        text[17][9] = 1;
        text[18][9] = 1;
        text[22][9] = 1;
        text[28][9] = 1;
        text[29][9] = 1;
        text[36][9] = 1;
        text[37][9] = 1;
        text[43][9] = 1;
        text[44][9] = 1;
        text[45][9] = 1;
        text[52][9] = 1;
        text[53][9] = 1;
        text[54][9] = 1;
        text[55][9] = 1;
        text[56][9] = 1;
        text[57][9] = 1;
        text[58][9] = 1;
        text[10][10] = 1;
        text[13][10] = 1;
        text[18][10] = 1;
        text[19][10] = 1;
        text[22][10] = 1;
        text[27][10] = 1;
        text[28][10] = 1;
        text[29][10] = 1;
        text[30][10] = 1;
        text[31][10] = 1;
        text[32][10] = 1;
        text[33][10] = 1;
        text[34][10] = 1;
        text[35][10] = 1;
        text[36][10] = 1;
        text[37][10] = 1;
        text[38][10] = 1;
        text[43][10] = 1;
        text[45][10] = 1;
        text[46][10] = 1;
        text[52][10] = 1;
        text[10][11] = 1;
        text[13][11] = 1;
        text[19][11] = 1;
        text[20][11] = 1;
        text[22][11] = 1;
        text[26][11] = 1;
        text[27][11] = 1;
        text[38][11] = 1;
        text[39][11] = 1;
        text[43][11] = 1;
        text[46][11] = 1;
        text[47][11] = 1;
        text[52][11] = 1;
        text[10][12] = 1;
        text[13][12] = 1;
        text[20][12] = 1;
        text[21][12] = 1;
        text[22][12] = 1;
        text[25][12] = 1;
        text[26][12] = 1;
        text[39][12] = 1;
        text[40][12] = 1;
        text[43][12] = 1;
        text[47][12] = 1;
        text[48][12] = 1;
        text[52][12] = 1;
        text[3][13] = 1;
        text[4][13] = 1;
        text[5][13] = 1;
        text[6][13] = 1;
        text[7][13] = 1;
        text[8][13] = 1;
        text[9][13] = 1;
        text[10][13] = 1;
        text[13][13] = 1;
        text[21][13] = 1;
        text[22][13] = 1;
        text[25][13] = 1;
        text[40][13] = 1;
        text[43][13] = 1;
        text[48][13] = 1;
        text[49][13] = 1;
        text[52][13] = 1;
        text[53][13] = 1;
        text[54][13] = 1;
        text[55][13] = 1;
        text[56][13] = 1;
        text[57][13] = 1;
        text[58][13] = 1;
    end
    
    wire clk25;

    reg died; // 1 if the snake just died
    wire init_snake; //1 if the snake is to be set to init value
    wire screen_black; //1 if screen is set all black
    wire screen_pause; //1 for freeze (dead or pause) and 0 for running snake

    reg [11:0] rgb, rgb_next;
    
    wire key_pressed; // turns high for one ps2 clock cycle when a key is pressed
    wire [7:0] key_code; // the 8 bit code of the last key pressed
    
    //0:up, 1:down, 2:left, 3:right
    reg [1:0] direction = 3;
    reg [1:0] direction_last = 3;
    
    // 66 possible x values (0, 63) for visible, 64 for OOB right, 127 for OOB left
    `define posX 6:0
    // 50 possible y values (0, 47) for visible, 48 for OOB right,  63 for OOB left
    `define posY 12:7
    // combine x and y positions into one vector, store in array for each of four snake segments
    reg [12:0] positions[`SNAKE_MAX-1:0];
    
    clkdiv25 cd25 (clk, clk25);

    display display(.clk25(clk25), .rgb(rgb), .red_out(vgaRed),
                    .blue_out(vgaBlue), .green_out(vgaGreen),
                    .hSync(Hsync), .vSync(Vsync));

    ps2 keyboard(.clk(PS2Clk), .data(PS2Data), .key_pressed(key_pressed),
                 .last_pressed(key_code));
    
    //FSM that determines if anything is ouput on screen
    game_state gs(PS2Clk, died, key_code, init_snake, screen_black, screen_pause);

    reg [11:0] x = 0, y = 0;
    
    reg [10:0] seg = 0;
    reg [10:0] size = 4;
    
    reg [50:0] frame_count = 0;
    reg [12:0] apple = 6, apple_next;
    reg grow;
    
    always@(*) begin
        apple_next[`posX] = (frame_count % 63);
        apple_next[`posY] = (frame_count % 47);
    end
    
    initial begin
        positions[0] = 3;
        positions[1] = 2;
        positions[2] = 1;
        positions[3] = 0;
        for (seg = 4; seg < `SNAKE_MAX; seg = seg + 1) begin
            positions[seg][`posX] = 64;
            positions[seg][`posY] = 50;
        end
    end
    
        
    
    always @(*) begin
        died = 0;
        for (seg = 1; seg < `SNAKE_MAX; seg = seg + 1) begin
            if (positions[0] == positions[seg])
                died = 1;
        end
        died = died || (positions[0][`posX] > 63) || (positions[0][`posY] > 47);
    end
    
    
    always @(*) begin
        rgb_next = 12'hFFF;
        if (((x >= 10*apple[`posX]) && (x < 10*apple[`posX] + 10))
            && ((y >= 10*apple[`posY]) && (y < 10*apple[`posY] + 10)))
                rgb_next = 12'h0F0;
                
        for (seg = 0; seg < `SNAKE_MAX; seg = seg + 1) begin
            if (((x >= 10*positions[seg][`posX]) && (x < 10*positions[seg][`posX] + 10))
                && ((y >= 10*positions[seg][`posY]) && (y < 10*positions[seg][`posY] + 10))) begin
                    rgb_next = 12'h000;
            end
        end
    end
    
    always @(posedge clk25) begin
        //update current pixel (x, y)
        x <= (x == 799) ? 0 : x + 1;
        y <= (x == 799) ? ((y == 524) ? 0 : y + 1) : y;
        
        if (screen_black == 1) begin
            rgb <= 12'h000;
            for (tx = 0; tx < 64; tx = tx + 1) begin
                for (ty = 0; ty < 48; ty = ty + 1) begin
                    if ((x >= 10*tx) && (x < 10*tx + 10) && (y >= 10*ty) && (y < 10*ty + 10))
                        if (text[tx][ty] == 1)
                            rgb <= 12'h00F; 
                end
            end
        end
        else begin
            rgb <= rgb_next;
        end
    end
    
        
    reg [5:0] slow_vsync_count = 0;
    reg slow_vsync = 1;
    always @(negedge Vsync) begin
        if (slow_vsync_count == 5) begin
            slow_vsync <= 1;
            slow_vsync_count <= 1;
        end
        else begin
            slow_vsync_count <= slow_vsync_count + 1;
            slow_vsync <= 0;
        end
    end
    
    always @(negedge Vsync) begin
        frame_count <= frame_count + 1;
 
        if (init_snake == 1) begin
            direction <= 3;
            size <= 4;
            positions[0] <= 3;
            positions[1] <= 2;
            positions[2] <= 1;
            positions[3] <= 0;
            for (seg = 4; seg < `SNAKE_MAX; seg = seg + 1) begin
                positions[seg][`posX] <= 64;
                positions[seg][`posY] <= 50;
            end
        end
  
        else if (screen_pause == 0) begin
        
            if (slow_vsync) begin
                direction_last <= direction;
                
                if (positions[0] == apple) begin
                    apple <= apple_next;
                    size <= size + 1;
                    positions[size] <= positions[size-1];
                end
                
                for(seg = `SNAKE_MAX - 1; seg > 0; seg = seg - 1) begin
                    if (seg < size)
                        positions[seg] <= positions[seg - 1];
                end
            
                if (direction == 0) // up
                    positions[0][`posY] <= positions[0][`posY] - 1; 
                else if (direction == 1) // down
                    positions[0][`posY] <= positions[0][`posY] + 1; 
                else if (direction == 2) // left
                    positions[0][`posX] <= positions[0][`posX] - 1; 
                else // direction == 3 right
                    positions[0][`posX] <= positions[0][`posX] + 1; 
                
            end // if (slow_vsync)
            
            //update direction based on keypress
            //up
             if (key_code == 8'h75) begin
                if ((direction == 2) || (direction == 3))
                    direction <= 0;
            end
            //right
            else if (key_code == 8'h74) begin
                if ((direction_last == 0) || (direction_last == 1))
                    direction <= 3;
            end
            //left
            else if (key_code == 8'h6B) begin
                if ((direction_last == 0) || (direction_last == 1))
                    direction <= 2;
            end
            //down
            else if (key_code == 8'h72) begin
                if ((direction_last == 2) || (direction_last == 3))
                    direction <= 1;
            end
        end // screen_pause == 0
    end

endmodule