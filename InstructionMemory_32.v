
module InstructionMemory_32 (
    input wire [31:0] Address,
    output wire [31:0] Instruction,

    // Controle de execucao da CPU
    input wire Enable,

    // Interface de carregamento externo
    input wire LoadWrite,
    input wire [31:0] LoadAddress,
    input wire [31:0] LoadData,

    // Saida para diagnostico
    output wire [31:0] DebugLoadData
);

    reg [31:0] memory [0:255];

    // Carregamento inicial do programa
    initial begin
        $readmemh(
            "/Users/kellysoares/Documents/Faculdade/arqComp/RICV_entrega/program.hex",
            memory
        );
    end

    // Leitura normal de instrucoes pela CPU
    assign Instruction = memory[Address[9:2]];

    // Leitura direta para diagnostico
    assign DebugLoadData = memory[LoadAddress[9:2]];

    // Carregamento externo independente do clock da CPU
    always @(posedge LoadWrite) begin
        if (!Enable)
            memory[LoadAddress[9:2]] <= LoadData;
    end

endmodule
