module fifo_sync_tb;

    localparam DATA_WIDTH = 8;
    localparam DEPTH = 32;

    reg                   clk;
    reg                   reset;
    reg                   write_en;
    reg                   read_en;
    reg  [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire                  empty;
    wire                  full;

    fifo_sync #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(DEPTH)
    ) dut (
        .clk(clk),
        .reset(reset),
        .write_en(write_en),
        .read_en(read_en),
        .data_in(data_in),
        .data_out(data_out),
        .empty(empty),
        .full(full)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;

        clk = 0;
        reset = 1;
        write_en = 0;
        read_en = 0;
        data_in = 0;

        #10;
        reset = 0;

        repeat (5) begin
            @(posedge clk);
            write_en = 1;
            data_in = data_in + 8'd10;
        end

        @(posedge clk);
        write_en = 0;

        repeat (3) begin
            @(posedge clk);
            read_en = 1;
        end

        @(posedge clk);
        read_en = 0;

        repeat (4) begin
            @(posedge clk);
            write_en = 1;
            data_in = data_in + 8'd5;
        end

        @(posedge clk);
        write_en = 0;

        while (!empty) begin
            @(posedge clk);
            read_en = 1;
        end

        @(posedge clk);
        read_en = 0;

        #20;
        $finish;
    end

endmodule
