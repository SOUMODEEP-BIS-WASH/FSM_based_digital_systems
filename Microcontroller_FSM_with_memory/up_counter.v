`timescale 1ns/1ps

module up_counter #(parameter N = 4)(
    input [N-1:0]prst_value,
    input clk,rst,prst,en,
    output reg [N-1:0]Q
);

always @(posedge clk) begin
    if (rst) begin
        Q<=0;
    end
    else if (prst) begin
        Q<=prst_value;
    end
    else if (en) begin
        Q<=Q+1;
    end
    else begin
        Q<=Q;
    end
    
end
    
endmodule