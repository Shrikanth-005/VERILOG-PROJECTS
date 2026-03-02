module pipelined_alu_3stage(
input clk,
input reset,
input [15:0] A,
input [15:0] B,
input [3:0] opcode,
output reg [15:0] result,
output reg zero,
output reg carry,
output reg sign,
output reg overflow
);

reg [15:0] A_reg,B_reg;
reg [3:0] opcode_reg;

reg [16:0] temp_reg;
reg [15:0] result_stage2;
reg carry_stage2;
reg overflow_stage2;

always @(posedge clk or posedge reset) begin
if(reset) begin
A_reg<=0;
B_reg<=0;
opcode_reg<=0;
end else begin
A_reg<=A;
B_reg<=B;
opcode_reg<=opcode;
end
end

always @(posedge clk or posedge reset) begin
if(reset) begin
result_stage2<=0;
carry_stage2<=0;
overflow_stage2<=0;
temp_reg<=0;
end else begin
case(opcode_reg)
4'b0000: begin
temp_reg=A_reg+B_reg;
result_stage2<=temp_reg[15:0];
carry_stage2<=temp_reg[16];
overflow_stage2<=temp_reg[15]^temp_reg[16];
end
4'b0001: begin
temp_reg=A_reg-B_reg;
result_stage2<=temp_reg[15:0];
carry_stage2<=temp_reg[16];
overflow_stage2<=temp_reg[15]^temp_reg[16];
end
4'b0010: result_stage2<=A_reg&B_reg;
4'b0011: result_stage2<=A_reg|B_reg;
4'b0100: result_stage2<=A_reg^B_reg;
default: result_stage2<=0;
endcase
end
end

always @(posedge clk or posedge reset) begin
if(reset) begin
result<=0;
zero<=0;
carry<=0;
sign<=0;
overflow<=0;
end else begin
result<=result_stage2;
carry<=carry_stage2;
overflow<=overflow_stage2;
zero<=(result_stage2==0);
sign<=result_stage2[15];
end
end

endmodule
