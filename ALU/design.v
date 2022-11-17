module ALU(output reg [7:0] out,input clk,input  [7:0] in1,input [7:0] in2,input[7:0] word,input ALU);
  wire [3:0] opcode = word[7:4];
  // wire[1:0] rd = word[3:2];
  // wire[1:0] rs = word[1:0];
  always @(posedge ALU) 
  begin
    begin
      $display("alu word: %b",word);
      case(opcode)
      4'b0100,4'b1100://sum SUM and SMI
        begin
          out = in1+in2;
        end
      4'b1010,4'b1011://xor XRR and XRI
          begin
            out = in1^in2;
          end
      4'b1000,4'b1001://or ORR and ORI
          begin
            out = in1|in2;
          end
        4'b0101,4'b1101://subtraction SB and SBI
          begin
            out = in1 -in2;
          end
        4'b0110,4'b1110: //and ANR and ANI
          begin
            out = in1 & in2;
          end
        4'b0111,4'b1111: //compare CM and CMI
          begin
            if(in1 == in2)
              begin
                out = 8'b0000_0000;
              end
            else if(in1 < in2)
              begin
                out = 8'b0000_0001;
              end
            else
              begin
                out = 8'b0000_0010;
              end
          end

      endcase
    end
  end
endmodule