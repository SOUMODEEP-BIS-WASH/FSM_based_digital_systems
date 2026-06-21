`timescale 1ns/1ps

module data_controller_FSM(
    input [3:0]A,B,
    input [1:0]Sl,
    input [3:0]alu_out,
    input data_loaded, alu_done, data_stored, 
    input clk,rst, start,
    output reg load,rcvd,en,
    output reg [3:0]alu_out1,A1,B1,
    output reg [1:0]Sl1
);

parameter S0 = 3'b000, //IDLE
          S1 = 3'b001, //LOAD
          S2 = 3'b010, //WAIT
          S3 = 3'b011, //STORE
          S4 = 3'b100; //NEXT
reg [2:0]PS,NS;

always @(posedge clk) begin
    if(rst) begin
        PS<=S0;
    end
    else begin
        PS<=NS;
    end
    
end

always @(*) begin
    case(PS)
        S0: NS= (start)? S1:S0;
        S1: NS= (data_loaded)? S2:S1;
        S2: NS= (alu_done)? S3:S2;
        S3: NS= (data_stored)? S4:S3;
        S4: NS= (start)? S0:S1;
        default: NS= S0;
    endcase
end

always @(*) begin
    case(PS)
        S0: begin load=0; rcvd=0; en=0; alu_out1=4'b0000; A1=4'b0000; B1=4'b0000; Sl1=2'b00; end
        S1: begin load=1; rcvd=0; en=0; alu_out1=4'b0000; A1=A; B1=B; Sl1=Sl; end
        S2: begin load=0; rcvd=0; en=0; alu_out1=4'b0000; A1=4'b0000; B1=4'b0000; Sl1=2'b00; end
        S3: begin load=0; rcvd=1; en=1; alu_out1=alu_out; A1=4'b0000; B1=4'b0000; Sl1=2'b00; end
        S4: begin load=0; rcvd=0; en=0; alu_out1=4'b0000; A1=4'b0000; B1=4'b0000; Sl1=2'b00; end
        default: begin load=0; rcvd=0; en=0; alu_out1=4'b0000; A1=4'b0000; B1=4'b0000; Sl1=2'b00; end
        
    endcase
    
end

endmodule