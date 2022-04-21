module MUX4to1(
	input			src1,
	input			src2,
	input			src3,
	input			src4,
	input   [2-1:0] select,
	output reg		result
	);
/* Write your code HERE */
// src1=>00
// src2=>01
// src3=>10
// src4=>11

always @(src1,src2,src3,src4,select) begin
	case(select)
		2'b00:begin
			result=src1;
		end
		2'b01:begin
			result=src2;
		end
		2'b10:begin
			result=src3;
		end
		default:begin
			result=src4;
		end
	endcase
end

endmodule
