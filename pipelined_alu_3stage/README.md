# 3-Stage Pipelined ALU (Verilog)

This project implements a 16-bit 3-stage pipelined ALU using Verilog HDL.

The design separates computation into three pipeline stages:

Stage 1 – Input Register Stage  
Stage 2 – ALU Execution Stage  
Stage 3 – Output & Flag Generation Stage  

Supported Operations:
- ADD
- SUB
- AND
- OR
- XOR

Features:
- Fully synchronous pipeline
- Registered inputs and outputs
- Carry and overflow detection
- Zero and sign flag generation
- Improved throughput compared to non-pipelined ALU

Pipeline Latency:
3 clock cycles from input to valid output.
