`timescale 1ns/1ps

/*
VENDING MAACHINE WITH 2 INPUTS (MAYBE DIFFERENT COIN VALUES, LIKE COINS OF VALUES RS 10 AND RS 5) 
AND 1 OUTPUT (MAYBE ITEM THAT COSTS RS 25). EXTRA COIN VALUE WILL BE REUSED HERE AND NOT REFUNDED.
*/

module VM2(
    input c5,c10, // c5 = 5 RS COIN INPUT, c10 = 10 RS COIN INPUT
    input clk,rst,
    output reg item // item = RS 25 WORTH ITEM
);

parameter S0 = 3'b000,//NO MONEY INPUT
          S1 = 3'b001,//RS 5 STATE
          S2 = 3'b010,//RS 10 STATE
          S3 = 3'b011,//RS 15 STATE
          S4 = 3'b100,//RS 20 STATE
          S5 = 3'b101,//RS 25 STATE
          S6 = 3'b110;//RS 30 STATE

reg [2:0]PS,NS;

always @(posedge clk or posedge rst) begin
    if (rst) PS<=S0;
    else PS<=NS;
end
    
always @(PS,c5,c10) begin
    case (PS)
        S0: begin
            if (c5) NS=S1;
            else if (c10) NS=S2;
            else NS = S0;
        end
        S1: begin
            if (c5) NS=S2;
            else if (c10) NS=S3;
            else NS = S1;
        end
        S2: begin
            if (c5) NS=S3;
            else if (c10) NS=S4;
            else NS = S2;
        end
        S3: begin
            if (c5) NS=S4;
            else if (c10) NS=S5;
            else NS = S3;
        end
        S4: begin
            if (c5) NS=S5;
            else if (c10) NS=S6;
            else NS = S4;
        end
        S5: begin
            if (c5) NS=S1;
            else if (c10) NS=S2;
            else NS = S0;
        end
        S6: NS = S1;
        default: NS =S0;
    endcase 
    
end

always @(*) begin
    case (PS)
        S0: item = 1'b0;
        S1: item = 1'b0;
        S2: item = 1'b0;
        S3: item = 1'b0;
        S4: item = 1'b0;
        S5: item = 1'b1;
        S6: item = 1'b1;
        default: item = 1'b0;
    endcase
end

endmodule