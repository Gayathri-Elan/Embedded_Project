module programcounter(pc,word,HLT);
input[15:0] pc;
output reg[7:0] word;
output reg HLT;
always @(pc) 
    begin
        HLT=1;
        case(pc)
            0: word=8'b0010_0001;
            1: word=8'b0010_1110;
            2: word=8'b0101_0011;
            3: word=8'b0101_1100;
            default: HLT=0;
        endcase
    end 
endmodule