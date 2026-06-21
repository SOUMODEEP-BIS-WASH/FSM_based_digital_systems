`timescale 1ns/1ps

module tb3;

    reg clk=0,rst;
    wire [3:0]Y;
    wire done;
    wire carry_flag, zero_flag, sign_flag, ov_flag, operations_flag; 
    wire mem_flag;
    //wire [3:0]mem[0:3];

    FSM_CPU_memory combo1(clk,rst, Y, carry_flag, zero_flag, sign_flag, ov_flag, operations_flag, mem_flag);

    always #5 clk=~clk;

    initial begin
        //$dumpfile("tb3.vcd");// to check testbench signals// to check contents of data memory of the FSM_CPU (Can save only 1 of the 2 vcd files at a time to view signals the other one will be ignored if both used together.)
        //$dumpvars(0,tb3);
        $dumpfile("mem1.vcd");// to check contents of data memory of the FSM_CPU (Can save only 1 of the 2 vcd files at a time to view signals the other one will be ignored if both used together.)
        $dumpvars(0,combo1);
        //$dumpvars(0,combo1.mem[1]);
        //$dumpvars(0,combo1.mem[2]);
        //$dumpvars(0,combo1.mem[3]);
        //$dumpvars(0,combo1.mem[4]);
        //$dumpvars(0,combo1.mem[5]);
        $monitor("Time = %4t ||  Y = %4b ||  cy= %b  ||  z = %b  ||  s = %b  ||  ov= %b  ||  op= %b  || mem=%b || mem[0]=%4b || mem[1]=%4b || mem[2]=%4b || mem[3]=%4b || || mem[4]=%4b || mem[5]=%4b ||",$time,Y, carry_flag, zero_flag, sign_flag, ov_flag, operations_flag,mem_flag,combo1.mem[0],combo1.mem[1],combo1.mem[2],combo1.mem[3],combo1.mem[4],combo1.mem[5]);

        rst=1;#10;
        rst=0;#1000;
        $finish;
    end
    
endmodule