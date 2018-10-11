

module display_driver
    ( input  clk
    , input [15:0] num
    , input enable
    , output [3:0] an
    , output [6:0] seg_out
    );
    
    wire [3:0] num0, num1, num2, num3;
    
    wire [6:0] num0_7seg;
    wire [6:0] num1_7seg;
    wire [6:0] num2_7seg;
    wire [6:0] num3_7seg;
    
    decimal2bcd d2bcd(num, num0, num1, num2, num3);
   
    hexto7segment seg0(num0, num0_7seg);
    hexto7segment seg1(num1, num1_7seg);
    hexto7segment seg2(num2, num2_7seg);
    hexto7segment seg3(num3, num3_7seg);

    display_multiplexer plex0(clk,
        num0_7seg, num1_7seg, num2_7seg, num3_7seg, enable,
        an, seg_out);
    
endmodule