
module IF_ID_Register (
    input wire clk,
    input wire reset,
    input wire IF_ID_Write,
    input wire Flush,

    input wire [31:0] PC_in,
    input wire [31:0] Instruction_in,

    output reg [31:0] PC_out,
    output reg [31:0] Instruction_out,

    // Controle de pausa da CPU
    input wire Enable
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC_out <= 32'b0;
            Instruction_out <= 32'b0;
        end
        else if (Enable) begin
            if (Flush) begin
                PC_out <= 32'b0;
                Instruction_out <= 32'b0;
            end
            else if (IF_ID_Write) begin
                PC_out <= PC_in;
                Instruction_out <= Instruction_in;
            end
        end
    end

endmodule
