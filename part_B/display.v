

module display
    ( input clk25
    , input [11:0] rbg
    , output reg [3:0] red_out
    , output reg [3:0] blue_out
    , output reg [3:0] green_out
    , output reg hSync = 0
    , output reg vSync = 0
    );
    
    reg [9:0] hSyncCounter = 0;
    reg [9:0] vSyncCounter = 0;
    
    always @(posedge clk25) begin
        red_out     <= 4'hF;
        blue_out    <= 4'hF;
        green_out   <= 4'hF;
        
        if (((hSyncCounter >= 0) && (hSyncCounter <= 658)) 
            || ((hSyncCounter >= 755) && (hSyncCounter <= 799))) begin
            hSync <= 1;
        end
        else begin
            hSync <= 0;
        end
        
        if (((vSyncCounter >= 0) && (vSyncCounter <= 492))
            || ((vSyncCounter >= 494) && (vSyncCounter <= 524))) begin
            vSync <= 1;
        end
        else begin
            vSync <= 0;
        end
    
        hSyncCounter <= (hSyncCounter == 799) ? 0 : hSyncCounter + 1;
        if (hSyncCounter == 799) begin
            vSyncCounter <= (vSyncCounter == 524) ? 0 : vSyncCounter + 1;
        end
    end
endmodule