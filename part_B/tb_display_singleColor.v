

module tb_display_singleColor();

// declare inputs and outputs
reg clk;
wire [3:0] vgaRED;
wire [3:0] vgaBLUE;
wire [3:0] vgaGREEN;
wire Hsync;
wire Vsync;

// number of clk cycles for one screen
//parameter N = 420000;
//// set output arrays
//reg [3:0] RED_array; // [1:N];
//reg [3:0] BLUE_array; // [1:N];
//reg [3:0] GREEN_array; // [1:N];
//reg Hsync_array [1:N];
//reg Vsync_array [1:N];
//integer i;

initial
begin
// initialize clk
clk = 0;

// define output vgaRED
//RED_array = 4'b1111;

// define output vgaBLUE
//BLUE_array = 4'b1111;

// define output vgaGREEN
//GREEN_array = 4'b1111;

// define output Hsync
//for (i = 1; i < 659; i = i+1) Hsync_array[i] = 1'b1; 
//for (i = 659; i < 755; i = i+1) Hsync_array[i] = 1'b0;
//for (i = 755; i < 800; i = i+1) Hsync_array[i] = 1'b1;

// define output Vsync

end

display_top disp(clk, vgaRED, vgaBLUE, vgaGREEN, Hsync, Vsync);

always@(clk)
begin
    clk <= #5(~clk); //clk is 100MHz
end

endmodule
