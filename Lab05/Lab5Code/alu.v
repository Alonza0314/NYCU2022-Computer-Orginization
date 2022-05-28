`timescale 1ns/1ps

module alu(
    input                   rst_n,         // negative reset            (input)
    input        [32-1:0]   src1,          // 32 bits source 1          (input)
    input        [32-1:0]   src2,          // 32 bits source 2          (input)
    input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
    output reg   [32-1:0]   result,        // 32 bits result            (output)
    output reg              zero           // 1 bit when the output is 0, zero must be set (output)
);

/* Write your code HERE */

reg [32-1:0] set;

always @(*) begin
    if(!rst_n) begin
        result=0;
        zero=0;
    end
    else begin
        case(ALU_control)
            4'b0010: begin //add
                result=src1+src2;
            end
            4'b0110: begin //sub
                result=src1-src2;
            end
            4'b0000: begin //and
                result=src1&src2;
            end
            4'b0001: begin //or
                result=src1|src2;
            end
            4'b0111:begin //xor
                result=src1^src2;
            end
            4'b0011:begin //slt
                set=src1-src2;
                if(set[31]==1) begin
                    result=32'b00000000000000000000000000000001;
                end
                else begin
                    result=32'b00000000000000000000000000000000;
                end
            end
            4'b1100: begin //sll
                result=src1<<src2;
            end
            default: begin
                result=32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
            end
        endcase
    end
    zero=~(|result);
end

endmodule
