`timescale 1ns/1ps

/*
VENDING MAACHINE WITH 2 INPUTS (MAYBE DIFFERENT COIN VALUES, LIKE COINS OF VALUES RS 10 AND RS 5) 
AND 3 OUTPUTS (MAYBE ITEM THAT COSTS RS 25 AND RS 15 AND RS 5). EXTRA COIN VALUE WILL BE REUSED HERE AND NOT REFUNDED.
SELECT LINE FOR SELECTING THE ITEM.
*/

module VM3(
    input c5,c10, // c5 = 5 RS COIN INPUT, c10 = 10 RS COIN INPUT
    input clk,rst,
    input [1:0]sel,//sel can be used to select the item: 10 = ITEM WORTH RS 15, 01 = ITEM WORTH RS 5,  ITEM WORTH RS 25 WILL BE AUTOMATICALLY CHOOSEN IF MONEY COUNT REACHES >= RS 25
    output reg item5,item15,item25 // item5 = RS 5 WORTH ITEM, item15 = RS 15 WORTH ITEM, item25 = RS 25 WORTH ITEM
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
    
always @(*) begin
    case (PS)
        S0: begin
            if (c5) NS=S1;
            else if (c10) NS=S2;
            else NS = S0;
        end
        S1: begin
            if (c5) NS=S2;
            else if (c10) NS=S3;
            else if (sel == 2'b01) NS = S0;
            else NS = S1;
        end
        S2: begin
            if (c5) NS=S3;
            else if (c10) NS=S4;
            else if (sel == 2'b01) NS = S1;
            else NS = S2;
        end
        S3: begin
            if (c5) NS=S4;
            else if (c10) NS=S5;
            else if (sel == 2'b10) NS =S0;
            else NS = S3;
        end
        S4: begin
            if (c5) NS=S5;
            else if (c10) NS=S6;
            else if (sel == 2'b10) NS =S1;
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
        S0: begin item5 = 1'b0; item15 = 1'b0; item25 = 1'b0; end
        S1: begin item5 = (sel==2'b01) ? 1'b1:1'b0; item15 = 1'b0; item25 = 1'b0; end
        S2: begin item5 = (sel==2'b01) ? 1'b1:1'b0; item15 = 1'b0; item25 = 1'b0; end
        S3: begin item5 = 1'b0; item15 =(sel==2'b10)? 1'b1:1'b0; item25 = 1'b0; end
        S4: begin item5 = 1'b0; item15 =(sel==2'b10) ?1'b1:1'b0; item25 = 1'b0; end
        S5: begin item5 = 1'b0; item15 = 1'b0; item25 = 1'b1; end
        S6: begin item5 = 1'b0; item15 = 1'b0; item25 = 1'b1; end
        default: begin item5 = 1'b0; item15 = 1'b0; item25 = 1'b0; end
    endcase
end

endmodule