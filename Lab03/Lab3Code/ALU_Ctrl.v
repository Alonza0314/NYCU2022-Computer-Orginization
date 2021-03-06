`timescale 1ns/1ps

module ALU_Ctrl(
	input		[4-1:0]	instr,
	input		[2-1:0]	ALUOp,
	output	reg [4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */

//Lab3-code start
always@(*)begin
	case(ALUOp)
		2'b10: //R-type
			case(instr)
				4'b0000:begin //add
					ALU_Ctrl_o=4'b0010;
				end
				4'b1000:begin //sub
					ALU_Ctrl_o=4'b0110;
				end
				4'b0111:begin //and
					ALU_Ctrl_o=4'b0000;
				end
				4'b0110:begin //or
					ALU_Ctrl_o=4'b0001;
				end
				4'b0100:begin //xor
					ALU_Ctrl_o=4'b1100;
				end
				4'b0010:begin //slt
					ALU_Ctrl_o=4'b0111;
				end
				4'b0001:begin //sll
					ALU_Ctrl_o=4'b1000;
				end
				4'b1101:begin //sra
					ALU_Ctrl_o=4'b1001;
				end
				default:begin
					ALU_Ctrl_o=4'bxxxx;
				end
			endcase
		default:begin //other cases
			ALU_Ctrl_o=4'bxxxx;
		end
	endcase
end
//Lab-3 code end

endmodule
