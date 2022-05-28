`timescale 1ns/1ps

module Decoder(
    input [32-1:0]  instr_i,
    output reg         Branch,
    output reg         ALUSrc,
    output reg         RegWrite,
    output reg [2-1:0] ALUOp,
    output reg         MemRead,
    output reg         MemWrite,
    output reg         MemtoReg,
    output reg         Jump
);

//Internal Signals
wire    [7-1:0]     opcode;
wire    [3-1:0]     funct3;
wire    [3-1:0]     Instr_field;
wire    [9:0]       Ctrl_o;

/* Write your code HERE */

assign opcode=instr_i[6:0];
assign funct3=instr_i[14:12];

always @(*) begin
    if(opcode==7'b0110011) begin //R-type 00001,00010
        {RegWrite,Branch,Jump}=3'b100;
        {MemRead,MemWrite}=2'b00;
        {ALUSrc,MemtoReg}=2'b00;
        ALUOp=2'b10;
    end
    else if(opcode==7'b0010011) begin //I-type general 00101,00011
        {RegWrite,Branch,Jump}=3'b100;
        {MemRead,MemWrite}=2'b00;
        {ALUSrc,MemtoReg}=2'b10;
        ALUOp=2'b11;
    end
    else if(opcode==7'b0000011) begin //load 00111,10000
        {RegWrite,Branch,Jump}=3'b100;
        {MemRead,MemWrite}=2'b10;
        {ALUSrc,MemtoReg}=2'b11;
        ALUOp=2'b00;
    end
    else if(opcode==7'b0100011) begin //store 00100,01000
        {RegWrite,Branch,Jump}=3'b000;
        {MemRead,MemWrite}=2'b01;
        {ALUSrc,MemtoReg}=2'b10;
        ALUOp=2'b00;
    end
    else if(opcode==7'b1100011) begin //branch 00000,00101
        {RegWrite,Branch,Jump}=3'b010;
        {MemRead,MemWrite}=2'b00;
        {ALUSrc,MemtoReg}=2'b00;
        ALUOp=2'b01;
    end
    else if(opcode==7'b1101111) begin //jal 01001,00000
        {RegWrite,Branch,Jump}=3'b101;
        {MemRead,MemWrite}=2'b00;
        {ALUSrc,MemtoReg}=2'b00;
        ALUOp=2'b00;
    end
    else if(opcode==7'b1100111) begin //jalr 10101,00000
        {RegWrite,Branch,Jump}=3'b100;
        {MemRead,MemWrite}=2'b00;
        {ALUSrc,MemtoReg}=2'b10;
        ALUOp=2'b00;
    end
    else begin
        {RegWrite,Branch,Jump}=3'b000;
        {MemRead,MemWrite}=2'b00;
        {ALUSrc,MemtoReg}=2'b00;
        ALUOp=2'bxx;
    end
end

endmodule







