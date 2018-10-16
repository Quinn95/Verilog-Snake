

module display
    ( input clk25
    , input [11:0] rbg
    , output reg [3:0] red_out
    , output reg [3:0] blue_out
    , output reg [3:0] green_out
    , output reg hSync = 0
    , output reg vSync = 0
    );
    
    reg [9:0] hSyncCounterCurrent = 0;
    reg [9:0] hSyncCounterNext = 0;
    reg [9:0] vSyncCounterCurrent = 0;
    reg [9:0] vSyncCounterNext = 0;
    
    always @(*) begin
        if ((hSyncCounterNext >= 640)  || (vSyncCounterNext >= 480))
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
        
        
        if ((hSyncCounterCurrent >= 658) && (hSyncCounterCurrent < 755)) begin
            hSync <= 0;
        end
        else begin
            hSync <= 1;
        end
        
        if (((vSyncCounterCurrent == 492) && (hSyncCounterCurrent == 799)) 
            || ((vSyncCounterCurrent > 492) && ((vSyncCounterCurrent < 494) && (hSyncCounterCurrent < 799)))) begin
            vSync <= 0;
        end
        else begin
            vSync <= 1;
        end
    
        hSyncCounterNext <= (hSyncCounterCurrent == 799) ? 0 : hSyncCounterCurrent + 1;
        if (hSyncCounterCurrent == 799) begin
            vSyncCounterNext <= (vSyncCounterCurrent == 524) ? 0 : vSyncCounterCurrent + 1;
        end
    end
    
    always@(posedge clk25) begin
        hSyncCounterCurrent <= hSyncCounterNext;
        vSyncCounterCurrent <= vSyncCounterNext;
    end
endmodule