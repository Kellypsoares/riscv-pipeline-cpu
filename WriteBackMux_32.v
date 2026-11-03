
module WriteBackMux_32 (
    input wire [31:0] ALUResult,
    input wire [31:0] ReadData,
    input wire MemToReg,

    // Nova entrada para JAL e JALR
    input wire [31:0] PC,
    input wire Jump,

    output wire [31:0] WriteBackData
);

    assign WriteBackData = Jump
        ? (PC + 32'd4)
        : (MemToReg ? ReadData : ALUResult);

endmodule
