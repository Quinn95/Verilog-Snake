


module clkdiv25
    ( input clk
    , output reg slow_clk
    );
    
    reg [1:0] count = 0;
    
    initial begin
        count = 0;
        slow_clk = 0;
    end
    
    always @(posedge clk) begin
        if(count == 2) begin
            count <= 1;
            slow_clk <= ~slow_clk;
        end
        else begin
            count <= count + 1;
        end
    end
    
endmodule