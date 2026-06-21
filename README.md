# Verilog Digital Design Projects Repository

## Overview
This repository contains **15 Verilog HDL projects** covering digital design concepts ranging from finite state machines and arithmetic units to processor-like architectures and real-time systems.

The projects progressively move from:

- FSM fundamentals  
- ALU and arithmetic systems  
- Handshake protocols  
- Processor and controller design  
- Embedded-style architectures  
- Real-time digital systems  

These projects were developed to strengthen practical understanding of:

- RTL design  
- Combinational and sequential logic  
- FSM-based architecture design  
- Datapath and control path interaction  
- Hardware verification using testbenches  

---

# Repository Structure

```text
├── Parametrized_FSM_Generator/
├── FSM_Based_Simple_CPU/
├── FSM_CPU_with_Memory/
├── Microcontroller_Unit/
├── Microcontroller_with_Program_Counter/
├── Microcontroller_FSM_with_Memory/
├── Pipelined_FSM_ALU/
├── FSM_ALU_Reg_Counter_Combo/
├── Conditional_FSM/
├── Dual_FSM_Handshake/
├── CLA_Carry_Alert_FSM/
├── Vending_Machines/
├── VM_with_Self_Checking_Testbench/
├── Digital_Clock_with_Alarm/
├── Real_Time_Clock/
└── README.md
```

---

# Projects Included

---

## Project 01: Parametrized FSM Generator
A configurable FSM generator capable of producing customizable state machines using parameters.

### Features
- Parameterized number of states
- Flexible state transitions
- Reusable FSM template

### Concepts Covered
- Parameterized RTL design  
- Generic FSM modeling  
- Reusable modules  

---

## Project 02: FSM Based Simple CPU
A simple CPU architecture controlled entirely using FSM logic.

### Features
- Instruction fetch
- Decode
- Execute cycle
- FSM-based control path

### Concepts Covered
- CPU fundamentals  
- Control unit design  
- Instruction cycle  

---

## Project 03: FSM CPU with Memory
Extends the simple CPU by integrating memory.

### Features
- Memory interface
- Instruction/data storage
- FSM-driven execution

### Concepts Covered
- CPU-memory interaction  
- Memory access cycles  
- FSM-controlled computation  

---

## Project 04: Microcontroller Unit
Basic microcontroller architecture integrating computational and control modules.

### Features
- Processing unit
- Basic control logic
- Embedded system fundamentals

### Concepts Covered
- MCU architecture  
- Datapath + control path  
- Embedded hardware design  

---

## Project 05: Microcontroller with Program Counter
Adds program counter logic to enable sequential instruction execution.

### Features
- Program counter
- Instruction sequencing
- Step-by-step execution flow

### Concepts Covered
- Program control  
- Instruction sequencing  
- Counter-driven execution  

---

## Project 06: Microcontroller FSM with Memory
Advanced microcontroller implementation combining FSM and memory subsystems.

### Features
- FSM-based control
- Program/data memory
- Execution flow management

### Concepts Covered
- Embedded controller design  
- Memory-integrated FSM systems  
- Control-heavy architectures  

---

## Project 07: Pipelined FSM ALU
A 3-stage ALU system controlled by an FSM.

### Features
- FETCH stage
- EXECUTE stage
- WRITEBACK stage
- Arithmetic and logic operations

### Concepts Covered
- Pipeline registers  
- FSM-controlled execution  
- ALU datapath design  

---

## Project 08: FSM ALU Register Counter Combo (Parameterized)
Complex ALU architecture integrating FSM, registers, counters, and status logic.

### Features
- Carry flag
- Zero flag
- Sign flag
- Overflow flag
- Operation counter

### Concepts Covered
- Modular design  
- Parameterized blocks  
- Multi-module integration  

---

## Project 09: Conditional FSM
FSM-based ALU controller with conditional state transitions based on ALU status flags.

### Features
- Dynamic transitions
- Status-driven branching
- Conditional execution

### Concepts Covered
- Control logic  
- Conditional FSM behavior  

---

## Project 10: Dual FSM Handshake
Implements handshake communication between two FSMs.

### Features
- Data controller FSM
- ALU controller FSM
- Handshake signaling
- Coordinated execution

### Concepts Covered
- Inter-FSM communication  
- Hardware handshaking  
- Synchronization  

---

## Project 11: CLA Carry Alert FSM
Integration of Carry Look-Ahead Adder with FSM-based carry monitoring.

### Features
- 4-bit CLA
- Carry alert FSM
- Registered outputs

### Concepts Covered
- Fast arithmetic design  
- Carry logic  
- Event detection  

---

## Project 12: Vending Machines
Multiple vending machine implementations with increasing complexity.

### Variants
- VM1 → Single coin input, single item  
- VM2 → Multi-coin, single item  
- VM3 → Multi-item selection  
- VM4 → Refund-enabled vending machine  

### Concepts Covered
- Transaction modeling  
- FSM transitions  
- Decision logic  

---

## Project 13: Vending Machine with Self-Checking Testbench
Enhanced vending machine with automated verification.

### Features
- Self-checking testbench
- Pass/fail reporting
- Timeout reset behavior

### Concepts Covered
- Verification methodology  
- Automated testing  
- Testbench design  

---

## Project 14: Digital Clock with Alarm
Digital clock implementation with configurable alarm.

### Features
- Hour/minute/second counters
- Alarm triggering
- Real-time monitoring

### Concepts Covered
- Clock design  
- Counter logic  
- Alarm detection  

---

## Project 15: Real-Time Clock (RTC)
24-hour real-time clock with 7-segment display output.

### Features
- Hours, minutes, seconds tracking
- 24-hour format
- 7-segment encoding
- Cascaded counters

### Concepts Covered
- Timekeeping logic  
- Counter hierarchy  
- Display decoding  

---

# Tools Used
- Verilog HDL  
- Icarus Verilog / ModelSim / Vivado  
- GTKWave  

---

# Core Concepts Covered

## Digital Logic
- Combinational Logic  
- Sequential Logic  
- Registers  
- Counters  

## FSM Design
- Moore FSM  
- Mealy FSM  
- Conditional FSM  
- Multi-FSM Systems  

## Processor Design
- CPU Design  
- Program Counter  
- Microcontroller Architecture  
- Memory Interface  

## Arithmetic Systems
- ALU Design  
- Carry Look-Ahead Adders  

## Verification
- Testbench Writing  
- Self-Checking Testbenches  
- Waveform Debugging  

---

# Learning Outcomes
These projects help build practical expertise in:

- Writing synthesizable Verilog  
- Designing modular digital systems  
- Implementing FSM-driven architectures  
- Understanding processor internals  
- Verifying hardware using simulations  

---

---

# Conclusion
This repository represents a complete progression from FSM fundamentals to processor-inspired architectures and real-time digital systems. It serves as a strong learning resource for RTL design, digital system design, and hardware verification.
