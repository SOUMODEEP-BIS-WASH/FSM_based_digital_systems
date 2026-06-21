`timescale 1ns/1ps

module pipelined_ALU (
    input [3:0]A,B,
    input [1:0]S,
    input clk,rst,
    output reg [3:0]Y
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
reg [3:0]alu_out;

always @(*) begin
    case (op_code)
        2'b00: alu_out= A_in + B_in;
        2'b01: alu_out= A_in - B_in;
        2'b10: alu_out= A_in & B_in;
        2'b11: alu_out= A_in | B_in;
        default: alu_out=4'b0000;
    endcase
end
//---------//

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
        WRITEBACK: NS=FETCH;
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