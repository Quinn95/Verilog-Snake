


module clkdiv25
    ( input clk
    , output reg slow_clk
    );
    
    reg [3:0] count = 0;
    
    initial begin
        count = 0;
        slow_clk = 0;
    end
    
    always @(posedge clk) begin
        if(count == 4) begin
            count <= 1;
            slow_clk <= ~slow_clk;
        end
        count <= count + 1;
    end
    
endmodule