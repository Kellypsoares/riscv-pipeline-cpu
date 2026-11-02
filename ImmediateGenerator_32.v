
module ImmediateGenerator_32 (
    input wire [31:0] Instruction,
    output reg [31:0] Immediate
);

    wire [6:0] opcode;
    assign opcode = Instruction[6:0];

    always @(*) begin
        case (opcode)

            // Tipo I: ADDI, ANDI, ORI, XORI,
            // SLLI, SRLI, LW e JALR
            7'b0010011,
            7'b0000011,
            7'b1100111:
                Immediate = {{20{Instruction[31]}},
                             Instruction[31:20]};

            // Tipo S: SW
            7'b0100011:
                Immediate = {{20{Instruction[31]}},
                             Instruction[31:25],
                             Instruction[11:7]};

            // Tipo B: BEQ e BNE
            7'b1100011:
                Immediate = {{19{Instruction[31]}},
                             Instruction[31],
                             Instruction[7],
                             Instruction[30:25],
                             Instruction[11:8],
                             1'b0};

            // Tipo U: LUI e AUIPC
            7'b0110111,
            7'b0010111:
                Immediate = {Instruction[31:12], 12'b0};

            // Tipo J: JAL
            7'b1101111:
                Immediate = {{11{Instruction[31]}},
                             Instruction[31],
                             Instruction[19:12],
                             Instruction[20],
                             Instruction[30:21],
                             1'b0};

            // Instruções sem imediato
            default:
                Immediate = 32'b0;

        endcase
    end

endmodule
