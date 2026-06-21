`timescale 1ns/1ps

module tb1;

reg coin5;
reg clk= 1'b0,rst;
wire item;

VM1 uut(coin5,clk,rst,item);

always #5 clk=~clk;

initial begin
    $dumpfile("tb1.vcd");
    $dumpvars(0,tb1);

    $monitor("| TIME = %4t | COIN (Rs 5) = %b | ITEM = %b |",$time,coin5,item);

    rst = 1'b1; coin5 = 1'b0; #10;
    rst = 1'b0; coin5 = 1'b1; #10;
    rst = 1'b0; coin5 = 1'b0; #10;
    rst = 1'b0; coin5 = 1'b0; #10;
    $finish;

end
    
endmodule