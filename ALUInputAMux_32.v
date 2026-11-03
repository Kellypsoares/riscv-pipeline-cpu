
module ALUInputAMux_32 (
    input wire [31:0] ForwardedData,
    input wire [31:0] PC,
    input wire [6:0] opcode,
    output wire [31:0] Result
);

    assign Result = (opcode == 7'b0010111)
                  ? PC
                  : ForwardedData;

endmodule
