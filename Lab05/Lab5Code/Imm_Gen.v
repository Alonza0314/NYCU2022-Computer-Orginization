`timescale 1ns/1ps

module Imm_Gen(
    input      [31:0] instr_i,
    output reg [31:0] Imm_Gen_o
);

/* Write your code HERE */

wire [7-1:0] opcode;
assign opcode=instr_i[6:0];

always @(*) begin
    //I-type: addi, Load, JALR
    if((opcode==7'b0010011)||(opcode==7'b0000011)||(opcode==7'b1100111)) begin
        Imm_Gen_o={{20{instr_i[31]}},instr_i[31:20]};
    end
    //S-type: Store
    else if (opcode==7'b0100011) begin
        Imm_Gen_o={{20{instr_i[31]}},instr_i[31:25],instr_i[11:7]};
    end
    //B-type: Branch
    else if (opcode==7'b1100011) begin
        Imm_Gen_o={{20{instr_i[31]}},instr_i[7],instr_i[30:25],instr_i[11:8],1'b0};
    end
    //J-type: JAL
    else if (opcode==7'b1101111) begin
        Imm_Gen_o={{12{instr_i[31]}},instr_i[19:12],instr_i[20],instr_i[30:21],1'b0};
    end
end

endmodule
