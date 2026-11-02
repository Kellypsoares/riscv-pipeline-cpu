
module InstructionMemory_32 (
    input wire [31:0] Address,
    output wire [31:0] Instruction
);

    reg [31:0] memory [0:255];

    initial begin
        $readmemh("/Users/kellysoares/Documents/Faculdade/arqComp/RICV_entrega/program.hex", memory);
    end

    assign Instruction = memory[Address[9:2]];

endmodule
