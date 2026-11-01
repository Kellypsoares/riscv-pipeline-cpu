
`timescale 1ns/1ps

module RegisterFile_32_tb;

    reg clk = 0;
    reg reset = 0;
    reg RegWrite = 0;

    reg [4:0] rs1 = 0;
    reg [4:0] rs2 = 0;
    reg [4:0] rd = 0;
    reg [31:0] WriteData = 0;

    wire [31:0] ReadData1;
    wire [31:0] ReadData2;

    RegisterFile_32 uut (
        .clk(clk),
        .reset(reset),
        .RegWrite(RegWrite),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    // Clock: alterna a cada 5 ns
    always #5 clk = ~clk;

    initial begin
        // Inicializa todos os registradores
        reset = 1;
        #2;
        reset = 0;

        // Escreve 42 no registrador x5
        @(negedge clk);
        rd = 5;
        WriteData = 42;
        RegWrite = 1;

        @(negedge clk);
        RegWrite = 0;

        // Lê x5
        rs1 = 5;
        #1;

        if (ReadData1 !== 32'd42)
            $fatal(1, "ERRO: x5 deveria ser 42");

        $display("PASSOU: x5 = %0d", ReadData1);

        // Tenta escrever 99 em x0
        rd = 0;
        WriteData = 99;
        RegWrite = 1;

        @(negedge clk);
        RegWrite = 0;
        rs2 = 0;
        #1;

        if (ReadData2 !== 32'd0)
            $fatal(1, "ERRO: x0 deveria continuar em zero");

        $display("PASSOU: x0 = %0d", ReadData2);

        $display("TODOS OS TESTES PASSARAM!");
        $finish;
    end

endmodule
