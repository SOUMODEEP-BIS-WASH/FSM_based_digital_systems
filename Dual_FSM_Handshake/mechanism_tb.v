`timescale 1ns/1ps

module mechanism_tb;

    reg [3:0]A,B;
    reg [1:0]S;
    reg clk=0,rst;
    reg start;
    wire [3:0]alu_out;
    wire [3:0]Q;
    wire load,data_loaded;
    wire [3:0]alu_out1,A1,B1;
    wire [1:0]Sl1;
    wire [3:0]A2,B2;
    wire [3:0]alu_out2;
    wire alu_done1,alu_control;
    wire  alu_done, data_stored;

    handshake uut(A,B,S,clk,rst,start,alu_out,Q,load,data_loaded,alu_out1,A1,B1,Sl1,A2,B2,alu_out2,alu_done1,alu_control,alu_done, data_stored );

    always #5 clk=~clk;

    initial begin
        $dumpfile("mechanism.vcd");
        $dumpvars(0,mechanism_tb);

        $monitor("%4t %4b %4b %2b %b ALU_OUT = %4b Q = %4b %b %b %4b %4b %3b %4b %4b %4b %b %b %b",$time,A,B,S,start,alu_out,Q, load,data_loaded,A1,B1,Sl1,A2,B2,alu_out2,alu_done1,alu_control,alu_done);
        rst=1;start=0;A=4'b1001;B=4'b0011;S=2'b00;#10;
        rst=0;start=1;A=4'b1001;B=4'b0011;S=2'b00;#10;
        rst=0;start=0;A=4'b1001;B=4'b0011;S=2'b00;#40;
        $finish;
    end

endmodule