`timescale 1ns/1ps

module FSM_CPU (
    input clk,rst,
    output reg [3:0]Y,
    output reg carry_flag,
    output reg zero_flag,
    output reg sign_flag,
    output reg ov_flag,
    output reg operations_flag
);

//INSTRUCTION MEMORY ARRAY BLOCK
reg [9:0] instruction [7:0];

initial begin
    instruction[0] = 10'b0010010110;
    instruction[1] = 10'b0110010110;
    instruction[2] = 10'b1010010110;
    instruction[3] = 10'b1110010110;
    instruction[4] = 10'b0011000100;
    instruction[5] = 10'b0111010110;
    instruction[6] = 10'b1010011110;
    instruction[7] = 10'b1110000110;

end

//PARAMETERS

parameter FETCH = 3'b000,
          EXECUTE = 3'b001,
          STORE = 3'b010,
          FLAGS = 3'b011,
          ZERO_STATE =3'b100;

reg [2:0]PS,NS;

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

// PROGRAM COUNTER BLOCK

reg [2:0]PC;

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
            if (cy||z||s||ov||(PC==3'b111)) begin
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
        
          a<=0; 
          b<=0; 
          s_1<=0; 
        PC <=0;
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
          
          a<=instruction[PC][7:4]; 
          b<=instruction[PC][3:0]; 
          s_1<=instruction[PC][9:8]; 
          PC<=PC;
          Y<=y_in;
          carry_flag<=carry_flag;
          sign_flag<=sign_flag;
          ov_flag<=ov_flag;
          zero_flag<=zero_flag;
          operations_flag<=operations_flag;
        end
        EXECUTE : begin
                    
          a<=a; 
          b<=b; 
          s_1<=s_1; 
          PC<=PC;
          Y<=y_in;

          carry_flag<=carry_flag;
          sign_flag<=sign_flag;
          ov_flag<=ov_flag;
          zero_flag<=zero_flag;
          operations_flag<=operations_flag;
        end
        STORE : begin
          
                    
          a<=a; 
          b<=b; 
          s_1<=s_1; 
          
          Y<=y_in;
          if(cy||z||s||ov||(PC==3'b111)) begin
            PC<=PC;
          end
          else begin
            if(PC<3'b111) begin
              PC<=PC+1;
            end
            else begin
              PC<=3'b000;
            end
          end
          carry_flag<=carry_flag;
          sign_flag<=sign_flag;
          ov_flag<=ov_flag;
          zero_flag<=zero_flag;
          operations_flag<=operations_flag;
        end
        FLAGS : begin
          
          
          a<=a; 
          b<=b; 
          s_1<=s_1; 
          
          Y<=y_in;

          carry_flag<=cy;
          sign_flag<=s;
          ov_flag<=ov;
          zero_flag<=z;
          operations_flag<=(PC==3'b111);
          case (s_1)
              2'b00: begin 
                if(PC<3'b111) begin PC<=PC+1;end 
                else begin PC<=0; end
              end
              2'b01:begin 
                  if (z) begin
                    if(PC+2<=3'b111) begin PC<=PC+2; end
                    else begin PC<=0; end
                  end
                  else begin
                    if(PC<3'b111) begin PC<=PC+1;end 
                    else begin PC<=0; end
                  end
              end  
              2'b10: begin 
                  if (cy) begin
                    if(PC+3<=3'b111) begin PC<=PC+3; end
                    else begin PC<=0; end
                  end
                  else begin
                    if(PC<3'b111) begin PC<=PC+1;end 
                    else begin PC<=0; end
                  end
              end
              2'b11: begin 
                  if (s) begin
                    if(PC+4<=3'b111) begin PC<=PC+4; end
                    else begin PC<=0; end
                  end
                  else begin
                    if(PC<3'b111) begin PC<=PC+1;end 
                    else begin PC<=0; end
                  end
              end
              default: begin 
                    if(PC < 3'b111) PC <= PC + 1;
                    else PC <= 0;
                  end
          endcase
        end
        
        
    endcase
    end
end

    
endmodule