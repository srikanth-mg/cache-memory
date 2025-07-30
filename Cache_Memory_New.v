module Cache_Memory_New (
    input wire clk,
    input wire reset,
    input wire [31:0] address,
    input wire [31:0] data_in,
    input wire read_write, // 1 = Write, 0 = Read
    output reg [31:0] data_out,
    output reg hit
);
    parameter CACHE_LINES = 16;
    parameter BLOCK_SIZE = 4;
    localparam INDEX_BITS = 4;
    localparam TAG_BITS = 32 - INDEX_BITS - 2;

    reg [31:0] data_array [0:CACHE_LINES-1][0:BLOCK_SIZE-1];
    reg [TAG_BITS-1:0] tag_array [0:CACHE_LINES-1];
    reg valid_array [0:CACHE_LINES-1];

    wire [INDEX_BITS-1:0] index = address[INDEX_BITS+1:2];
    wire [TAG_BITS-1:0] tag = address[31:INDEX_BITS+2];
    wire [1:0] offset = address[1:0];

    integer i, j;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < CACHE_LINES; i = i + 1) begin
                valid_array[i] <= 0;
                tag_array[i] <= 0;
                for (j = 0; j < BLOCK_SIZE; j = j + 1) begin
                    data_array[i][j] <= 0;
                end
            end
            hit <= 0;
            data_out <= 0;
        end else begin
            if (valid_array[index] && (tag_array[index] == tag)) begin
                hit <= 1;
                if (read_write == 0) begin
                    data_out <= data_array[index][offset];
                end else begin
                    data_array[index][offset] <= data_in;
                end
            end else begin
                hit <= 0;
                if (read_write == 1) begin
                    tag_array[index] <= tag;
                    valid_array[index] <= 1;
                    data_array[index][offset] <= data_in;
                end
            end
        end
    end
endmodule
