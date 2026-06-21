`timescale 1ns/1ps

module para_FSM #(
    parameter N = 4
) (
    input clk, rst,
    output reg Dout
);


reg [$clog2(N)-1:0]NS,PS;

always @(posedge clk) begin
    if (rst) begin
        PS<=0;
    end
    else begin
        PS<=NS;
    end
    
end

always @(*) begin
    if(PS==N-1)begin
        NS=0;
    end
    else begin
        NS=PS+1;
    end

end

always @(*) begin
    Dout=(PS==N-1);
end

    
endmodule