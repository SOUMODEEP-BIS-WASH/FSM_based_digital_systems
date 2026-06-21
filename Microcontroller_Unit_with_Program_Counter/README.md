# Microcontroller with Program Counter

## Overview

This project implements a simplified **microcontroller architecture with program counter support** using Verilog HDL.

The design combines:

* FSM-based control logic
* Instruction memory
* Arithmetic Logic Unit (ALU)
* Program Counter (PC)
* Status flag generation

Unlike a simple controller, this design introduces a program counter to fetch and execute instructions sequentially, enabling processor-like execution flow.

This project demonstrates instruction sequencing and conditional branching using FSM-based control.

---

## Problem Statement

Design a microcontroller-style digital system that:

* Fetches instructions from instruction memory
* Executes ALU operations
* Tracks execution using a program counter
* Generates ALU status flags
* Supports conditional branching based on flags

---

## Architecture

The design consists of the following major blocks:

### 1. Instruction Memory

Stores 8 instructions, each 10 bits wide.

Instruction format:

* Bits `[9:8]` → Opcode
* Bits `[7:4]` → Operand A
* Bits `[3:0]` → Operand B

Instructions are fetched using the program counter.

---

### 2. Register Blocks

Registers are used to store:

* Operand A
* Operand B
* Opcode
* ALU output

These registers pipeline instruction execution.

---

### 3. ALU

Performs arithmetic and logical operations.

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

* **Carry Flag**
* **Zero Flag**
* **Sign Flag**
* **Overflow Flag**

These flags are used for control flow decisions.

---

### 5. Program Counter

The Program Counter (PC) tracks instruction execution.

Functions:

* Points to current instruction
* Increments after execution
* Supports conditional jumps

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
* **operations_flag** → Indicates completion of execution

---

## FSM Design

### States

The controller FSM contains 4 states:

* FETCH
* EXECUTE
* STORE
* FLAGS

---

## State Descriptions

### FETCH

* Fetch instruction from instruction memory
* Load operands and opcode into registers

---

### EXECUTE

* ALU performs selected operation

---

### STORE

* Store ALU result
* Update output
* Determine next transition

---

### FLAGS

* Update ALU flags
* Modify program counter based on branching condition

---

## State Transition Flow

```text id="bq3x4f"
FETCH → EXECUTE → STORE → FLAGS → FETCH
```

---

## Program Counter Operation

Normal execution:

```text id="k8d3mp"
PC = PC + 1
```

Conditional branching:

* If zero flag is asserted:

```text id="1ru7ny"
PC = PC + 2
```

Otherwise:

```text id="vk5a91"
PC = PC + 1
```

This creates basic branch behavior.

---

## Branching Logic

Branching is based on:

* Zero flag

If ALU result equals zero:

* Program counter jumps by 2

Otherwise:

* Continue sequential execution

This introduces simple decision-based execution.

---

## Simulation

### Compile

```bash id="7v0jdl"
iverilog -o pc_sim up_counter.v ALU_with_status_flags.v n_bit_reg.v FSM_with_memory.v tb.v
```

### Run

```bash id="nhmzfa"
vvp pc_sim
```

### View Waveform

```bash id="gyh9xy"
gtkwave tb1.vcd
```

Simulation tools used:

* Verilog HDL
* Icarus Verilog
* GTKWave

---

## Expected Behavior

1. System starts in FETCH state
2. Instruction is fetched using program counter
3. ALU executes selected operation
4. Result is stored
5. Status flags are updated
6. Program counter increments or branches

Example branch behavior:

* Zero result → Jump forward by 2 instructions
* Non-zero result → Continue sequentially

---

## Learning Outcomes

This project helps in understanding:

* Program counter design
* Instruction sequencing
* FSM-controlled processors
* ALU operations
* Status flag handling
* Conditional branching
* Basic processor control architecture
