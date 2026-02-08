module tb_keyboard_controller;

reg clk;
reg [8:0] scan_code_p;
reg valid;
wire [7:0] ascii;
wire ascii_valid;

keyboard_controller dut (
    .clk(clk),
    .scan_code_p(scan_code_p),
    .valid(valid),
    .ascii(ascii),
    .ascii_valid(ascii_valid)
);

always #5 clk = ~clk;

function calc_parity;
    input [7:0] data;
    begin
        calc_parity = ~(^data);
    end
endfunction

initial begin
    $dumpfile("dump.vcd");
    $dumpvars;

    clk = 0;
    valid = 0;
    scan_code_p = 9'h000;

    #10;
    scan_code_p = {calc_parity(8'h1C), 8'h1C};
    valid = 1;
    #10 valid = 0;

    #20;
    scan_code_p = {calc_parity(8'hF0), 8'hF0};
    valid = 1;
    #10;
    scan_code_p = {calc_parity(8'h1C), 8'h1C};
    #10 valid = 0;

    #20;
    scan_code_p = {calc_parity(8'h32), 8'h32};
    valid = 1;
    #10 valid = 0;

    #50 $finish;
end

endmodule
