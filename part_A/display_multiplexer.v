
/*
    num[0,1,2,3] is the number to display for each digit, 
    starting with the far right (0).
    
    an is the position of the current digit to be displayed
    (the board only displays one at a time).  
*/

module display_multiplexer
    ( input clk
    , input [6:0] num0
    , input [6:0] num1
    , input [6:0] num2
    , input [6:0] num3
    , input enable
    , output reg [3:0] an
    , output reg [6:0] seg_out
    );
    
    reg [10:0] slow_clk;
    
    always@(posedge clk) begin
        slow_clk <= slow_clk + 1;
    end
    
    initial begin
        an = 4'b1110;
        seg_out = 7'b0000000;
    end

    always@(posedge slow_clk[10]) begin
        if (enable) begin
            if(an == 4'b1110) begin
                an <= 4'b1101;
                seg_out <= num1;
            end
            else if(an == 4'b1101) begin
                an <= 4'b1011;
                seg_out <= num2;
            end
            else if(an == 4'b1011) begin
                an <= 4'b0111;
                seg_out <= num3;
            end
            else if(an == 4'b0111) begin
                an <= 4'b1110;
                seg_out <= num0;
            end
            else begin
                an <= 4'b1110;
                seg_out <= 4'b1111;
            end
        end
        else begin
            an <= 4'b1111;
            seg_out <= 4'b1111;
        end       
    end

endmodule