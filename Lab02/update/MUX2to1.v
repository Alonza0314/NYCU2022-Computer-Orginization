module MUX2to1(
	input      src1,
	input      src2,
	input	   select,
	output reg result
	);
/* Write your code HERE */

always @(src1,src2,select) begin
	result=(!select) ? src1:src2;
end

endmodule
