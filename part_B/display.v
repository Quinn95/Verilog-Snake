

module display
    ( input clk25
    , input [11:0] rbg
    , output reg [3:0] red_out
    , output reg [3:0] blue_out
    , output reg [3:0] green_out
    , output reg hSync = 1
    , output reg vSync = 1
    );
    
    reg [9:0] hSyncCounter = 10'b1111111111;
    reg [9:0] vSyncCounter = 10'b0000000000;
    
    reg [9:0] hSyncCounter_next = 0;
    reg [9:0] vSyncCounter_next = 0;
    


    always @(posedge clk25) begin
        hSyncCounter_next = (hSyncCounter == 799) ? 0 : hSyncCounter + 1;
        vSyncCounter_next = (hSyncCounter == 799) ? ((vSyncCounter == 524) ? 0 : vSyncCounter + 1) : vSyncCounter;

        if ((hSyncCounter_next >= 640) || (vSyncCounter_next >= 480))
        begin
            red_out     <= 4'h0;
            blue_out    <= 4'h0;
            green_out   <= 4'h0;
        end
        else
        begin
            red_out     <= 4'h0;
            blue_out    <= 4'h0;
            green_out   <= 4'hF;
        end
        
        if ((hSyncCounter_next >= 659) && (hSyncCounter_next <= 755))
        begin
            hSync <= 0;
        end
        else
        begin
            hSync <= 1;
        end
        
        if ((vSyncCounter_next == 493) || (vSyncCounter_next == 494))
        begin
            vSync <= 0;
        end
        else
        begin
            vSync <= 1;
        end
        
        
        hSyncCounter <= hSyncCounter_next;
        vSyncCounter <= vSyncCounter_next;    
    end
endmodule