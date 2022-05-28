`timescale 1ns/1ps

module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output reg  [4-1:0] ALU_Ctrl_o
);
/* Write your code HERE */

always @(*) begin
    case(ALUOp)
        //R-type: add sub and or xor slt
        2'b10:begin
            if(instr==4'b0000) begin //add
                ALU_Ctrl_o=4'b0010;
            end
            else if(instr==4'b1000) begin //sub
                ALU_Ctrl_o=4'b0110;
            end
            else if(instr==4'b0111) begin //and
                ALU_Ctrl_o=4'b0000;
            end
            else if(instr==4'b0110) begin //or
                ALU_Ctrl_o=4'b0001;
            end
            else if(instr==4'b0100) begin //xor
                ALU_Ctrl_o=4'b0111;
            end
            else if(instr==4'b0010) begin //slt
                ALU_Ctrl_o=4'b0011;
            end
        end
        //addi nop slti slli
        2'b11:begin
            if(instr[2:0]==3'b000) begin //addi nop
                ALU_Ctrl_o=4'b0010;
            end
            else if(instr[2:0]==3'b010) begin //slti
                ALU_Ctrl_o=4'b0011;
            end
            else if(instr==4'b0001) begin //slli
                ALU_Ctrl_o=4'b1100;
            end
        end
        //load store
        2'b00:begin
            ALU_Ctrl_o=4'b0010;
        end
        //beq
        2'b01:begin
            ALU_Ctrl_o=4'b0110;
        end
        //jal jalr
        default:ALU_Ctrl_o=4'bxxxx;
    endcase
end

endmodule
