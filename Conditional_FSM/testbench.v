`timescale 1ns/1ps

module status_tb;

reg [3:0]A,B;
reg [1:0]S;
reg clk=0,rst;
wire [3:0]Y;
    wire carry;
    wire zero;
    wire sign;
    wire overflow;

ALU_status_FSM uut(.A(A),.B(B),.S(S),.clk(clk),.rst(rst),.Y(Y),.carry(carry),.zero(zero),.sign(sign),.overflow(overflow));

always #5 clk=~clk;

initial begin
    $dumpfile("status_tb.vcd");
    $dumpvars(0,status_tb);

    $monitor("TIME= %4t | A = %4b | B = %4b | S = %2b | Y = %4b | %b %b %b %b",$time,A,B,S,Y,carry,zero,sign,overflow);
    rst=1; A=4'b0000; B=4'b0000; S=2'b00; #10;
    rst=0; A=4'b1001; B=4'b0110; S=2'b00; #40;
    rst=1;#10;
    rst=0; A=4'b1001; B=4'b0001; S=2'b01; #40;
    //rst=0; A=4'b1000; B=4'b0100; S=2'b00; #60;
    $finish;
end


endmodule
