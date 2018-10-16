

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
        if (((hSyncCounter >= 639) && (hSyncCounter < 799)) || ((vSyncCounter >= 479) && (hSyncCounter < 639)))
        begin
            red_out     <= 4'h0;
            blue_out    <= 4'h0;
            green_out   <= 4'h0;
        end
        else
        begin  
            red_out     <= 4'hF;
            blue_out    <= 4'hF;
            green_out   <= 4'hF;
        end
        
        
        if ((hSyncCounter >= 658) && (hSyncCounter < 755)) begin
            hSync <= 0;
        end
        else begin
            hSync <= 1;
        end
        
        if (((vSyncCounter == 492) && (hSyncCounter == 799)) || ((vSyncCounter > 492) && ((vSyncCounter < 494) && (hSyncCounter < 799)))) begin
            vSync <= 0;
        end
        else begin
            vSync <= 1;
        end
    
        hSyncCounter <= (hSyncCounter == 799) ? 0 : hSyncCounter + 1;
        if (hSyncCounter == 799) begin
            vSyncCounter <= (vSyncCounter == 524) ? 0 : vSyncCounter + 1;
        end
    end
endmodule