`timescale 1ns/1ps

module carry_alert_tb;
    reg [3:0]A,B;
    reg Cin,clk=0,rst,load;
    wire Cout;
    wire [3:0]S;
    wire [4:0]Q;
    wire carry_alert;

    carry_alert_mechanism uut(A,B,Cin,clk,rst,load,Cout,S,Q,carry_alert);

    always #5 clk=~clk;

    initial begin
        $dumpfile("carry_alert_tb.vcd");
        $dumpvars(0,carry_alert_tb);

        $monitor("TIME=%4t | A=%4b | B=%4b | Cin=%b | S=%4b | Cout=%b | Q=%5b | carry_alert=%b",$time,A,B,Cin,S,Cout,Q,carry_alert);
        rst=1;load=0;A=4'b0000;B=4'b0000;Cin=0;#10;
        rst=0;load=1;
        A=4'b1000;B=4'b0001;Cin=0;#10;
        A=4'b1111;B=4'b1001;Cin=0;#10;
        A=4'b1000;B=4'b0001;Cin=1;#10;
        A=4'b1111;B=4'b0001;Cin=1;#10;
        $finish;
    end

endmodule