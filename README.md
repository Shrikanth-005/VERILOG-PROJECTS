# PS/2 Keyboard Scan Code to ASCII Converter using FSM

This project implements a PS/2 keyboard controller using Verilog HDL.
It decodes keyboard scan codes using a finite state machine (FSM) and
converts valid key press events into ASCII values.

## Files
- `ps2_keyboard_controller.sv` – Keyboard controller (FSM-based)
- `tb_keyboard_controller.sv`  – Testbench for verification

## Features
- FSM-based make/break detection
- Parity checking for scan code validation
- Scan code to ASCII conversion
- Verilog HDL implementation
- Testbench with waveform generation

## Simulation
The design was verified using a Verilog testbench and waveform
analysis (`dump.vcd`) in EDA Playground.

## Author
Shrikanth N
