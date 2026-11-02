
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

    // Dados enviados para a etapa WB
    output reg [31:0] ALUResult_out,
    output reg [31:0] ReadData_out,
    output reg [4:0] rd_out,

    // Controles enviados para WB
    output reg RegWrite_out,
    output reg MemToReg_out
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ALUResult_out <= 32'b0;
            ReadData_out <= 32'b0;
            rd_out <= 5'b0;
            RegWrite_out <= 1'b0;
            MemToReg_out <= 1'b0;
        end
        else if (Flush) begin
            ALUResult_out <= 32'b0;
            ReadData_out <= 32'b0;
            rd_out <= 5'b0;
            RegWrite_out <= 1'b0;
            MemToReg_out <= 1'b0;
        end
        else begin
            ALUResult_out <= ALUResult_in;
            ReadData_out <= ReadData_in;
            rd_out <= rd_in;
            RegWrite_out <= RegWrite_in;
            MemToReg_out <= MemToReg_in;
        end
    end

endmodule
