
module ALUControl_32 (
    input wire [1:0] ALUOp,
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    input wire [6:0] funct7,
    output reg [3:0] ALUControl
);

    always @(*) begin
        ALUControl = 4'b0010; // Soma por padrão

        case (ALUOp)
            2'b00: begin
                if (opcode == 7'b0110111)
                    ALUControl = 4'b0111; // LUI: resultado = B
                else
                    ALUControl = 4'b0010; // LW, SW, AUIPC
            end

            2'b01: ALUControl = 4'b0110; // BEQ/BNE

            2'b10: begin
                case (funct3)
                    3'b000: begin
                        if (opcode == 7'b0110011 &&
                            funct7 == 7'b0100000)
                            ALUControl = 4'b0110; // SUB
                        else
                            ALUControl = 4'b0010; // ADD/ADDI
                    end

                    3'b111: ALUControl = 4'b0000; // AND/ANDI
                    3'b110: ALUControl = 4'b0001; // OR/ORI
                    3'b100: ALUControl = 4'b0011; // XOR/XORI
                    3'b001: ALUControl = 4'b0100; // SLL/SLLI
                    3'b101: ALUControl = 4'b0101; // SRL/SRLI

                    default: ALUControl = 4'b0010;
                endcase
            end

            default: ALUControl = 4'b0010;
        endcase
    end

endmodule
