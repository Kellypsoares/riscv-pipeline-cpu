
module InstructionDecoder_32 (
    input wire [31:0] Instruction,

    output wire [6:0] opcode,
    output wire [4:0] rs1,
    output wire [4:0] rs2,
    output wire [4:0] rd,
    output wire [2:0] funct3,
    output wire [6:0] funct7,

    output wire UsesRs1,
    output wire UsesRs2
);

    assign opcode = Instruction[6:0];
    assign rd     = Instruction[11:7];
    assign funct3 = Instruction[14:12];
    assign rs1    = Instruction[19:15];
    assign rs2    = Instruction[24:20];
    assign funct7 = Instruction[31:25];

    // Instrucoes que utilizam rs1:
    // R-type, I-type aritmetico, LW, SW, branches e JALR
    assign UsesRs1 =
        (opcode == 7'b0110011) ||
        (opcode == 7'b0010011) ||
        (opcode == 7'b0000011) ||
        (opcode == 7'b0100011) ||
        (opcode == 7'b1100011) ||
        (opcode == 7'b1100111);

    // Instrucoes que utilizam rs2:
    // R-type, SW e branches
    assign UsesRs2 =
        (opcode == 7'b0110011) ||
        (opcode == 7'b0100011) ||
        (opcode == 7'b1100011);

endmodule
