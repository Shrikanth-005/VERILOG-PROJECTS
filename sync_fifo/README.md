# Synchronous FIFO (Verilog)

This project implements a parameterized synchronous FIFO using Verilog HDL.
The FIFO supports configurable data width and depth, with full and empty
flag generation based on read and write pointers.

## Features
- Parameterized data width and depth
- Synchronous read and write operations
- Full and empty flag logic
- Circular buffer implementation
- Suitable for single-clock domain designs

## Files
- `fifo_sync.v`      – FIFO design module
- `fifo_sync_tb.v`   – Testbench for functional verification

## Simulation
The FIFO behavior is verified using a Verilog testbench.
Waveforms are generated using `$dumpfile` and `$dumpvars`.

## Author
Shrikanth N M
