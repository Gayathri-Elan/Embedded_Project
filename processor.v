module processor(input clk,input rst);
                //------ REGISTER FILE --------//
    wire[7:0] rf_out;//output from registerfile
    reg[7:0] rf_in;//input from registerfile
    reg rf_on;//toswitch on registerfile
    reg[1:0] read_write;
    reg[1:0] rw_reg;
    integer count;//to count number of clock cycles
    registerFile rf(clk,rst,word,rf_in,rf_out,read_write,rw_reg,rf_on,flagReg);
                //---------------PC-------------//
    wire[7:0] word; //declaration of databus
    reg[15:0] pc;
    wire HLT=1;
    reg increment;
    programcounter pcounter(pc,word,HLT);
    always@(posedge increment)
    begin
        
        $display("%d instruction: %b",pc+1,word);
        $display("");
        pc=pc+1;
        count=0;
    end
      //------------ ALU -------------//
    reg[7:0] alu_in1;
    reg[7:0] alu_in2;
    wire[7:0] alu_out;
    reg ALU;
    wire [1:0] flagReg;
    ALU  alu(alu_out,clk,alu_in1,alu_in2,word,ALU,flagReg,rst);
            always@(HLT)
            begin
                $display("HALT");
                $display("");
            end
            always @(posedge clk,posedge rst)

          
                begin

                if(rst)
                    begin
                        pc=16'b0;
                        count=0;
                        rf_on=1'b0;
                        ALU=1'b0;
                        // $display("the word is %b",word);
                    end
                else
                begin
                if(HLT)
                begin
                  count = count+1;
                //   $display("the count value is : %d",count);
                    case(word[7:4])
                        4'b0000,4'b0001,4'b0010,4'b0011:
                        begin
                            case(count)
                            1:
                            begin
                                rf_on = 1'b1;
                                rf_on=1'b0;
                            end
                            2:
                            begin
                                increment=1'b1;
                                increment=1'b0;
                            end
                            endcase
                        end
                        4'b0100,4'b0101,4'b0110,4'b1000,4'b1010,4'b0111:
                            begin
                                        case(count)
                                            1:
                                            begin
                                            rf_on=1'b1;
                                            rf_on=1'b0;
                                            read_write=2'b10;
                                            rw_reg = word[1:0];
                                            end
                                            2:
                                            begin
                                                $display("this is the output %b",rf_out);
                                                alu_in1 = rf_out;
                                                rf_on = 1'b1;
                                                rf_on=1'b0;
                                                read_write =2'b10;
                                                rw_reg = word[3:2];
                                            end
                                            3:
                                            begin
                                                ALU = 1'b1;
                                                ALU=1'b0;
                                                alu_in2 = rf_out;
                                                $display("this is the output %b",rf_out);
                                                
                                            end
                                            4:
                                            begin
                                                
                                                rf_on=1'b1;
                                                rf_on=1'b0;
                                                if(word[7:4] == 4'b0111)
                                                    begin
                                                        read_write=2'b00;
                                                    end
                                                else
                                                    begin
                                                        read_write=2'b01;
                                                    end
                                                rw_reg = word[3:2];
                                                rf_in = alu_out;
                                                $display("this is the alu output %b",alu_out);
                                                $display("");
                                            end//this is the control signal to increment program counter to get next instruction
                                            5:
                                            begin
                                                increment = 1'b1;
                                                increment = 1'b0;
                                            end
                                        endcase
                                    
                                end
                            4'b1100,4'b1101,4'b1111,4'b1110,4'b1001,4'b1011:
                            begin
                                        case(count)
                                            1:
                                            begin
                                            rf_on=1'b1;
                                            rf_on=1'b0;
                                            read_write=2'b10;
                                            rw_reg = word[3:2];
                                            end
                                            2:
                                            begin
                                                $display("this is the output %b",rf_out);
                                                alu_in1 = rf_out;
                                                read_write =2'b00;
                                            end
                                            3:
                                            begin
                                                alu_in2 = {{6{word[1]}},{word[1:0]}} ;
                                                $display("this is the output %b",alu_in2);
                                                ALU = 1'b1;
                                                ALU=1'b0;
                                            end
                                            4:
                                            begin
                                                rf_on = 1'b1;
                                                rf_on=1'b0;
                                                if(word[7:4] == 4'b1111)
                                                    begin
                                                        read_write=2'b00;
                                                    end
                                                else
                                                    begin
                                                        read_write=2'b01;
                                                    end
                                                rw_reg = word[3:2];
                                                rf_in = alu_out;
                                                $display("this is the output %b",alu_out);
                                                $display("");
                                            end//this is the control signal to increment program counter to get next instruction
                                            5:
                                            begin
                                                increment=1'b1;
                                                increment=1'b0;
                                                
                                            end
                                        endcase
                                    
                                end
                                
                    endcase
                end
                // else
                // begin
                //     $display("thank you for using our processor");
                // end
                end
                end
endmodule