// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module registerfile_tb;
  reg clk;
  reg rst;
  reg[7:0]word,in;
  wire[7:0] out;
  reg [1:0]read_write,rw_reg;
  reg reg_on;
  
  registerFile tb(clk,rst,word,in,out,read_write,rw_reg,reg_on);
   
   initial 
    begin
        rst=1;
      reg_on = 1;
        #5 rst=0;
    end
  initial begin
    #10 
    read_write = 2'b01;
        rw_reg = 2'b10;
        in = 8'b0001_1000;
    #50 read_write = 2'b10;
    	rw_reg = 2'b10;
  end
   initial begin clk = 1;
    forever#5 clk = ~clk;
  end
  initial  begin#70
    $display("%b",out);
  end
   initial #98 $finish;
endmodule