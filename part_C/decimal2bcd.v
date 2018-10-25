



module decimal2bcd
    ( input [15:0] number
    , output reg [3:0] num0
    , output reg[3:0] num1
    , output reg[3:0] num2
    , output reg[3:0] num3
    );
    
    always @(number) begin
        num0 = number % 10;
        num1 = (number / 10) % 10;
        num2 = (number / 100) % 10;
        num3 = (number / 1000) % 10;
    end
    
    
endmodule