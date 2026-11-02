
module BranchJumpUnit_32 (
    input wire [31:0] PC,
    input wire [31:0] ReadData1,
    input wire [31:0] ReadData2,
    input wire [31:0] Immediate,
    input wire [6:0]  opcode,
    input wire [2:0]  funct3,

    output reg [31:0] TargetPC,
    output reg        TakeBranch
);

    always @(*) begin
        TargetPC   = PC + 32'd4;
        TakeBranch = 1'b0;

        case (opcode)
            // BEQ e BNE
            7'b1100011: begin
                case (funct3)
                    3'b000: TakeBranch = (ReadData1 == ReadData2);
                    3'b001: TakeBranch = (ReadData1 != ReadData2);
                    default: TakeBranch = 1'b0;
                endcase

                TargetPC = PC + Immediate;
            end

            // JAL
            7'b1101111: begin
                TakeBranch = 1'b1;
                TargetPC   = PC + Immediate;
            end

            // JALR
            7'b1100111: begin
                if (funct3 == 3'b000) begin
                    TakeBranch = 1'b1;
                    TargetPC   = (ReadData1 + Immediate) & 32'hFFFFFFFE;
                end
            end

            default: begin
                TakeBranch = 1'b0;
                TargetPC   = PC + 32'd4;
            end
        endcase
    end

endmodule
