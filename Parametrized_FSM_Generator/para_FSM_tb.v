`timescale 1ns/1ps

module para_FSM_tb;
    reg clk=0,rst;
    wire Dout;

    para_FSM #(3) uut(clk,rst,Dout);
    
    always #5 clk=~clk;
    
    initial begin
        $dumpfile ("para_fsm_tb.vcd");
        $dumpvars (0,para_FSM_tb);
        $monitor("%b",Dout);
        rst=1;#10;
        rst=0;#60;
        $finish;
    end
    
endmodule