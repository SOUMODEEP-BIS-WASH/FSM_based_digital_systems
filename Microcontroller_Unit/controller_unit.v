`timescale 1ns/1ps

module controller_unit (
    input start,
    input [3:0]A,B,
    input [1:0]opcode,
    input clk,rst,
    output [3:0]Q,
    output [3:0]alu_out,
output alu_done, reg_done,
output alu_on, reg_on,
output [3:0]A1,B1,reg_in,
output [1:0]S
);

//wire [3:0]alu_out;
//wire alu_done, reg_done;
//wire alu_on, reg_on;
//wire [3:0]A1,B1,reg_in;
//wire [1:0]S;


controller_FSM FSM1(start,A,B,opcode,alu_out,alu_done,reg_done,clk,rst,alu_on,reg_on,A1,B1,reg_in,S);
alu alu1(A1,B1,S,alu_on,alu_out,alu_done);
n_bit_reg reg1(reg_in,clk,rst,reg_on,Q,reg_done);
    
endmodule