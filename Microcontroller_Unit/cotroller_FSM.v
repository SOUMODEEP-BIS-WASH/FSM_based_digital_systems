`timescale 1ns/1ps

module controller_FSM (
    input start,
    input [3:0]A,B,
    input [1:0]opcode,
    input [3:0]alu_out,
    input alu_done, reg_done, clk,rst,
    output reg alu_on, reg_on,
    output reg [3:0]A1,B1,reg_in,
    output reg [1:0]S
);

parameter S0 = 3'b000,//IDLE
          S1 = 3'b001,//FETCH OPCODE
          S2 = 3'b010,//EXECUTE
          S3 = 3'b011,//STORE
          S4 = 3'b100;//DONE

reg [2:0]PS,NS;
reg load;
reg [3:0]inA,inB;
reg [1:0]inS;
reg [3:0]outALU;

always @(posedge clk) begin
    if(rst) begin
        PS<=S0;
    end

    else begin
        PS<=NS;
    end
    
end

always @(*) begin
    case (PS)
        S0: NS = (start==0)? S0:S1;
        S1: NS = S2;
        S2: NS = (alu_done==0)? S2:S3;
        S3: NS = (reg_done==0)? S3:S4;
        S4: NS = (opcode==0)? S0:S1;
        default: NS=S0;
        
    endcase
end

always @(*) begin
    case (PS)
        S0:begin A1=0;B1=0;S=0;alu_on=0;reg_on=0;reg_in=0;inA=0;inB=0;inS=0;load=0;outALU=0; end
        S1:begin A1=0;B1=0;S=0;alu_on=0;reg_on=0;reg_in=0;inA=A;inB=B;inS=opcode;load=1;outALU=0; end
        S2:begin A1=inA;B1=inB;S=inS;alu_on=1;reg_on=0;reg_in=0;inA=A;inB=B;inS=opcode;load=0;outALU=alu_out;end
        S3:begin A1=A;B1=B;S=inS;alu_on=0;reg_on=1;reg_in=outALU;inA=A;inB=B;inS=opcode;load=0;outALU=outALU;end
        S4:begin A1=0;B1=0;S=0;alu_on=0;reg_on=0;reg_in=0;inA=0;inB=0;inS=0;load=0;outALU=0;end
        default:begin A1=0;B1=0;S=0;alu_on=0;reg_on=0;reg_in=0;inA=0;inB=0;inS=0;load=0;outALU=0;end
    endcase
    
end

endmodule