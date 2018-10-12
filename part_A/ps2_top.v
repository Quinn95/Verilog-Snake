


module ps2_top
    ( input clk
    , input PS2Clk
    , input PS2Data
    , output [6:0] seg
    , output [3:0] an
    );
    
    wire key_pressed;
    wire [7:0] key_code;
    
    
    
    ps2 k0(.clk(PS2Clk), .data(PS2Data), .key_pressed(key_pressed),
           .last_pressed(key_code));
           
    display_driver d0(.clk(clk), .num(key_code), .enable(1), .seg_out(seg), .an(an));
    
    
endmodule