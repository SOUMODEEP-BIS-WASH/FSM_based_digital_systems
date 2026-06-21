`timescale 1ns/1ps

module self_checking_tb;

reg c5,c10,clk=0,rst;
wire item, refund;

VM uut(c5,c10,clk,rst,item,refund);

reg check_item, check_refund;

always #5 clk=~clk;

task reset();
 begin
    @(posedge clk)
    rst = 1'b1;
    c5 = 1'b0;
    c10 = 1'b0;
    @(posedge clk)
    rst = 1'b0;
    c5 = 1'b0;
    c10 = 1'b0;
 end
endtask

task insert(input coin1, input coin2);
begin
   @(negedge clk)
   c10=coin1;
   c5=coin2; 
end    
endtask

task compare(input check_i, input check_r, input coin1, input coin2, input coin3, input coin4, input coin5);
begin
   @(negedge clk)     
    if((check_i==item)&&(check_r==refund)) $display(" TEST OK FOR COIN 5 = %b, COIN 5 = %b, COIN 5 = %b & COIN 10 = %b , COIN 10 = %b ",coin1,coin2,coin3,coin4,coin5);
    else $display(" TEST FAILED FOR COIN 5 = %b, COIN 5 = %b, COIN 5 = %b & COIN 10 = %b , COIN 10 = %b ",coin1,coin2,coin3,coin4,coin5); 
end
endtask

task self_check();
begin

insert(1'b0,1'b1);
insert(1'b0,1'b1);
insert(1'b0,1'b1);
check_item = 1;
check_refund = 0;
compare(check_item,check_refund,1'b1,1'b1,1'b1,1'b0,1'b0);

reset();

insert(1'b1,1'b0);
insert(1'b1,1'b0);
check_item = 1;
check_refund = 1;
compare(check_item,check_refund,1'b0,1'b0,1'b0,1'b1,1'b1);

reset();

insert(1'b0,1'b1);
insert(1'b1,1'b0);
check_item = 1;
check_refund = 0;
compare(check_item,check_refund,1'b1,1'b0,1'b0,1'b1,1'b0);

reset();

insert(1'b0,1'b1);
insert(1'b0,1'b0);
repeat(5) begin @(posedge clk); end
insert(1'b0,1'b1);
check_item = 0;
check_refund = 0;
compare(check_item,check_refund,1'b1,1'b0,1'b0,1'b1,1'b0);

reset();

end
endtask

initial begin
    $dumpfile("tb_self.vcd");
    $dumpvars(0,self_checking_tb);
    
    reset();
    self_check();
    
  #300;
    $finish;
end


endmodule