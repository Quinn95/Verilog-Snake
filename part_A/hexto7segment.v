`timescale 1ns / 1ps


module hexto7segment(
    input [3:0] x,
    output reg [6:0] r
    );
    always @(*) begin
        case (x)
            4'b0000 : r = 7'b0111111;
            4'b0001 : r = 7'b0000110;
            4'b0010 : r = 7'b1011011;
            4'b0011 : r = 7'b1001111;
            4'b0100 : r = 7'b1100110;
            4'b0101 : r = 7'b1101101;
            4'b0110 : r = 7'b1111101;
            4'b0111 : r = 7'b0000111;
            4'b1000 : r = 7'b1111111;
            4'b1001 : r = 7'b1101111;
            default : r = 7'b0000000;
        endcase
        r = ~r;
    end
endmodule











