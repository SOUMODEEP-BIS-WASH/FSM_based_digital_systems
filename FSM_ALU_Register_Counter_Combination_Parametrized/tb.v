`timescale 1ns/1ps

module tb;

    reg [3:0]A,B;
    reg [1:0]S;
    reg clk=0,rst;
    wire [3:0]Y;
    wire carry_flag, zero_flag, sign_flag, ov_flag, operations_flag; 

    FSM_combo combo1(A,B, S, clk,rst, Y, carry_flag, zero_flag, sign_flag, ov_flag, operations_flag);

    always #5 clk=~clk;

    initial begin
        $dumpfile("tb.vcd");
        $dumpvars(0,tb);
        $monitor("Time = %4t || A = %4b || B = %4b || S = %2b ||  Y = %4b ||  cy= %b  ||  z = %b  ||  s = %b  ||  ov= %b  ||  op= %b  ||",$time,A,B, S,Y, carry_flag, zero_flag, sign_flag, ov_flag, operations_flag);

        rst=1;A=4'b1001;B=4'b0110;S=2'b00;#10;
        rst=0;A=4'b1001;B=4'b0110;S=2'b00;#10;
        rst=0;A=4'b1001;B=4'b0110;S=2'b01;#60;
        rst=0;A=4'b1001;B=4'b0110;S=2'b10;#60;
        rst=0;A=4'b1001;B=4'b0110;S=2'b11;#60;
        $finish;
    end
    
endmodule