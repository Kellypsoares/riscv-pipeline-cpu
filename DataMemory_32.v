
module DataMemory_32 (
    input wire clk,
    input wire reset,
    input wire MemRead,
    input wire MemWrite,
    input wire [31:0] Address,
    input wire [31:0] WriteData,
    output wire [31:0] ReadData,

    // Controle de execucao da CPU
    input wire Enable,

    // Interface de carregamento externo
    input wire LoadWrite,
    input wire [31:0] LoadAddress,
    input wire [31:0] LoadData,

    // Saida de diagnostico
    output wire [31:0] DebugLoadData
);

    reg [31:0] memory [0:255];
    integer i;

    // Leitura assincrona utilizada pela CPU
    assign ReadData =
        MemRead ? memory[Address[9:2]] : 32'b0;

    // Leitura direta para diagnostico
    // Mostra o conteudo do endereco LoadAddress
    assign DebugLoadData = memory[LoadAddress[9:2]];

    // Escrita da CPU e carregamento externo
    always @(posedge clk or posedge reset or posedge LoadWrite) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1)
                memory[i] <= 32'b0;
        end
        else if (LoadWrite) begin
            // Carregamento independente do clock da CPU
            if (!Enable)
                memory[LoadAddress[9:2]] <= LoadData;
        end
        else if (Enable && MemWrite) begin
            // Escrita normal da instrucao SW
            memory[Address[9:2]] <= WriteData;
        end
    end

endmodule
