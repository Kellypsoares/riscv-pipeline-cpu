module WriteBackMux_32 (
    input wire [31:0] ALUResult,
    input wire [31:0] ReadData,
    input wire MemToReg,
    output wire [31:0] WriteBackData
);

    assign WriteBackData = MemToReg ? ReadData : ALUResult;

endmodule