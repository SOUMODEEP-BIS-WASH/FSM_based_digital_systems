`timescale 1ns/1ps

module controller_tb;
    reg start;
    reg [3:0]A,B;
    reg [1:0]opcode;
    reg clk=0,rst;
    wire [3:0]Q;
    wire [3:0]alu_out;
    wire alu_done, reg_done;
    wire alu_on, reg_on;
    wire [3:0]A1,B1,reg_in;
    wire [1:0]S;


controller_unit unit1(start,A,B,opcode,clk,rst,Q,alu_out,alu_done, reg_done,alu_on, reg_on,A1,B1,reg_in,S
);

always #5 clk=~clk;

initial begin
    $dumpfile("controller_tb.vcd");
    $dumpvars(0,controller_tb);
    $monitor("Time= %4t | Start=%b A=%4b B=%4b S=%2b Q=%4b alu_out=%4b alu_done=%b reg_done=%b alu_on=%b reg_on=%b A1=%4b B1=%4b reg_in=%4b S=%2b",$time,start,A,B,opcode,Q,alu_out,alu_done, reg_done,alu_on, reg_on,A1,B1,reg_in,S);
    rst=1;start=0;A=4'b1001;B=4'b0110;opcode=2'b00;#10;
    rst=0;start=1;A=4'b1001;B=4'b0110;opcode=2'b00;#20;
    rst=0;start=0;A=4'b1001;B=4'b0110;opcode=2'b00;#40;
    $finish;
end


endmodule