



module ps2
    ( input clk
    , input data
    , output reg key_pressed
    , output reg [7:0] last_pressed
    );
    
    // used as a shift register to process incoming bits
    reg [21:0] data_register;
        
    always @(negedge clk) begin
        if (data_register[8:1] == 8'hF0) begin
            last_pressed <= data_register[19:12];
            key_pressed <= 1;
        end
        else
            key_pressed <= 0;
        
        // shift in data from the left    
        data_register <= {data, data_register[21:1]};
    end
endmodule