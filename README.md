# Cache_Memory_Verilog_HDL

##  Overview
This project implements a direct-mapped cache memory using Verilog. It supports read and write operations, cache hit detection, and simulates behavior using a detailed testbench.

## Features
- 16 cache lines with 4-word blocks (16 × 4 structure)
- Tag, index, and offset address breakdown
- Cache Hit/Miss logic
- Read/Write enable with `read_write` control
- Waveform output and simulation with `$monitor` debugging

## How It Works

- **Write operation**: On a cache miss or hit, writes `data_in` into the cache at the calculated index and offset.
- **Read operation**: On a cache hit, reads `data_out` from the cache using the given index/offset.
- **Tag matching**: Valid bits and tag comparisons determine hit or miss.

## Technologies Used
- Verilog HDL
- Xilinx Vivado for Simulation & Waveform view

## Files Included
- `Cache_Mmeory_New.v` - The main design verilog code for the cache memory
- `testbench.v` - The required testbench for the written desgin code
- `README.md` – This documentation

## 👨‍💻 Author
Srikanth Muthuvel Ganthimathi

## 📜 License

This project is for educational and research purposes.
You may modify or extend the design freely.

