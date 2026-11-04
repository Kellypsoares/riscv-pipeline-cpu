
module RegisterFile_32 (
    input wire clk,
    input wire reset,
    input wire RegWrite,

    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,

    input wire [31:0] WriteData,

    output wire [31:0] ReadData1,
    output wire [31:0] ReadData2,
    output wire [31:0] DebugX3,
    output wire [31:0] DebugX4,
    output wire [31:0] DebugX1,

    // Controle de pausa da CPU
    input wire Enable,

    // Nova saida de diagnostico
    output wire [31:0] DebugX2
);

    reg [31:0] registers [0:31];

    integer i;

    // Leitura com WB -> ID forwarding
    // Durante a pausa, o forwarding fica desabilitado.
    assign ReadData1 =
        (rs1 == 0) ? 32'b0 :
        (Enable && RegWrite && rd != 0 && rd == rs1) ? WriteData :
        registers[rs1];

    assign ReadData2 =
        (rs2 == 0) ? 32'b0 :
        (Enable && RegWrite && rd != 0 && rd == rs2) ? WriteData :
        registers[rs2];

    // Saidas de diagnostico
    assign DebugX3 = registers[3];
    assign DebugX4 = registers[4];
    assign DebugX1 = registers[1];
    assign DebugX2 = registers[2];

    // Escrita na borda de subida do clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'b0;
        end
        else if (Enable && RegWrite && rd != 0) begin
            registers[rd] <= WriteData;
        end
    end

endmodule
