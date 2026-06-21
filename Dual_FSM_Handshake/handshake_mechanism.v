`timescale 1ns/1ps

module handshake (
    input [3:0]A,B,
    input [1:0]S,
    input clk,rst,
    input start,
    output [3:0]alu_out,
    output [3:0]Q,
    output load,data_loaded,
    output [3:0]alu_out1,A1,B1,
    output [1:0]Sl1,
    output [3:0]A2,B2,
    output [3:0]alu_out2,
    output alu_done1,alu_control,
    output  alu_done, data_stored

);

//inputs and outputs for FSM2
    //wire [3:0]alu_out;

    wire rcvd,en;


//inputs and outputs for FSM1
    
    
    
    wire [1:0]Sl2;
//inputs and outputs for ALU

//inputs and outputs for REGISTER

data_controller_FSM FSM2(A,B,S,alu_out,data_loaded,alu_done,data_stored,clk,rst,start,load,rcvd,en,alu_out1,A1,B1,Sl1);
alu_controller_FSM FSM1(load,rcvd,clk,rst,alu_done1,A1,B1,alu_out2,Sl1,data_loaded, alu_done, alu_control,alu_out,A2,B2,Sl2);
alu alu1(A2,B2,Sl2,alu_control,alu_out2,alu_done1);
n_bit_reg reg1(alu_out1,clk,rst,en,Q,data_stored);

endmodule