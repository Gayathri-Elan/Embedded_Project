module ALU(output reg [7:0] out,input clk,input  [7:0] in1,input [7:0] in2,input[7:0] word,input ALU,output reg[1:0] alu_flagReg,input rst);
  wire [3:0] opcode = word[7:4];
  // wire[1:0] rd = word[3:2];
  // wire[1:0] rs = word[1:0];
  //reg [1:0] alu_flagReg;
  always @(posedge ALU, posedge rst) 
  begin
    if(rst)
      begin
      alu_flagReg = 2'b00;
      end
    else
    begin
      alu_flagReg = 2'b00;
      $display("alu word: %b",word);
      case(opcode)
      4'b0100,4'b1100://sum SUM and SMI
        begin
          out = in1+in2;
          if(out < in1 && out < in2)
            begin
                alu_flagReg[1] = 1;
              end
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
            out = in2-in1;
            if(in2<in1)
              begin
                alu_flagReg[1] = 1;
              end
          end
        4'b0110,4'b1110: //and ANR and ANI
          begin
            out = in1 & in2;
          end
    endcase
    if(out == 8'b0)
      begin 
        alu_flagReg[0] = 1;
      end
    end

    case(opcode)
        4'b0111,4'b1111: //compare CM and CMI
          begin
            if(in1 == in2)
              begin
                alu_flagReg = 2'b01;
              end
            else if(in1 < in2)
              begin
                alu_flagReg = 2'b10;
              end
            else
              begin
                alu_flagReg = 2'b00;
              end
          end

      endcase
    
  end
endmodule