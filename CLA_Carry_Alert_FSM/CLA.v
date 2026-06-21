`timescale 1ns/1ps

module CLA(
    input [3:0]A,B,
    input Cin,
    output [3:0]S,
    output Cout
);

wire [3:0]G,P;
wire c1,c2,c3;

assign G=A&B;
assign P=A^B;

assign c1=G[0]|(Cin & P[0]);
assign c2=G[1]|((P[1]&G[0]) | (Cin & P[0] & P[1]));
assign c3=G[2]|((P[2]&G[1])|((P[2]&P[1]&G[0]) | (Cin & P[0] & P[1] & P[2])));
assign Cout=G[3]|((G[2]&P[3])|((P[3]&P[2]&G[1])|((P[3]&P[2]&P[1]&G[0]) | (Cin & P[0] & P[1] & P[2]& P[3]))));

assign S[0]=P[0]^Cin;
assign S[1]=P[1]^c1;
assign S[2]=P[2]^c2;
assign S[3]=P[3]^c3;
    
endmodule