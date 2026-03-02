module alu_16bit (
    input  [15:0] A,
    input  [15:0] B,
    input  [3:0]  opcode,
    output reg [15:0] result,
    output reg zero,
    output reg carry,
    output reg sign,
    output reg overflow
);

    reg [16:0] temp;

    always @(*) begin
        temp     = 17'b0;
        result   = 16'b0;
        carry    = 1'b0;
        overflow = 1'b0;

        case(opcode)

            4'b0000: begin
                temp = A + B;
                result = temp[15:0];
                carry = temp[16];
                overflow = temp[15] ^ temp[16];
            end

            4'b0001: begin
                temp = A - B;
                result = temp[15:0];
                carry = temp[16];
                overflow = temp[15] ^ temp[16];
            end

            4'b0010: result = A & B;
            4'b0011: result = A | B;
            4'b0100: result = A ^ B;

            4'b0101: begin
                result = A << 1;
                carry = A[15];
            end

            4'b0110: begin
                result = A >> 1;
                carry = A[0];
            end

            default: result = 16'b0;

        endcase

        zero = (result == 16'b0);
        sign = result[15];

    end

endmodule
