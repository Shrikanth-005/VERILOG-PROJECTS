module alu_16bit_tb;

    reg  [15:0] A;
    reg  [15:0] B;
    reg  [3:0]  opcode;
    wire [15:0] result;
    wire zero, carry, sign, overflow;

    alu_16bit uut (
        .A(A),
        .B(B),
        .opcode(opcode),
        .result(result),
        .zero(zero),
        .carry(carry),
        .sign(sign),
        .overflow(overflow)
    );

    initial begin

        $dumpfile("dump.vcd");
        $dumpvars(0, alu_16bit_tb);

        A = 16'd10; B = 16'd5; opcode = 4'b0000; #10;
        A = 16'd32767; B = 16'd1; opcode = 4'b0000; #10;
        A = 16'd20; B = 16'd5; opcode = 4'b0001; #10;
        A = 16'hF0F0; B = 16'h0FF0; opcode = 4'b0010; #10;
        A = 16'hAAAA; B = 16'h5555; opcode = 4'b0011; #10;
        A = 16'hAAAA; B = 16'h5555; opcode = 4'b0100; #10;
        A = 16'h8001; B = 16'd0; opcode = 4'b0101; #10;
        A = 16'h0001; B = 16'd0; opcode = 4'b0110; #10;

        #20;
        $finish;

    end

endmodule
