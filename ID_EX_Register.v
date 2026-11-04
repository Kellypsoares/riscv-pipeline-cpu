
module ID_EX_Register (
    input wire clk,
    input wire reset,
    input wire Flush,

    // Dados da etapa ID
    input wire [31:0] PC_in,
    input wire [31:0] ReadData1_in,
    input wire [31:0] ReadData2_in,
    input wire [31:0] Immediate_in,
    input wire [4:0] rs1_in,
    input wire [4:0] rs2_in,
    input wire [4:0] rd_in,

    // Controle da etapa EX
    input wire Enable,
    input wire ALUSrc_in,

    // Controle das etapas MEM e WB
    input wire RegWrite_in,
    input wire MemRead_in,
    input wire MemWrite_in,
    input wire MemToReg_in,
    input wire Branch_in,
    input wire Jump_in,

    // Entradas para branches e jumps
    input wire [6:0] opcode_in,
    input wire [2:0] funct3_in,

    // Entrada funct7
    input wire [6:0] funct7_in,

    // Entrada ALUOp
    input wire [1:0] ALUOp_in,

    // Dados armazenados
    output reg [31:0] PC_out,
    output reg [31:0] ReadData1_out,
    output reg [31:0] ReadData2_out,
    output reg [31:0] Immediate_out,
    output reg [4:0] rs1_out,
    output reg [4:0] rs2_out,
    output reg [4:0] rd_out,

    // Controles armazenados
    output reg [3:0] ALUControl_out,
    output reg ALUSrc_out,
    output reg RegWrite_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg MemToReg_out,
    output reg Branch_out,
    output reg Jump_out,

    // Saidas para branches e jumps
    output reg [6:0] opcode_out,
    output reg [2:0] funct3_out,

    // Saida funct7
    output reg [6:0] funct7_out,

    // Saida ALUOp
    output reg [1:0] ALUOp_out
);

    always @(posedge clk or posedge reset) begin

        // Reset tem prioridade
        if (reset) begin
            PC_out <= 32'b0;
            ReadData1_out <= 32'b0;
            ReadData2_out <= 32'b0;
            Immediate_out <= 32'b0;
            rs1_out <= 5'b0;
            rs2_out <= 5'b0;
            rd_out <= 5'b0;

            ALUControl_out <= 4'b0;
            ALUSrc_out <= 1'b0;
            RegWrite_out <= 1'b0;
            MemRead_out <= 1'b0;
            MemWrite_out <= 1'b0;
            MemToReg_out <= 1'b0;
            Branch_out <= 1'b0;
            Jump_out <= 1'b0;

            opcode_out <= 7'b0;
            funct3_out <= 3'b0;
            funct7_out <= 7'b0;
            ALUOp_out <= 2'b0;
        end

        // Enable = 0: mantem todos os valores
        else if (Enable) begin

            // Flush so atua quando Enable = 1
            if (Flush) begin
                PC_out <= 32'b0;
                ReadData1_out <= 32'b0;
                ReadData2_out <= 32'b0;
                Immediate_out <= 32'b0;
                rs1_out <= 5'b0;
                rs2_out <= 5'b0;
                rd_out <= 5'b0;

                ALUControl_out <= 4'b0;
                ALUSrc_out <= 1'b0;
                RegWrite_out <= 1'b0;
                MemRead_out <= 1'b0;
                MemWrite_out <= 1'b0;
                MemToReg_out <= 1'b0;
                Branch_out <= 1'b0;
                Jump_out <= 1'b0;

                opcode_out <= 7'b0;
                funct3_out <= 3'b0;
                funct7_out <= 7'b0;
                ALUOp_out <= 2'b0;
            end

            // Funcionamento normal do pipeline
            else begin
                PC_out <= PC_in;
                ReadData1_out <= ReadData1_in;
                ReadData2_out <= ReadData2_in;
                Immediate_out <= Immediate_in;
                rs1_out <= rs1_in;
                rs2_out <= rs2_in;
                rd_out <= rd_in;

                // Saida mantida por compatibilidade
                ALUControl_out <= 4'b0;

                ALUSrc_out <= ALUSrc_in;
                RegWrite_out <= RegWrite_in;
                MemRead_out <= MemRead_in;
                MemWrite_out <= MemWrite_in;
                MemToReg_out <= MemToReg_in;
                Branch_out <= Branch_in;
                Jump_out <= Jump_in;

                opcode_out <= opcode_in;
                funct3_out <= funct3_in;
                funct7_out <= funct7_in;
                ALUOp_out <= ALUOp_in;
            end
        end
    end

endmodule
