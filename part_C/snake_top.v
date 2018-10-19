

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

    reg [11:0] rgb, rgb_next;
    
    wire key_pressed; // turns high for one ps2 clock cycle when a key is pressed
    wire [7:0] key_code; // the 8 bit code of the last key pressed
    
    // 66 possible x values (0, 63) for visible, 64 for OOB right, 127 for OOB left
    `define posX 6:0
    // 50 possible y values (0, 47) for visible, 48 for OOB right,  63 for OOB left
    `define posY 12:7
    // combine x and y positions into one vector, store in array for each of four snake segments
    reg [12:0] positions[3:0];
    
    clkdiv25 cd25 (clk, clk25);

    display display(.clk25(clk25), .rgb(rgb), .red_out(vgaRed),
                    .blue_out(vgaBlue), .green_out(vgaGreen),
                    .hSync(Hsync), .vSync(Vsync));

    ps2 keyboard(.clk(PS2Clk), .data(PS2Data), .key_pressed(key_pressed),
                 .last_pressed(key_code));
    
    //FSM that determines if anything is ouput on screen
    game_state gs(clk, died, key_code, init_snake, screen_black, screen_pause);

    reg [11:0] x = 0, y = 0;
    reg [3:0] delta = 1;
    
    reg [2:0] seg = 0;
    
    initial begin
        positions[0] = 3;
        positions[1] = 2;
        positions[2] = 1;
        positions[3] = 0;
    end
    
    reg done = 0;
    
    assign died = 0;
    
    always @(*) begin
        done = 0;
        for (seg = 0; (seg < 4) && (!done); seg = seg + 1) begin
            if (((x >= 10*positions[seg][`posX]) && (x < 10*positions[seg][`posX] + 10))
                && ((y >= 10*positions[seg][`posY]) && (y < 10*positions[seg][`posY] + 10))) begin
                if (seg == 0) begin
                    rgb_next = 12'hF00;
                    done = 1;
                end
                else if (seg == 1) begin
                    rgb_next = 12'hFF0;
                    done = 1;
                end
                else if (seg == 2) begin
                    rgb_next = 12'hFFF;
                    done = 1;
                end
                else if (seg == 3) begin
                    rgb_next = 12'h000;
                    done = 1;
                end
            end
             else
                rgb_next = 12'h00F;
        end
    end
    
    always @(posedge clk25) begin
        //update current pixel (x, y)
        x <= (x == 799) ? 0 : x + 1;
        y <= (x == 799) ? ((y == 524) ? 0 : y + 1) : y;
        
        if (screen_black == 1) begin
            rgb <= 12'h000;
        end
        else begin
            rgb <= rgb_next;
        end
    end
    
        
    reg [5:0] slow_vsync_count = 0;
    reg slow_vsync = 1;
    always @(negedge Vsync) begin
        if (slow_vsync_count == 5) begin
            slow_vsync <= ~slow_vsync;
            slow_vsync_count <= 1;
        end
        else
            slow_vsync_count <= 1;
    end
    
    always @(negedge Vsync) begin
        if (init_snake == 1) begin
            positions[0] = 3;
            positions[1] = 2;
            positions[2] = 1;
            positions[3] = 0;
        end
        else if (screen_pause == 0) begin
            for(seg = 3; seg > 0; seg = seg - 1) begin
                positions[seg] <= positions[seg - 1];
            end

            //left
            if (key_code == 8'h74) begin
                positions[0][`posX] <= positions[0][`posX] + 1; 
            end
            //right
            else if (key_code == 8'h6B) begin
                positions[0][`posX] <= positions[0][`posX] - 1; 
            end
            //down
            else if (key_code == 8'h72) begin
                positions[0][`posY] <= positions[0][`posY] + 1; 
            end
            //up
            else if (key_code == 8'h75) begin
                positions[0][`posY] <= positions[0][`posY] - 1; 
            end
        end
    end

endmodule