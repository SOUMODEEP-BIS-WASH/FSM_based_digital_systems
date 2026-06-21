`timescale 1ns/1ps

module ALU_status_FSM (
    input [3:0]A,B,
    input [1:0]S,
    input clk,rst,
    output reg [3:0]Y,
    output  carry,
    output  zero,
    output  sign,
    output  overflow 
);

//FSM STATES//
parameter FETCH = 2'b00,
          EXECUTE = 2'b01,
          WRITEBACK = 2'b10;

reg [1:0]PS,NS;
//----------//

//PIPELINE REGISTERS//
reg [3:0]A_in,B_in;
reg [1:0]op_code;
reg [3:0]alu_result;
//-----------------//

//ALU BLOCK//
wire [3:0]alu_out;

ALU_status alu1(A_in,B_in,op_code,alu_out,carry,zero,sign,overflow);



//FSM SEQUENTIAL BLOCK//
always @(posedge clk) begin
    if (rst) begin
        PS<=FETCH;
    end
    else begin
        PS<=NS;
    end
end
//--------------------//

//NEXT STATE TRANSITIONS//
always @(*) begin
    case (PS)
        FETCH: NS=EXECUTE;
        EXECUTE: NS=WRITEBACK;
        WRITEBACK: begin
            if(zero|overflow) begin
                NS=FETCH;
            end
            else if (carry|sign) begin
                NS=WRITEBACK;
            end
            else begin
                NS=WRITEBACK;
            end
        end
        default: NS=FETCH;
    endcase
end
//----------------------//

//PIPELINED REGISTERS UPDATE//

always @(posedge clk) begin
    if (rst) begin
        A_in<=0;
        B_in<=0;
        op_code<=0;
        alu_result<=0;
    end
    else begin
        case (PS)
            FETCH: begin  A_in <= A; B_in <= B; op_code <= S;  end
            EXECUTE: begin alu_result <= alu_out; end
            WRITEBACK: begin  Y<=alu_result;  end
            default: begin
                        A_in<=0;
                        B_in<=0;
                        op_code<=0;
                        alu_result<=0;
            end
        endcase
    end
    
end

//--------------------------//
endmodule