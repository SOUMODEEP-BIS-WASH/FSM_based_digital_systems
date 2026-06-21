# FSM Based Simple CPU

## Overview

This project implements a **simple FSM-controlled CPU** in Verilog HDL.

The CPU executes instructions stored in an internal instruction memory using a finite state machine (FSM) to control the instruction cycle. The design includes:

* Instruction Fetch
* Instruction Execute
* Result Store
* Status Flag Update

An ALU performs arithmetic and logical operations while generating status flags such as:

* Carry
* Zero
* Sign
* Overflow

This project demonstrates how FSMs are used in processor control units.

---

## Problem Statement

Design a simple CPU architecture controlled by an FSM that:

* Fetches instructions from memory
* Decodes ALU operands and operation type
* Executes arithmetic or logical operations
* Stores output results
* Updates status flags
* Supports simple conditional branching using flags

---

## Architecture

The CPU consists of the following major blocks:

### 1. Instruction Memory

Stores 8 instructions of 10 bits each.

Instruction format:

* Bits `[9:8]` → ALU operation select
* Bits `[7:4]` → Operand A
* Bits `[3:0]` → Operand B

---

### 2. Register Blocks

Pipeline registers store:

* Operand A
* Operand B
* Operation Select
* ALU Output

Parameterized register modules are used for storage.

---

### 3. ALU

The ALU performs arithmetic and logic operations.

Supported operations:

| Opcode | Operation   |
| ------ | ----------- |
| 00     | Addition    |
| 01     | Subtraction |
| 10     | Bitwise AND |
| 11     | Bitwise OR  |

---

### 4. Status Flags

The ALU generates:

* **Carry Flag** → Indicates carry/borrow
* **Zero Flag** → Result equals zero
* **Sign Flag** → MSB of result
* **Overflow Flag** → Signed arithmetic overflow

---

### 5. Program Counter (PC)

Tracks the current instruction being executed.

The PC updates sequentially or conditionally depending on:

* ALU operation
* Status flags
* Branch conditions

---

## Inputs

* **clk** → Clock signal
* **rst** → Reset signal

---

## Outputs

* **Y [3:0]** → ALU result
* **carry_flag** → Carry status
* **zero_flag** → Zero status
* **sign_flag** → Sign status
* **ov_flag** → Overflow status
* **operations_flag** → Indicates completion of instruction sequence

---

## FSM Design

### States

The CPU FSM consists of 4 major states:

* **FETCH**
* **EXECUTE**
* **STORE**
* **FLAGS**

---

### State Descriptions

#### FETCH

* Read instruction from memory
* Load operands into registers
* Load operation select bits

---

#### EXECUTE

* ALU processes operands
* Operation is performed

---

#### STORE

* Store ALU result
* Update output register
* Determine next transition

---

#### FLAGS

* Update status flags
* Perform conditional branching
* Update program counter

---

## State Transition Flow

```text
FETCH → EXECUTE → STORE → FLAGS → FETCH
```

Under certain conditions:

* CPU may directly return to FETCH after STORE

Conditions depend on:

* Carry flag
* Zero flag
* Sign flag
* Overflow flag
* End of instruction memory

---

## Branching Logic

The CPU supports conditional branching based on ALU status flags.

Branch conditions:

* Branch on Zero
* Branch on Carry
* Branch on Sign

Depending on conditions, the PC may jump by:

* +1
* +2
* +3
* +4

This introduces basic control-flow behavior similar to real processors.

---

## Simulation

### Compile

```bash
iverilog -o cpu_sim ALU_with_status_flags.v N_bit_register.v FSM_with_memory.v tb.v
```

### Run

```bash
vvp cpu_sim
```

### View Waveform

```bash
gtkwave tb2.vcd
```

Simulation tools used:

* Verilog HDL
* Icarus Verilog
* GTKWave

---

## Expected Behavior

1. CPU starts in FETCH state after reset
2. Instruction is loaded from memory
3. Operands are sent to ALU
4. ALU performs operation
5. Result is stored in output register
6. Status flags are updated
7. Program counter moves to next instruction or branches

The cycle repeats until all instructions are processed.

---

## Learning Outcomes

This project helps in understanding:

* FSM-controlled CPU design
* Instruction execution cycles
* ALU implementation
* Status flag generation
* Conditional branching
* Program counter control
* Register pipelining
* Basic processor architecture
