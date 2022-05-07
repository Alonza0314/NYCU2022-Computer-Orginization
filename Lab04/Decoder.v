
`timescale 1ns/1ps

module Decoder(
    input   [7-1:0]     instr_i,
    output reg          RegWrite,
    output reg          Branch,
    output reg          Jump,
    output reg          WriteBack1,
    output reg          WriteBack0,
    output reg          MemRead,
    output reg          MemWrite,
    output reg          ALUSrcA,
    output reg          ALUSrcB,
    output reg[2-1:0]   ALUOp
);

/* Write your code HERE */

wire [7-1:0] opcode;
assign opcode=instr_i;

always@(*) begin
    if(opcode==7'b0110011) begin //R-type
        {RegWrite,Branch,Jump}=3'b100;
        {WriteBack1,WriteBack0}=2'b00;
        {MemRead,MemWrite}=2'b00;
        {ALUSrcA,ALUSrcB}=2'bx0;
        ALUOp=2'b1x;
    end
    else if (opcode==7'b0010011) begin //addi
        {RegWrite,Branch,Jump}=3'b100;
        {WriteBack1,WriteBack0}=2'b00;
        {MemRead,MemWrite}=2'b00;
        {ALUSrcA,ALUSrcB}=2'bx1;
        ALUOp=2'b00; 
    end
    else if (opcode==7'b0000011) begin //Load
        {RegWrite,Branch,Jump}=3'b100;
        {WriteBack1,WriteBack0}=2'b01;
        {MemRead,MemWrite}=2'b10;
        {ALUSrcA,ALUSrcB}=2'bx1;
        ALUOp=2'b00;
    end
    else if (opcode==7'b0100011) begin //Store
        {RegWrite,Branch,Jump}=3'b000;
        {WriteBack1,WriteBack0}=2'bxx;
        {MemRead,MemWrite}=2'b01;
        {ALUSrcA,ALUSrcB}=2'bx1;
        ALUOp=2'b00;
    end
    else if (opcode==7'b1100011) begin //Branch
        {RegWrite,Branch,Jump}=3'b010;
        {WriteBack1,WriteBack0}=2'bxx;
        {MemRead,MemWrite}=2'b00;
        {ALUSrcA,ALUSrcB}=2'b00;
        ALUOp=2'b01;
    end
    else if (opcode==7'b1101111) begin //JAL
        {RegWrite,Branch,Jump}=3'b1x1;
        {WriteBack1,WriteBack0}=2'b1x;
        {MemRead,MemWrite}=2'b00;
        {ALUSrcA,ALUSrcB}=2'b0x;
        ALUOp=2'bxx;
    end
    else if (opcode==7'b1100111) begin //JALR
        {RegWrite,Branch,Jump}=3'b1x1;
        {WriteBack1,WriteBack0}=2'b1x;
        {MemRead,MemWrite}=2'b00;
        {ALUSrcA,ALUSrcB}=2'b1x;
        ALUOp=2'bxx;
    end
    else begin
        {RegWrite,Branch,Jump}=3'b000;
        {WriteBack1,WriteBack0}=2'b00;
        {MemRead,MemWrite}=2'b00;
        {ALUSrcA,ALUSrcB}=2'b0x;
        ALUOp=2'bxx;
    end
end
endmodule

