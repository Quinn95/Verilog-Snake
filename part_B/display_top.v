

module display_top
    ( input clk
    , output [3:0] vgaRed
    , output [3:0] vgaBlue
    , output [3:0] vgaGreen
    , output Hsync
    , output Vsync
    , input SW0
    , input SW1
    , input SW2
    , input SW3
    , input SW4
    , input SW5
    , input SW6
    , input SW7
    );
    
    reg [11:0] rgb = 0;
    wire clk25;
    
    reg [11:0] x = 0;
    reg [11:0] y = 0;
    
    reg dir = 0;
    reg [12:0] pos = 0;
    reg [3:0] delta = 5;
    
    reg [20:0] frame_cd = 0;
    reg frame = 0;
    always@(posedge clk) begin
        if (frame_cd == 1666666) begin // I think that's 30 fps        
            frame <= ~frame;
            frame_cd <= 0;
        end
        else
            frame_cd <= frame_cd + 1;
    end
    clkdiv25 divider(clk, clk25);
    
    display display(clk25, rgb, vgaRed, vgaBlue, vgaGreen, Hsync, Vsync);

    always @(posedge clk) begin
        if (SW0 == 1) begin
            rgb <= 12'h000;
        end
        else if (SW1 == 1) begin
            rgb <= 12'h00F;
        end
        else if (SW2 == 1) begin
            rgb <= 12'hA22;
        end
        else if (SW3 == 1) begin
            rgb <= 12'h0FF;
        end
        else if (SW4 == 1) begin
            rgb <= 12'hF00;
        end
        else if (SW == 1) begin
            rgb <= 12'hF0F;
        end
        else if (SW6 == 1) begin
            rgb <= 12'hFF0;
        end
        else if (SW7 == 1) begin
            rgb <= 12'hFFF;
        end
        else rgb <= 12'h000;
    end
/*
    always @(posedge clk25) begin
        
        x <= (x == 799) ? 0 : x + 1;
        y <= (x == 799) ? ((y == 524) ? 0 : y + 1) : y;
        if (((x > (pos) && (x < pos + 80))
            && ((y > 200) && (y < 280))))
            rgb <= 12'h00F;
        else
            rgb <= 12'hF00;
    end
    
    always @(negedge Vsync) begin
    if (dir == 0) begin
        if (pos == (640 - 80)) begin
            dir <= 1;
            pos <= pos - delta;
        end
        else begin
            pos <= pos + delta;
        end
    end
            else begin
        if (pos == 0) begin
            dir <= 0;
            pos <= pos + delta;
        end
        else begin
            pos <= pos - delta;
        end
    end

    end
*/
endmodule
