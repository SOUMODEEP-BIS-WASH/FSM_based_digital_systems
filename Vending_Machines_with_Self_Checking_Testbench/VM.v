`timescale 1ns/1ps

/*
VENDING MAACHINE WITH 2 INPUTS (MAYBE DIFFERENT COIN VALUES, LIKE COINS OF VALUES RS 10 AND RS 5) 
AND 2 OUTPUTS (MAYBE ITEM THAT COSTS RS 15 AND REFUND OF EXTRA MONEY). HERE IF NO COIN IS GIVEN FOR CERTAIN COUNT VALUES, 
VM WILL GO TO INITIAL STATE.
*/

module VM(
    input c5,c10, // c5 = 5 RS COIN INPUT, c10 = 10 RS COIN INPUT
    input clk,rst,
    output reg item,refund // item = RS 25 WORTH ITEM, refund = REFUND OF EXTRA 5 RS COIN
);

parameter S0 = 3'b000,//NO MONEY INPUT
          S1 = 3'b001,//RS 5 STATE
          S2 = 3'b010,//RS 10 STATE
          S3 = 3'b011,//RS 15 STATE
          S4 = 3'b100;//RS 20 STATE

reg [2:0]PS,NS,count;

always @(posedge clk or posedge rst) begin
    if (rst) begin PS<=S0; count<=0; end
    else begin PS<=NS; count<=count+1; end
end
    
always @(PS,c5,c10,count) begin
    case (PS)
        S0: begin
            if (c5) NS=S1;
            else if (c10) NS=S2;
            else NS = S0;
        end
        S1: begin
            if (c5) NS=S2;
            else if (c10) NS=S3;
            else begin
                if (count==4) begin NS = S0; count = 0; end
                else NS =S1;
            end
        end
        S2: begin
            if (c5) NS=S3;
            else if (c10) NS=S4;
            else begin 
                if (count==4) begin NS = S0; count = 0; end
                else NS=S2;
            end
        end
        S3: NS = S0;
        S4: NS = S0;
        default: NS =S0;
    endcase 
    
end

always @(*) begin
    case (PS)
        S0: begin item = 1'b0; refund=1'b0; end
        S1: begin item = 1'b0; refund=1'b0; end
        S2: begin item = 1'b0; refund=1'b0; end
        S3: begin item = 1'b1; refund=1'b0; end
        S4: begin item = 1'b1; refund=1'b1; end
        default: begin item = 1'b0; refund = 1'b0; end
    endcase
end

endmodule