`timescale 1ns/1ps

module tb2;

reg c5,c10;
reg clk= 1'b0,rst;
wire item;

VM2 uut(c5,c10,clk,rst,item);

always #5 clk=~clk;

initial begin
    $dumpfile("tb2.vcd");
    $dumpvars(0,tb2);

    $monitor("| TIME = %4t | COIN (RS 5) = %b | COIN (RS 10) = %b | ITEM = %b |",$time,c5,c10,item);

    rst = 1'b1; c5 = 1'b0; c10 = 1'b0; #10;
    rst = 1'b0; c5 = 1'b1; c10 = 1'b0; #10;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; #10;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; #10;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; #10;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; #10;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; #10;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; #20;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; #10;
    rst = 1'b0; c5 = 1'b1; c10 = 1'b0; #10;
    rst = 1'b0; c5 = 1'b1; c10 = 1'b0; #10;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; #10;
    rst = 1'b0; c5 = 1'b1; c10 = 1'b0; #10;    
    $finish;

end
    
endmodule