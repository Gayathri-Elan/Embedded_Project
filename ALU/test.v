module ALU_tb;
  reg clk;
  reg[7:0] Y;
  reg[7:0] in2;
  reg[7:0] word;
  wire[7:0] out;
  
  ALU tb(out,clk,in1,in2,word);
  initial word = 8'b1010_0000;
  initial in1=8'b1111_1111;
  initial in2=8'b0000_1110;
  initial begin clk = 1;
    forever#5 clk = ~clk;
  end
  initial #100 $finish;
    
  
  //always @(posedge clk) begin
  
  //end

  initial begin #100
    $display("%b",out);
  end
  
endmodule