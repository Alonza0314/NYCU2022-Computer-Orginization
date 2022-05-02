`timescale 1ns/1ps

module Decoder(
	input	[32-1:0] 	instr_i,
	output wire			ALUSrc,
	output wire			RegWrite,
	output wire			Branch,
	output wire [2-1:0]	ALUOp
	);
	
//Internal Signals
wire	[7-1:0]		opcode;
wire 	[3-1:0]		funct3;
wire	[3-1:0]		Instr_field; //R-type not use
wire	[9-1:0]		Ctrl_o; //R-type not use

/* Write your code HERE */

//Lab3-code start
assign opcode=instr_i[6:0];
assign funct3=instr_i[14:12];

assign ALUSrc=1'b0;
assign RegWrite=1'b1;
assign Branch=1'b0;
assign ALUOp=2'b10;
//Lab3-code end

endmodule





                    
                    
