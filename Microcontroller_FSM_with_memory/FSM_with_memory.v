`timescale 1ns/1ps

module FSM_memory (
    input clk,rst,
    output reg [3:0]Y,
    output reg carry_flag,
    output reg zero_flag,
    output reg sign_flag,
    output reg ov_flag,
    output reg operations_flag,
    output done
);

//MEMORY BLOCK
wire [3:0]A,B;
wire [1:0]S;
//wire done;
instruction_memory instruction(clk,rst,A,B,S,done);

//PARAMETERS

parameter FETCH = 2'b00,
          EXECUTE = 2'b01,
          STORE = 2'b10,
          FLAGS = 2'b11;

reg [1:0]PS,NS;

// FETCH REGISTERS BLOCK

wire [3:0]alu_out;
wire [3:0] A_out, B_out;
wire [1:0] S_out;
wire [3:0] y_in;
reg [3:0]a,b;
reg [1:0]s_1;


n_bit_reg A_in(.D(a),.clk(clk),.rst(rst),.load(1'b1),.Q(A_out));
n_bit_reg B_in(.D(b),.clk(clk),.rst(rst),.load(1'b1),.Q(B_out));
n_bit_reg #(2) S_in(.D(s_1),.clk(clk),.rst(rst),.load(1'b1),.Q(S_out));
n_bit_reg alu_output(.D(alu_out),.clk(clk),.rst(rst),.load(1'b1),.Q(y_in));

// ALU BLOCK

wire cy,z,s,ov;

ALU_status alu1(A_out,B_out,S_out,alu_out,cy,z,s,ov);


// FSM SEQUENTIAL BLOCK

always @(posedge clk) begin
    if (rst) begin
        PS <= FETCH;
    end
    else begin
        PS <= NS;
    end
end

// FSM TRANSITION BLOCK

always @(*) begin
    case (PS)
        FETCH : NS = EXECUTE;
        EXECUTE : NS = STORE;
        STORE : begin
            if (cy||z||s||ov||done) begin
                NS = FLAGS;
            end
            else begin
                NS = FETCH;
            end
        end
        FLAGS : NS = FETCH;
        default : NS = FETCH;
    endcase
end

// PIPELINED REGISTERS, COUNTERS and FLAGS UPDATE BLOCK

always @(posedge clk) begin
    if (rst) begin
        
          a<=A; 
          b<=B; 
          s_1<=S; 
          
        Y<=0;
        carry_flag<=0;
        sign_flag<=0;
        ov_flag<=0;
        zero_flag<=0;
        operations_flag<=0;
    end
    else begin
    case (PS)
        FETCH : begin
          
          a<=A; 
          b<=B; 
          s_1<=S; 
          
          Y<=y_in;
          carry_flag<=cy;
          sign_flag<=s;
          ov_flag<=ov;
          zero_flag<=z;
          operations_flag<=done;
        end
        EXECUTE : begin
                    
          a<=A; 
          b<=B; 
          s_1<=S; 
          
          Y<=y_in;

          carry_flag<=cy;
          sign_flag<=s;
          ov_flag<=ov;
          zero_flag<=z;
          operations_flag<=done;
        end
        STORE : begin
          
                    
          a<=A; 
          b<=B; 
          s_1<=S; 
          
          Y<=y_in;

          carry_flag<=cy;
          sign_flag<=s;
          ov_flag<=ov;
          zero_flag<=z;
          operations_flag<=done;
        end
        FLAGS : begin
          
          
          a<=A; 
          b<=B; 
          s_1<=S; 
          
          Y<=y_in;

          carry_flag<=cy;
          sign_flag<=s;
          ov_flag<=ov;
          zero_flag<=z;
          operations_flag<=done;
        end
        
        
    endcase
    end
end

    
endmodule