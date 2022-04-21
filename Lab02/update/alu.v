// iverilog -o lab2 alu.v alu_1bit.v testbench.v MUX*
// ./lab2

`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */

wire Ainvert,Binvert;
assign Ainvert=ALU_control[3];
assign Binvert=ALU_control[2];
wire [2-1:0] operation=ALU_control[1:0];

wire [32-1:0] results;
wire [32-1:0] set;
wire cout0,cout1,cout2,cout3,cout4,cout5,cout6,cout7,cout8,cout9;
wire cout10,cout11,cout12,cout13,cout14,cout15,cout16,cout17,cout18,cout19;
wire cout20,cout21,cout22,cout23,cout24,cout25,cout26,cout27,cout28,cout29;
wire cout30,cout31;
reg cin_at_first_ALU_1bit;
reg less_first;
reg less=1'b0;

alu_1bit first	(src1[0],src2[0],less_first,Ainvert,Binvert,cin_at_first_ALU_1bit,operation,results[0],set[0],cout0);
alu_1bit one	(src1[1],src2[1],less,Ainvert,Binvert,cout0,operation,results[1],set[1],cout1);
alu_1bit two	(src1[2],src2[2],less,Ainvert,Binvert,cout1,operation,results[2],set[2],cout2);
alu_1bit three	(src1[3],src2[3],less,Ainvert,Binvert,cout2,operation,results[3],set[3],cout3);
alu_1bit four	(src1[4],src2[4],less,Ainvert,Binvert,cout3,operation,results[4],set[4],cout4);
alu_1bit five	(src1[5],src2[5],less,Ainvert,Binvert,cout4,operation,results[5],set[5],cout5);
alu_1bit six	(src1[6],src2[6],less,Ainvert,Binvert,cout5,operation,results[6],set[6],cout6);
alu_1bit seven	(src1[7],src2[7],less,Ainvert,Binvert,cout6,operation,results[7],set[7],cout7);
alu_1bit eight	(src1[8],src2[8],less,Ainvert,Binvert,cout7,operation,results[8],set[8],cout8);
alu_1bit nine	(src1[9],src2[9],less,Ainvert,Binvert,cout8,operation,results[9],set[9],cout9);
alu_1bit ten		(src1[10],src2[10],less,Ainvert,Binvert,cout9,operation,results[10],set[10],cout10);
alu_1bit eleven		(src1[11],src2[11],less,Ainvert,Binvert,cout10,operation,results[11],set[11],cout11);
alu_1bit twelve		(src1[12],src2[12],less,Ainvert,Binvert,cout11,operation,results[12],set[12],cout12);
alu_1bit thirteen	(src1[13],src2[13],less,Ainvert,Binvert,cout12,operation,results[13],set[13],cout13);
alu_1bit fourteen	(src1[14],src2[14],less,Ainvert,Binvert,cout13,operation,results[14],set[14],cout14);
alu_1bit fifteen	(src1[15],src2[15],less,Ainvert,Binvert,cout14,operation,results[15],set[15],cout15);
alu_1bit sixteen	(src1[16],src2[16],less,Ainvert,Binvert,cout15,operation,results[16],set[16],cout16);
alu_1bit seventeen	(src1[17],src2[17],less,Ainvert,Binvert,cout16,operation,results[17],set[17],cout17);
alu_1bit eighteen	(src1[18],src2[18],less,Ainvert,Binvert,cout17,operation,results[18],set[18],cout18);
alu_1bit nineteen	(src1[19],src2[19],less,Ainvert,Binvert,cout18,operation,results[19],set[19],cout19);
alu_1bit twenty			(src1[20],src2[20],less,Ainvert,Binvert,cout19,operation,results[20],set[20],cout20);
alu_1bit twenty_one		(src1[21],src2[21],less,Ainvert,Binvert,cout20,operation,results[21],set[21],cout21);
alu_1bit twenty_two		(src1[22],src2[22],less,Ainvert,Binvert,cout21,operation,results[22],set[22],cout22);
alu_1bit twenty_three	(src1[23],src2[23],less,Ainvert,Binvert,cout22,operation,results[23],set[23],cout23);
alu_1bit twenty_four	(src1[24],src2[24],less,Ainvert,Binvert,cout23,operation,results[24],set[24],cout24);
alu_1bit twenty_five	(src1[25],src2[25],less,Ainvert,Binvert,cout24,operation,results[25],set[25],cout25);
alu_1bit twenty_six		(src1[26],src2[26],less,Ainvert,Binvert,cout25,operation,results[26],set[26],cout26);
alu_1bit twenty_seven	(src1[27],src2[27],less,Ainvert,Binvert,cout26,operation,results[27],set[27],cout27);
alu_1bit twenty_eight	(src1[28],src2[28],less,Ainvert,Binvert,cout27,operation,results[28],set[28],cout28);
alu_1bit twenty_nine	(src1[29],src2[29],less,Ainvert,Binvert,cout28,operation,results[29],set[29],cout29);
alu_1bit thirty			(src1[30],src2[30],less,Ainvert,Binvert,cout29,operation,results[30],set[20],cout30);
alu_1bit thirty_one		(src1[31],src2[31],less,Ainvert,Binvert,cout30,operation,results[31],set[31],cout31);

always @(*) begin
	if(!rst_n)begin
		result=0;
		zero=0;
		cout=0;
		overflow=0;
	end
	else begin
		// 0000 and
		// 0001 or
		// 0010 add
		// 0110 sub
		// 0111 slt
		// 1100 xor
		// 1101 xand
		case(ALU_control)
			4'b0000,4'b0001,4'b1100,4'b1101:begin
				cin_at_first_ALU_1bit=0;
				cout=0;
				result=results;
				overflow=0;
				less_first=1'b0;
				less=1'b0;
			end
			4'b0010:begin
				cin_at_first_ALU_1bit=0;
				cout=cout31;
				result=results;
				overflow=cout30^cout31;
				less_first=1'b0;
				less=1'b0;
			end
			4'b0110:begin
				cin_at_first_ALU_1bit=1;
				cout=cout31;
				result=results;
				overflow=cout30^cout31;
				less_first=1'b0;
				less=1'b0;
			end
			4'b0111:begin
				cin_at_first_ALU_1bit=1;
				cout=0;
				less_first=set[31];
				result=results;
				overflow=0;
			end
		endcase
		zero=|result;
		zero=~zero;
	end
end

endmodule
