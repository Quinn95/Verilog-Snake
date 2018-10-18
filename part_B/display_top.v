

module display_top(
      input clk
    , output [3:0] vgaRed
    , output [3:0] vgaBlue
    , output [3:0] vgaGreen
    , output Hsync
    , output Vsync
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

endmodule
