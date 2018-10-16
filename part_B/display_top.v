

module display_top(
      input clk
    , output [3:0] vgaRed
    , output [3:0] vgaBlue
    , output [3:0] vgaGreen
    , output Hsync
    , output Vsync
);
    reg [11:0] rgb;
    wire clk25;
    
    clkdiv25 divider(clk, clk25);
    
    display display(clk25, rgb, vgaRed, vgaBlue, vgaGreen, Hsync, Vsync);

endmodule
