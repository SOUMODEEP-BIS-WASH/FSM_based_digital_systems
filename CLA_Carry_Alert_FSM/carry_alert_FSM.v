`timescale 1ns/1ps

module carry_alert_FSM(
    input Din,
    input clk,rst,
    output reg carry_alert
);
parameter S0 =1'b0,
          S1 =1'b1;
reg PS,NS;

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
        S0: NS=(Din==1'b1)?S1:S0;
        S1: NS=(Din==1'b0)?S0:S1;
        default: NS=S0;
    endcase
end

always @(*) begin
    case(PS)
        S0: carry_alert=(Din==1'b1)?1'b1:1'b0;
        S1: carry_alert=(Din==1'b1)?1'b1:1'b0;
        default: carry_alert=1'b0;
    endcase
end

    
endmodule