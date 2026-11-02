module ForwardBMux_32 (
    input wire [31:0] OriginalData,
    input wire [31:0] EX_MEM_Data,
    input wire [31:0] MEM_WB_Data,
    input wire [1:0] ForwardB,
    output reg [31:0] Result
);

    always @(*) begin
        case (ForwardB)
            2'b00: Result = OriginalData;
            2'b10: Result = EX_MEM_Data;
            2'b01: Result = MEM_WB_Data;
            default: Result = OriginalData;
        endcase
    end

endmodule