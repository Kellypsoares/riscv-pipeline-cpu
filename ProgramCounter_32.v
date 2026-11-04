
module ProgramCounter_32 (
    input wire clk,
    input wire reset,
    input wire PCWrite,
    input wire [31:0] NextPC,
    output reg [31:0] PC,

    // Controle de pausa da CPU
    input wire Enable
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            PC <= 32'b0;
        else if (Enable && PCWrite)
            PC <= NextPC;
    end

endmodule
