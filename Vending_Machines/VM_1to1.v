`timescale 1ns/1ps

//VENDING MACHINE WITH 1 INPUT (MONEY) AND 1 OUTPUT (ITEM)

module VM1(
    input coin5, //COIN 5 IS THE INPUT TO THIS VM, i.e., THIS VM WILL ONLY 5 Rs. COIN AS INPUT
    input clk,rst,
    output reg item // ITEM IS THE OUTPUT OF THIS VM
);
parameter S0 = 1'b0, S1 =1'b1;
reg NS,PS;

always @(posedge clk or posedge rst) begin
    if (rst) PS<=S0;
    else PS<=NS;
end

always @(*) begin
    case (PS)
        S0: NS = (coin5)?S1:S0;
        S1: NS = (coin5)?S1:S0;
        default: NS = S0;
    endcase
end

always @(*)begin
    case (PS)
        S0 : item = 1'b0;
        S1 : item = 1'b1;
        default : item = 1'b0; 
    endcase
end

endmodule