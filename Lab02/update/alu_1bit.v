// iverilog -o 1bit alu_1bit_tb.v alu_1bit.v MUX*
// ./1bit

`timescale 1ns/1ps

module alu_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input				less,       //1 bit less      (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg			set,		//1 bit set		  (output)
	output reg          cout        //1 bit carry out (output)
	);

/* Write your code HERE */
// Operation
// 2'b00 and
// 2'b01 or
// 2'b10 adder
// 2'b11 less

wire src1_to_a,src2_to_b;

assign src1_to_a=src1^Ainvert;
assign src2_to_b=src2^Binvert;

always @(*) begin
	case (operation)
		2'b00: begin
			result=src1_to_a&src2_to_b;
		end
		2'b01: begin
			result=src1_to_a|src2_to_b;
		end
		2'b10: begin
			{cout,result}=src1_to_a+src2_to_b+cin;
		end
		default:begin
			{cout,set}=src1_to_a+src2_to_b+cin;
			result=less;
		end
	endcase
end

endmodule
