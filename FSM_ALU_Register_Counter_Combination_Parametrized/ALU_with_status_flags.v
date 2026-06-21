`timescale 1ns/1ps

module ALU_status (
    input [3:0]A,B,
    input [1:0]S,
    output reg [3:0]Y,
    output reg carry,
    output reg zero,
    output reg sign,
    output reg overflow 
);
reg [4:0]temp;
always @(*) begin
    carry=0;
    overflow=0;
    case (S)
        2'b00: begin 
            temp= A + B;
            Y=temp[3:0];
            carry=temp[4];
            overflow= (A[3]&B[3]&(~Y[3]))|((~A[3])&(~B[3])&Y[3]);
            end
        2'b01: begin 
            temp= A - B;
            Y=temp[3:0];
            carry=temp[4];
            overflow= (A[3]&(~B[3])&(~Y[3]))|((~A[3])&(B[3])&Y[3]);
            end
        2'b10: Y= A & B;
        2'b11: Y= A | B;
        default: Y=Y;
    endcase
    zero = (Y==4'b0000);
    sign = Y[3];
end
//---------//


endmodule