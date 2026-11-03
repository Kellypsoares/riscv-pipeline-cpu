
module MEM_WB_Register (
    input wire clk,
    input wire reset,
    input wire Flush,

    // Dados vindos da etapa MEM
    input wire [31:0] ALUResult_in,
    input wire [31:0] ReadData_in,
    input wire [4:0] rd_in,

    // Sinais de controle
    input wire RegWrite_in,
    input wire MemToReg_in,

    // Novas entradas para JAL e JALR
    input wire [31:0] PC_in,
    input wire Jump_in,

    // Dados enviados para a etapa WB
    output reg [31:0] ALUResult_out,
    output reg [31:0] ReadData_out,
    output reg [4:0] rd_out,

    // Controles enviados para WB
    output reg RegWrite_out,
    output reg MemToReg_out,

    // Novas saidas para JAL e JALR
    output reg [31:0] PC_out,
    output reg Jump_out
);

    always @(posedge clk or posedge reset) begin
        if (reset || Flush) begin
            ALUResult_out <= 32'b0;
            ReadData_out <= 32'b0;
            rd_out <= 5'b0;
            RegWrite_out <= 1'b0;
            MemToReg_out <= 1'b0;
            PC_out <= 32'b0;
            Jump_out <= 1'b0;
        end
        else begin
            ALUResult_out <= ALUResult_in;
            ReadData_out <= ReadData_in;
            rd_out <= rd_in;
            RegWrite_out <= RegWrite_in;
            MemToReg_out <= MemToReg_in;
            PC_out <= PC_in;
            Jump_out <= Jump_in;
        end
    end

endmodule
