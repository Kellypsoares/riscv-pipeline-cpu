
module ControlUnit_32 (
    input wire [6:0] opcode,

    output reg RegWrite,
    output reg ALUSrc,
    output reg MemRead,
    output reg MemWrite,
    output reg MemToReg,
    output reg Branch,
    output reg Jump,
    output reg [1:0] ALUOp
);

    always @(*) begin
        // Valores padrão
        RegWrite = 1'b0;
        ALUSrc   = 1'b0;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        MemToReg = 1'b0;
        Branch   = 1'b0;
        Jump     = 1'b0;
        ALUOp    = 2'b00;

        case (opcode)

            // Tipo R: ADD, SUB, AND, OR, XOR, SLL, SRL
            7'b0110011: begin
                RegWrite = 1'b1;
                ALUOp    = 2'b10;
            end

            // Tipo I: ADDI, ANDI, ORI, XORI, SLLI, SRLI
            7'b0010011: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                ALUOp    = 2'b10;
            end

            // LW
            7'b0000011: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                MemRead  = 1'b1;
                MemToReg = 1'b1;
                ALUOp    = 2'b00;
            end

            // SW
            7'b0100011: begin
                ALUSrc   = 1'b1;
                MemWrite = 1'b1;
                ALUOp    = 2'b00;
            end

            // BEQ e BNE
            7'b1100011: begin
                Branch = 1'b1;
                ALUOp  = 2'b01;
            end

            // JAL e JALR
            7'b1101111,
            7'b1100111: begin
                RegWrite = 1'b1;
                Jump     = 1'b1;
                ALUOp    = 2'b00;
            end

            // LUI e AUIPC
            7'b0110111,
            7'b0010111: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                ALUOp    = 2'b00;
            end

            default: begin
                // Instrução não reconhecida:
                // mantém os sinais desativados
            end

        endcase
    end

endmodule
