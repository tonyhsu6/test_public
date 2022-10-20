`timescale 1ns/100ps
module hw2_pipe (input [7:0] a, b, c, input s, reset, clk, output [15:0] d);
wire  [8:0] temp0;
wire  [7:0] temp_c;

adder step1(.a(a), .b(b), .c(c), .s(s), .reset(reset), .clk(clk), .adder_out(temp0), .regC(temp_c));
mul step2(.c(temp_c), .adder_out(temp0), .reset(reset), .clk(clk), .d(d));

endmodule

module adder (input [7:0] a, b, c, input s, reset, clk, output reg [8:0] adder_out, output reg [7:0] regC);
always@(posedge clk or posedge reset)
begin
    if(reset)
    begin
        adder_out <= 0;
        regC <= 0;
    end
    else
    begin
        regC <= c;
        if(s==1) adder_out <= a + b;
        else adder_out <= a - b;  
    end
end
endmodule     

module mul (input signed [7:0] c, input signed [8:0] adder_out, input reset, clk, output reg [15:0] d);
always@(posedge clk or posedge reset)
begin
    if(reset) d <= 0;
    else d <= adder_out * c;
end
endmodule     



