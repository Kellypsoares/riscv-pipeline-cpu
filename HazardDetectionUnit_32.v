
module HazardDetectionUnit_32 (
    input wire [4:0] ID_EX_rd,
    input wire       ID_EX_MemRead,
    input wire [4:0] IF_ID_rs1,
    input wire [4:0] IF_ID_rs2,
    input wire       IF_ID_UsesRs1,
    input wire       IF_ID_UsesRs2,

    output reg       PCWrite,
    output reg       IF_ID_Write,
    output reg       ID_EX_Flush
);

    always @(*) begin
        // Funcionamento normal do pipeline
        PCWrite   = 1'b1;
        IF_ID_Write = 1'b1;
        ID_EX_Flush = 1'b0;

        // Detecta dependencia de uma instrucao LW
        if (ID_EX_MemRead &&
            (ID_EX_rd != 5'b00000) &&
            ((IF_ID_UsesRs1 && (ID_EX_rd == IF_ID_rs1)) ||
             (IF_ID_UsesRs2 && (ID_EX_rd == IF_ID_rs2)))) begin

            // Congela PC e IF/ID por um ciclo
            PCWrite    = 1'b0;
            IF_ID_Write = 1'b0;

            // Insere uma bolha no estagio EX
            ID_EX_Flush = 1'b1;
        end
    end

endmodule
