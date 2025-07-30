module testbench;
    reg clk;
    reg reset;
    reg [31:0] address;
    reg [31:0] data_in;
    reg read_write; // 1 = Write, 0 = Read
    wire [31:0] data_out;
    wire hit;

    // Instantiate the cache memory module
    Cache_Memory_New uut (
        .clk(clk),
        .reset(reset),
        .address(address),
        .data_in(data_in),
        .read_write(read_write),
        .data_out(data_out),
        .hit(hit)
    );

    // Generate clock signal
    always #5 clk = ~clk; // 10 ns clock period

    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        address = 0;
        data_in = 0;
        read_write = 0;

        // Step 1: Reset the cache
        #10 reset = 0;

        // Step 2: Write to address 0x10
        #10 address = 32'h10; data_in = 32'hDEADBEEF; read_write = 1;

        // Step 3: Write to address 0x20
        #10 address = 32'h20; data_in = 32'hCAFEBABE; read_write = 1;

        // Step 4: Read from address 0x10 (Cache Hit expected)
        #10 address = 32'h10; read_write = 0;

        // Step 5: Read from address 0x30 (Cache Miss expected)
        #10 address = 32'h30; read_write = 0;

        // Step 6: Read from address 0x20 (Cache Hit expected)
        #10 address = 32'h20; read_write = 0;

        // Step 7: Write to address 0x30
        #10 address = 32'h30; data_in = 32'h12345678; read_write = 1;

        // Step 8: Read from address 0x30 (Cache Hit expected after the write)
        #10 address = 32'h30; read_write = 0;

        // Step 9: End simulation
        #50 $finish;
    end

    // Generate waveforms for debugging
    initial begin
        $dumpfile("simulation.vcd"); // Name of the VCD file for waveform
        $dumpvars(0, testbench);     // Dump all variables in this module
    end

    // Optional: Display results for debugging
    initial begin
        $monitor("Time: %0t | Address: %h | Data In: %h | Data Out: %h | Read/Write: %b | Hit: %b",
                 $time, address, data_in, data_out, read_write, hit);
    end
endmodule
