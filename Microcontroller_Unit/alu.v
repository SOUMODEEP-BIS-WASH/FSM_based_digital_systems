`timescale 1ns/1ps

module alu (
    input [3:0]A,B,
    input [1:0]S,
    input en,
    output reg [3:0]Y,
    output reg alu_done
);

//reg [3:0]Y_ff;
//reg alu_ff;

always @(*) begin
    if(en) begin
        case (S)
            2'b00: begin Y=A+B;  end
            2'b01: begin Y=A-B;  end
            2'b10: begin Y=A&B;  end
            2'b11: begin Y=A|B;  end
            default: begin Y=4'b0000;   end
        endcase
        alu_done=1'b1;
    end
    else begin
        Y=4'b0000;
        alu_done=1'b0;
    end
end

endmodule