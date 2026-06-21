`timescale 1ns/1ps

module tb;

    reg clk=0,rst;
    wire [3:0]Y;
    wire done;
    wire carry_flag, zero_flag, sign_flag, ov_flag, operations_flag; 

    FSM_memory combo1(clk,rst, Y, carry_flag, zero_flag, sign_flag, ov_flag, operations_flag,done);

    always #5 clk=~clk;

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);
        $monitor("Time = %4t ||  Y = %4b ||  cy= %b  ||  z = %b  ||  s = %b  ||  ov= %b  ||  op= %b  || done =%b ||",$time,Y, carry_flag, zero_flag, sign_flag, ov_flag, operations_flag,done);

        rst=1;#10;
        rst=0;#1000;
        $finish;
    end
    
endmodule