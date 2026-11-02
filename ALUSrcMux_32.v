
module ALUSrcMux_32 (
    input wire [31:0] ReadData2,
    input wire [31:0] Immediate,
    input wire ALUSrc,
    output wire [31:0] ALUB
);

    assign ALUB = ALUSrc ? Immediate : ReadData2;

endmodule
