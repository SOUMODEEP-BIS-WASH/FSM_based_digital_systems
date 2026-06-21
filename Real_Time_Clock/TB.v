`timescale 1ns/1ps

module tb;

reg clk=0,rst;
wire [7:0]HR_M,HR_L,MIN_M,MIN_L,SEC_M,SEC_L;

RTC uut(clk,rst,HR_M,HR_L,MIN_M,MIN_L,SEC_M,SEC_L);

always #1 clk =~clk;

initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0,tb);
    $monitor("| TIME = %4T | HR =  %d %d | MIN = %d %d | SEC = %d %d |",$time,HR_M,HR_L,MIN_M,MIN_L,SEC_M,SEC_L);
    rst=1;#2;
    rst=0;#7210;
    $finish;
end
    
endmodule