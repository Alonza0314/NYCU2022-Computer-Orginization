
`timescale 1ns/1ps
/*instr[30,14:12]*/
module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output   reg[4-1:0] ALU_Ctrl_o
);
wire [2:0] func3;
assign func3 = instr[2:0];
/* Write your code HERE */

always @(*) begin
    case(ALUOp)
        //R-type: add, slt
        2'b1x: begin
            //add
            if(instr==4'b0000) begin
                ALU_Ctrl_o=4'b0010;
            end
            //slt
            else if(instr==4'b0010) begin
                ALU_Ctrl_o=4'b0111;
            end
        end
        //addi, lw, sw
        2'b00: begin
            ALU_Ctrl_o=4'b0010;
        end
        //beq
        2'b01: begin
            ALU_Ctrl_o=4'b0110;
        end
        //jal, jalr
        default: ALU_Ctrl_o=4'bxxxx;
    endcase
end
endmodule

