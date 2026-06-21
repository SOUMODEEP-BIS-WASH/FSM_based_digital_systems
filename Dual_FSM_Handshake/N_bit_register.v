`timescale 1ns/1ps

module n_bit_reg #(
    parameter N=4
) (
    input [N-1:0]D,
    input clk,rst,load,
    output reg [N-1:0]Q,
    output reg stored
);
always @(posedge clk) begin
    if (rst) begin
        Q<=0;
        stored<=0;
    end
    else if (load) begin
        Q<=D;
        stored<=1'b1;
    end
    else begin
        Q<=Q;
        stored<=1'b0;
    end
end
    
endmodule