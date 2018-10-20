

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

    reg died; // 1 if the snake just died
    wire init_snake; //1 if the snake is to be set to init value
    wire screen_black; //1 if screen is set all black
    wire screen_pause; //1 for freeze (dead or pause) and 0 for running snake

    reg [11:0] rgb, rgb_next;
    
    wire key_pressed; // turns high for one ps2 clock cycle when a key is pressed
    wire [7:0] key_code; // the 8 bit code of the last key pressed
    
    //0:up, 1:down, 2:left, 3:right
    reg [1:0] direction = 3;
    
    // 66 possible x values (0, 63) for visible, 64 for OOB right, 127 for OOB left
    `define posX 6:0
    // 50 possible y values (0, 47) for visible, 48 for OOB right,  63 for OOB left
    `define posY 12:7
    // combine x and y positions into one vector, store in array for each of four snake segments
    reg [12:0] positions[20:0];
    
    clkdiv25 cd25 (clk, clk25);

    display display(.clk25(clk25), .rgb(rgb), .red_out(vgaRed),
                    .blue_out(vgaBlue), .green_out(vgaGreen),
                    .hSync(Hsync), .vSync(Vsync));

    ps2 keyboard(.clk(PS2Clk), .data(PS2Data), .key_pressed(key_pressed),
                 .last_pressed(key_code));
    
    //FSM that determines if anything is ouput on screen
    game_state gs(clk, died, key_code, init_snake, screen_black, screen_pause);

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
        for (seg = 4; seg < 20; seg = seg + 1) begin
            positions[seg][`posX] = 64;
            positions[seg][`posY] = 50;
        end
    end
    
        
    
    always @(*) begin
        died = 0;
        for (seg = 1; seg < 20; seg = seg + 1) begin
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
                
        for (seg = 0; seg < 20; seg = seg + 1) begin
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
            rgb <= 12'h0F0;
        end
        else begin
            rgb <= rgb_next;
        end
    end
    
        
    reg [5:0] slow_vsync_count = 0;
    reg slow_vsync = 1;
    always @(negedge Vsync) begin
        if (slow_vsync_count == 10) begin
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
            for (seg = 4; seg < 20; seg = seg + 1) begin
                positions[seg][`posX] <= 64;
                positions[seg][`posY] <= 50;
            end
        end
  
        else if (screen_pause == 0) begin
        
            if (slow_vsync) begin
                if (positions[0] == apple) begin
                    apple <= apple_next;
                    size <= size + 1;
                    positions[size] <= positions[size-1];
                end
                
                for(seg = 20; seg > 0; seg = seg - 1) begin
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
                if ((direction == 0) || (direction == 1))
                    direction <= 3;
            end
            //left
            else if (key_code == 8'h6B) begin
                if ((direction == 0) || (direction == 1))
                    direction <= 2;
            end
            //down
            else if (key_code == 8'h72) begin
                if ((direction == 2) || (direction == 3))
                    direction <= 1;
            end
            
        end // screen_pause == 0
    end

endmodule