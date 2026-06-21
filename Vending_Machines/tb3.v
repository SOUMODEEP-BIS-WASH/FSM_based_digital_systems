`timescale 1ns/1ps

module tb3;

reg c5,c10;
reg clk= 1'b0,rst;
reg [1:0]sel;
wire item5,item15,item25;

VM3 uut(c5,c10,clk,rst,sel,item5,item15,item25);

always #5 clk=~clk;

initial begin
    $dumpfile("tb3.vcd");
    $dumpvars(0,tb3);

    $monitor("| TIME = %4t | COIN (RS 5) = %b | COIN (RS 10) = %b | SEL = %2b | ITEM5 = %b | ITEM15 = %b | ITEM25 = %b |",$time,c5,c10,sel,item5,item15,item25);

    rst = 1'b1; c5 = 1'b0; c10 = 1'b0; sel=2'b00; #10;

    rst = 1'b0; c5 = 1'b1; c10 = 1'b0; sel=2'b00; #10;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b0; sel=2'b01; #20;

    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; sel=2'b00; #10;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; sel=2'b00; #10;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; sel=2'b00; #20;

    rst = 1'b0; c5 = 1'b0; c10 = 1'b1; sel=2'b00; #10;
    rst = 1'b0; c5 = 1'b0; c10 = 1'b0; sel=2'b10; #10;

    $finish;

end
    
endmodule