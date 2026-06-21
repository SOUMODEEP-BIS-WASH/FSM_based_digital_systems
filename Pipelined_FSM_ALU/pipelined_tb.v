`timescale 1ns/1ps

module pipelined_tb;

reg [3:0]A,B;
reg [1:0]S;
reg clk=0,rst;
wire [3:0]Y;

pipelined_ALU uut(.A(A),.B(B),.S(S),.clk(clk),.rst(rst),.Y(Y));

always #5 clk=~clk;

initial begin
    $dumpfile("pipelined_tb.vcd");
    $dumpvars(0,pipelined_tb);

    $monitor("TIME= %4t | A = %4b | B = %4b | S = %2b | Y = %4b",$time,A,B,S,Y);
    rst=1; A=4'b0000; B=4'b0000; S=2'b00; #10;
    rst=0; A=4'b1001; B=4'b0110; S=2'b00; #10;
    rst=0; A=4'b1001; B=4'b0001; S=2'b01; #30;
    rst=0; A=4'b1000; B=4'b0100; S=2'b00; #60;
    $finish;
end


endmodule

//here since data will be captured only when in FETCH state so FSM needs to process current input from fetch then complete tht first before 
//going back to FETCH gain and then only new input will be taken so new input needs to be active for this entire time. So, not true pipeline.