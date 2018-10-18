


module ps2_top
    ( input clk
    , input PS2Clk
    , input PS2Data
    , output [6:0] seg
    , output [3:0] an
    , output reg strobe = 0
    );
    
    wire key_pressed;
    wire [7:0] key_code;
    
    reg [20:0] ms100 = 0;
    
    ps2 k0(.clk(PS2Clk), .data(PS2Data), .key_pressed(key_pressed),
           .last_pressed(key_code));
           
    display_driver d0(.clk(clk), .num(key_code), .enable(1), .seg_out(seg), .an(an));
    
    always @(posedge clk) begin
        if (key_pressed) begin
            ms100 <= 10000000;
            strobe <= 1;
        end
        else begin
            if (ms100 > 0) begin
                ms100 <= ms100 - 1;
                strobe <= 1;
            end
            else begin
                strobe <= 0;
            end
        end
    end
    
endmodule