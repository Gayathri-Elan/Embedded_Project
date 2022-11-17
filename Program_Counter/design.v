module programcounter(pc,word,HLT);
input[15:0] pc;
output reg[7:0] word;
output reg HLT;
always @(pc) 
    begin
        HLT=1;
        case(pc)
            0: word=8'b0010_0010;
            1: word=8'b0010_1101;
            2: word=8'b0011_1000;
            3: word=8'b0001_0111;
            4: word=8'b0011_0001;
            5: word=8'b0000_0111;
            6: word=8'b0100_0011; 
            default: HLT=0;
        endcase
    end 
endmodule