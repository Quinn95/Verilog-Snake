

module display_top(
      input clk
    , output [3:0] vgaRED
    , output [3:0] vgaBLUE
    , output [3:0] vgaGREEN
    , output Hsync
    , output Vsync
);
    reg [11:0] rgb;
    wire clk25;
    
    clkdiv25 divider(clk, clk25);
    
    display display(clk25, rbg, vgaRED, vgaBLUE, vgaGREEN, Hsync, Vsync);

endmodule
