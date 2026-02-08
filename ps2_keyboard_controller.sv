module keyboard_controller(
    input wire clk,
    input wire [8:0] scan_code_p,
    input wire valid,
    output reg [7:0] ascii,
    output reg ascii_valid
);

parameter IDLE   = 2'b00;
parameter MAKE   = 2'b01;
parameter BREAK  = 2'b10;
parameter OUTPUT = 2'b11;

reg [1:0] state, next_state;
wire [7:0] scan_code;
wire parity;
wire parity_ok;

assign scan_code = scan_code_p[7:0];
assign parity    = scan_code_p[8];
assign parity_ok = (^scan_code ^ parity);

always @(posedge clk) begin
    state <= next_state;
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (valid && parity_ok && scan_code == 8'hF0)
                next_state = BREAK;
            else if (valid && parity_ok)
                next_state = MAKE;
        end

        MAKE:   next_state = OUTPUT;
        BREAK:  next_state = IDLE;
        OUTPUT: next_state = IDLE;
        default: next_state = IDLE;
    endcase
end

always @(posedge clk) begin
    ascii_valid <= 1'b0;
    if (state == MAKE && parity_ok) begin
        case (scan_code)
            8'h1C: ascii <= 8'h41; // A
            8'h32: ascii <= 8'h42; // B
            8'h21: ascii <= 8'h43; // C
            8'h23: ascii <= 8'h44; // D
            default: ascii <= 8'h00;
        endcase
        ascii_valid <= 1'b1;
    end
end

endmodule
