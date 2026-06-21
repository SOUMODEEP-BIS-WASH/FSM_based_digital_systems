`timescale 1ns/1ps

module alu_controller_FSM(
    input load,rcvd,clk,rst,alu_done,
    input [3:0]A1,B1,alu_out1,
    input [1:0]Sl1,
    output reg data_loaded, alu_done1, alu_control,
    output reg [3:0]alu_out2,A2,B2,
    output reg [1:0]Sl2
);

parameter S0=2'b00, //IDLE
          S1=2'b01, //LOAD & ALU_IN
          S2=2'b10; //ALU_OUT
          

reg [2:0]PS,NS;

always @(posedge clk) begin
    if (rst) begin
        PS<=S0;
    end
    else begin
        PS<=NS;
    end
end

always @(*) begin
    case (PS)
        S0: NS= (load)? S1:S0;
        S1: NS= (alu_done)? S2:S1;
        S2: NS= (rcvd)? S0:S2;
        default: NS= S0;
    endcase
end

always @(*) begin
    case (PS)
       S0: begin data_loaded=1'b0; alu_done1=1'b0; alu_control=1'b0; alu_out2=4'b0000; A2=4'b0000; B2=4'b0000; Sl2=2'b00; end 
       S1: begin data_loaded=1'b1; alu_done1=1'b0; alu_control=1'b1; alu_out2=4'b0000; A2=A1; B2=B1; Sl2=Sl1; end
       S2: begin data_loaded=1'b0; alu_done1=1'b1; alu_control=1'b0; alu_out2=alu_out1; A2=4'b0000; B2=4'b0000; Sl2=2'b00; end
       default: begin data_loaded=1'b0; alu_done1=1'b0; alu_control=1'b0; alu_out2=4'b0000; A2=4'b0000; B2=4'b0000; Sl2=2'b00; end
    endcase
end

endmodule