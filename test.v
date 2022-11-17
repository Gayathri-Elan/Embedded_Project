// Code your testbench here
// or browse Examples
module processortest;
    reg clk; //declaration of clock
    reg rst; //declaration of reset

  processor tb(clk,rst);//initially sending a reset signal to default values
    initial 
    begin
        rst=1;
        #5 rst=0;
    end
    //clock cycle
  initial 
  begin clk = 1;
    forever#5 clk = ~clk;
  end
    // initial
    // begin
    //   always@(increment)
    //   begin
    //     if(increment)
          
    //   end
    // end
   initial #500 $finish;
endmodule