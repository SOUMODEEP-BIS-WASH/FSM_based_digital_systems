`timescale 1ns/1ps

module carry_alert_mechanism(
    input [3:0]A,B,
    input Cin,clk,rst,load,
    output Cout,
    output [3:0]S,
    output [4:0]Q,
    output carry_alert
);

CLA cla1(A,B,Cin,S,Cout);
n_bit_reg #(5) dff1({Cout,S},clk,rst,load,Q);
carry_alert_FSM caf(Q[4],clk,rst,carry_alert);
    
endmodule
