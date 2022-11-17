module registerFile
(
input clk,
input rst,
input[7:0] word,
input[7:0] in,
output reg[7:0] out,
input[1:0] read_write,
input[1:0] rw_reg,
input reg_on,
input [1:0] inp_flagReg
);
        reg[7:0]regs[3:0];//the 4 registers we have
        reg[7:0]externalmemory[15:0];
        wire[3:0] opcode = word[7:4]; //getting the opcode
        wire[1:0] rd = word[3:2];
        reg [1:0]flagReg; //CY<=flagReg[1] Z<=flagReg[0]
        always @(posedge reg_on,posedge rst)
        begin
            if(rst)
                begin
                    regs[3]<= 8'b0000_0000;
                    regs[2]<=8'b0000_0000;
                    regs[1]<=8'b0000_0000;
                    regs[0]<=8'b0000_0000;
                    flagReg <= 2'b00;
                end
            else
                begin
                    begin
                        
                        flagReg = inp_flagReg;
                        
                        $display("the value of flag register is %b",flagReg);

                        case(opcode)
                            4'b0000: //load from memory LD
                                begin
                                    regs[0]=externalmemory[word[3:0]];
                                    $display("value loaded from external memory %b is %b",word[3:0],regs[0]);
                                end
                            4'b0001://store into memory ST
                                begin
                                    externalmemory[word[3:0]]=regs[0];
                                    $display("value loaded into external memory %b is %b",word[3:0],externalmemory[word[3:0]]);
                                end
                            4'b0011: //MR INSTRUCTION
                                begin
                                    
                                    regs[rd] = regs[word[1:0]];
                                    $display("the value of register %b is %b",rd,regs[rd]);
                                end
                            4'b0010: //MI INSTRUCTION
                                begin
                                    //6bit sign extension of given value
                                    regs[rd] = {{6{word[1]}},{word[1:0]}} ;
                                    $display("the value of register %b is %b",rd,regs[rd]);
                                end
                                
                        endcase

                        case(read_write)
                            2'b10:
                                begin 
                                    $display("reading register %b",rw_reg);
                                    out = regs[rw_reg];
                                    
                                end
                            2'b01:
                                begin
                                    regs[rw_reg]= in;
                                    $display("the value of register %b is %b",rw_reg,regs[rw_reg]);
                                end
                        endcase
                    end
                end 
        end
endmodule