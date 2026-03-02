module pipelined_alu_3stage_tb;

reg clk;
reg reset;
reg [15:0] A;
reg [15:0] B;
reg [3:0] opcode;

wire [15:0] result;
wire zero;
wire carry;
wire sign;
wire overflow;

pipelined_alu_3stage uut(clk,reset,A,B,opcode,result,zero,carry,sign,overflow);

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,pipelined_alu_3stage_tb);

clk=0;
reset=1;
#10;
reset=0;

A=16'b0000000000001010;
B=16'b0000000000000101;
opcode=4'b0000;
#10;

A=16'b0000000000010100;
B=16'b0000000000000101;
opcode=4'b0001;
#10;

A=16'b1111000011110000;
B=16'b0000111100001111;
opcode=4'b0010;
#10;

end

always #5 clk=~clk;

endmodule
