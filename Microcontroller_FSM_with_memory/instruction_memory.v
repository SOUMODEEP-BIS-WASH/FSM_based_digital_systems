`timescale 1ns/1ps

module instruction_memory #(
    parameter DATA_WIDTH = 4,
    parameter OPCODE_WIDTH = 2,
    parameter NUM_DATA = 4,
    parameter NUM_OPCODE = 4
) (
    input clk,rst,
    output reg [DATA_WIDTH-1:0]A,B,
    output reg [OPCODE_WIDTH-1:0]S,
    output reg done
);

reg [DATA_WIDTH-1:0]operand_A[0:NUM_DATA-1];
reg [DATA_WIDTH-1:0]operand_B[0:NUM_DATA-1];
reg [OPCODE_WIDTH-1:0]opcode[0:NUM_OPCODE-1];


reg [$clog2(NUM_OPCODE)-1:0]opcode_count;
reg [$clog2(NUM_DATA)-1:0]operand_count;

initial begin
    opcode[0]=2'b00;
    opcode[1]=2'b01;
    opcode[2]=2'b10;
    opcode[3]=2'b11;
    operand_A[0]=4'b0001 ; operand_B[0]=4'b1010;
    operand_A[1]=4'b0010 ; operand_B[1]=4'b1001;
    operand_A[2]=4'b0100 ; operand_B[2]=4'b1100;
    operand_A[3]=4'b1000 ; operand_B[3]=4'b0011;
    opcode_count=0;
    operand_count=0;
    done=0;
end

always @(posedge clk) begin
    if (rst) begin
        opcode_count<=0;
        operand_count<=0;
        done<=0;
    end
    else begin
        S<=opcode[opcode_count];
        A<=operand_A[operand_count];
        B<=operand_B[operand_count];
        if (opcode_count<NUM_OPCODE-1) begin
            opcode_count<=opcode_count+1;
        end
        else begin
            opcode_count<=0;
            if (operand_count<NUM_DATA-1) begin
                operand_count<=operand_count+1;
            end
            else begin
                operand_count<=0;
                done<=1;
            end
        end
    end
    
end


endmodule