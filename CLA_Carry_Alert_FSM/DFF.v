`timescale 1ns/1ps

module DFF(
    input [4:0]D,
    input load,rst,clk,
    output reg [4:0]Q
);

always @(posedge clk)
begin
    if(rst) begin
        Q<=0;
    end
    else if(load) begin
        Q<=D;
    end
    else begin
        Q<=Q;
    end
end

endmodule