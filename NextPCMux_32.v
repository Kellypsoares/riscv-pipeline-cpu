
module NextPCMux_32 (
    input wire [31:0] PCPlus4,
    input wire [31:0] TargetPC,
    input wire TakeBranch,
    output wire [31:0] NextPC
);

    assign NextPC = TakeBranch ? TargetPC : PCPlus4;

endmodule
