
module EX_MEM_Register (
    input wire clk,
    input wire reset,
    input wire Flush,

    // Dados vindos da etapa EX
    input wire [31:0] PC_in,
    input wire [31:0] ALUResult_in,
    input wire [31:0] WriteData_in,
    input wire [4:0] rd_in,
    input wire Zero_in,

    // Sinais de controle
    input wire RegWrite_in,
    input wire MemRead_in,
    input wire MemWrite_in,
    input wire MemToReg_in,
    input wire Branch_in,
    input wire Jump_in,

    // Dados enviados para a etapa MEM
    output reg [31:0] PC_out,
    output reg [31:0] ALUResult_out,
    output reg [31:0] WriteData_out,
    output reg [4:0] rd_out,
    output reg Zero_out,

    // Controles enviados para MEM/WB
    output reg RegWrite_out,
    output reg MemRead_out,
    output reg MemWrite_out,
    output reg MemToReg_out,
    output reg Branch_out,
    output reg Jump_out
);

    always @(posedge clk or posedge reset) begin
        if (reset || Flush) begin
            PC_out <= 32'b0;
            ALUResult_out <= 32'b0;
            WriteData_out <= 32'b0;
            rd_out <= 5'b0;
            Zero_out <= 1'b0;

            RegWrite_out <= 1'b0;
            MemRead_out <= 1'b0;
            MemWrite_out <= 1'b0;
            MemToReg_out <= 1'b0;
            Branch_out <= 1'b0;
            Jump_out <= 1'b0;
        end
        else begin
            PC_out <= PC_in;
            ALUResult_out <= ALUResult_in;
            WriteData_out <= WriteData_in;
            rd_out <= rd_in;
            Zero_out <= Zero_in;

            RegWrite_out <= RegWrite_in;
            MemRead_out <= MemRead_in;
            MemWrite_out <= MemWrite_in;
            MemToReg_out <= MemToReg_in;
            Branch_out <= Branch_in;
            Jump_out <= Jump_in;
        end
    end

endmodule
