module ALU_32_tb;
    reg [31:0] A, B;
    reg [3:0] ALUControl;
    wire [31:0] Result;
    wire Zero;

    ALU_32 uut (
        .A(A),
        .B(B),
        .ALUControl(ALUControl),
        .Result(Result),
        .Zero(Zero)
    );

    initial begin
        A = 5;
        B = 3;
        ALUControl = 4'b0010;
        #10;

        $display("5 + 3 = %0d", Result);
        $display("Zero = %b", Zero);
        $finish;
    end
endmodule
