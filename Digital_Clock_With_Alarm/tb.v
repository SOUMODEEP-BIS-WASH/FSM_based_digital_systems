`timescale 1ns/1ps

module tb;

reg [7:0] H_A,M_A,S_A;
reg clk=0,rst;
wire [7:0]H,M,S;
wire alarm;

DCA uut(H_A,M_A,S_A,clk,rst,alarm,H,M,S);

always #1 clk =~clk;

initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0,tb);
    $monitor("| TIME = %4T | HR =  %2d | MIN = %2d | SEC = %2d | ALARM = %b |",$time,H,M,S,alarm);
    rst=1;H_A=1;M_A=0;S_A=0;#2;
    rst=0;#7210;
    $finish;
end
    
endmodule