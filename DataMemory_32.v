
module DataMemory_32 (
    input wire clk,
    input wire reset,
    input wire MemRead,
    input wire MemWrite,
    input wire [31:0] Address,
    input wire [31:0] WriteData,
    output wire [31:0] ReadData
);

    // Memoria com 256 palavras de 32 bits
    reg [31:0] memory [0:255];

    integer i;

    // Leitura combinacional (LW)
    assign ReadData = MemRead
        ? memory[Address[9:2]]
        : 32'b0;

    // Escrita sincronizada com o clock (SW)
    // Reset limpa a memoria
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1)
                memory[i] <= 32'b0;
        end
        else if (MemWrite) begin
            memory[Address[9:2]] <= WriteData;
        end
    end

endmodule
