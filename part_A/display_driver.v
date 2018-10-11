

module display_driver
    ( input  clk
    , input [7:0] num
    , input enable
    , output [3:0] an
    , output [6:0] seg_out
    );
    
    wire [6:0] num0_7seg, num1_7seg;
       
    hexto7segment seg0(num[3:0], num0_7seg);
    hexto7segment seg1(num[7:4], num1_7seg);

    display_multiplexer plex0(clk,
        7'b1111111, 7'b1111111,
        num1_7seg, num0_7seg, enable,
        an, seg_out);
    
endmodule