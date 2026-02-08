module fifo_sync #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 32,
    localparam ADDR_WIDTH = $clog2(DEPTH)
)(
    input  wire                  clk,
    input  wire                  reset,
    input  wire                  write_en,
    input  wire                  read_en,
    input  wire [DATA_WIDTH-1:0] data_in,
    output wire [DATA_WIDTH-1:0] data_out,
    output wire                  empty,
    output wire                  full
);

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    reg [ADDR_WIDTH-1:0] wr_ptr;
    reg [ADDR_WIDTH-1:0] rd_ptr;

    reg [DATA_WIDTH-1:0] data_out_reg;

    assign data_out = data_out_reg;

    wire [ADDR_WIDTH-1:0] next_wr_ptr;
    assign next_wr_ptr = (wr_ptr == DEPTH-1) ? 0 : wr_ptr + 1;

    assign empty = (wr_ptr == rd_ptr);
    assign full  = (next_wr_ptr == rd_ptr);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            data_out_reg <= 0;
        end
        else begin

            if (write_en && !full) begin
                mem[wr_ptr] <= data_in;
                wr_ptr <= next_wr_ptr;
            end

            if (read_en && !empty) begin
                data_out_reg <= mem[rd_ptr];
                rd_ptr <= (rd_ptr == DEPTH-1) ? 0 : rd_ptr + 1;
            end

        end
    end

endmodule
