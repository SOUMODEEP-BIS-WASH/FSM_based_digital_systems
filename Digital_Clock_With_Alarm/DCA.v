`timescale 1ns/1ps

module DCA(
    input [7:0]H_A,M_A,S_A,
    input clk,rst,
    output reg alarm,
    output reg [7:0]H,M,S
);

reg [7:0]ch,cm,cs;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        ch<=0;
        cm<=0;
        cs<=0;
    end
    else begin
        if(cs<59) begin
         cs <= cs+1;
        end
        else begin
            cs<=0;
            if(cm<59) begin
                cm<=cm+1;
            end 
            else begin
                cm<=0;
                if(ch<23) begin
                    ch<=ch+1;
                end
                else begin
                    ch<=0;
                end
            end
        end
           
    end
end

always @(*) begin
    H = ch;
    M = cm;
    S = cs;
    if((H==H_A)&&(M==M_A)&&(S==S_A)) alarm = 1'b1;
    else alarm = 1'b0;
end
    
endmodule