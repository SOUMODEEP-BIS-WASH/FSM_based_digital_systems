`timescale 1ns/1ps

module RTC(
    input clk,rst,
    output reg [7:0]HR_M,HR_L,MIN_M,MIN_L,SEC_M,SEC_L
);

reg [3:0]count1,count2,count3,count4,count5,count6;

always @(posedge clk or posedge rst)
begin
    if(rst) begin
        count1<=0;
        count2<=0;
        count3<=0;
        count4<=0;
        count5<=0;
        count6<=0;
    end
    else begin
        // Seconds
    if (count1 < 9) begin
        count1 <= count1 + 1;
    end
    else begin
        count1 <= 0;

        if (count2 < 5) begin
            count2 <= count2 + 1;
        end
        else begin
            count2 <= 0;

            // Minutes
            if (count3 < 9) begin
                count3 <= count3 + 1;
            end
            else begin
                count3 <= 0;

                if (count4 < 5) begin
                    count4 <= count4 + 1;
                end
                else begin
                    count4 <= 0;
                    if (count6 == 2 && count5 == 3) begin
                        count6 <= 0;
                        count5 <= 0;
                    end
                    else if (count5 < 9) begin
                        count5 <= count5 + 1;
                    end
                    else begin
                        count5 <= 0;
                        count6 <= count6 + 1;
                    end
                end
            end
        end
    end
    end
end

always @(count1,count2,count3,count4,count5,count6) begin
    case (count1)
        0: SEC_L = 8'b0111_1110;
        1: SEC_L = 8'b0011_0000;
        2: SEC_L = 8'b0110_1101;
        3: SEC_L = 8'b0111_1001;
        4: SEC_L = 8'b0011_0011;
        5: SEC_L = 8'b0101_1011;
        6: SEC_L = 8'b0101_1111;
        7: SEC_L = 8'b0111_0000;
        8: SEC_L = 8'b0111_1111;
        9: SEC_L = 8'b0111_1011;
        default: SEC_L = 8'b0111_1110;
    endcase
        case (count2)
        0: SEC_M = 8'b0111_1110;
        1: SEC_M = 8'b0011_0000;
        2: SEC_M = 8'b0110_1101;
        3: SEC_M = 8'b0111_1001;
        4: SEC_M = 8'b0011_0011;
        5: SEC_M = 8'b0101_1011;
        6: SEC_M = 8'b0101_1111;
        7: SEC_M = 8'b0111_0000;
        8: SEC_M = 8'b0111_1111;
        9: SEC_M = 8'b0111_1011;
        default: SEC_M = 8'b0111_1110;
    endcase
        case (count3)
        0: MIN_L = 8'b0111_1110;
        1: MIN_L = 8'b0011_0000;
        2: MIN_L = 8'b0110_1101;
        3: MIN_L = 8'b0111_1001;
        4: MIN_L = 8'b0011_0011;
        5: MIN_L = 8'b0101_1011;
        6: MIN_L = 8'b0101_1111;
        7: MIN_L = 8'b0111_0000;
        8: MIN_L = 8'b0111_1111;
        9: MIN_L = 8'b0111_1011;
        default: MIN_L = 8'b0111_1110;
    endcase
        case (count4)
        0: MIN_M = 8'b0111_1110;
        1: MIN_M = 8'b0011_0000;
        2: MIN_M = 8'b0110_1101;
        3: MIN_M = 8'b0111_1001;
        4: MIN_M = 8'b0011_0011;
        5: MIN_M = 8'b0101_1011;
        6: MIN_M = 8'b0101_1111;
        7: MIN_M = 8'b0111_0000;
        8: MIN_M = 8'b0111_1111;
        9: MIN_M = 8'b0111_1011;
        default: MIN_M = 8'b0111_1110;
    endcase
        case (count5)
        0: HR_L = 8'b0111_1110;
        1: HR_L = 8'b0011_0000;
        2: HR_L = 8'b0110_1101;
        3: HR_L = 8'b0111_1001;
        4: HR_L = 8'b0011_0011;
        5: HR_L = 8'b0101_1011;
        6: HR_L = 8'b0101_1111;
        7: HR_L = 8'b0111_0000;
        8: HR_L = 8'b0111_1111;
        9: HR_L = 8'b0111_1011;
        default: HR_L = 8'b0111_1110;
    endcase
        case (count6)
        0: HR_M = 8'b0111_1110;
        1: HR_M = 8'b0011_0000;
        2: HR_M = 8'b0110_1101;
        3: HR_M = 8'b0111_1001;
        4: HR_M = 8'b0011_0011;
        5: HR_M = 8'b0101_1011;
        6: HR_M = 8'b0101_1111;
        7: HR_M = 8'b0111_0000;
        8: HR_M = 8'b0111_1111;
        9: HR_M = 8'b0111_1011;
        default: HR_M = 8'b0111_1110;
    endcase
end   

endmodule