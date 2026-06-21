# Microcontroller FSM with Memory

## Overview

This project implements a **memory-driven microcontroller architecture** using Verilog HDL.

The system integrates:

* Instruction Memory
* FSM Controller
* Arithmetic Logic Unit (ALU)
* Register Pipeline
* Status Flag Logic

Unlike previous projects where instructions were manually managed, this design introduces a dedicated instruction memory that automatically supplies operands and opcodes to the controller.

This creates a more realistic embedded-system architecture where stored instructions drive execution.

---

## Problem Statement

Design a microcontroller system that:

* Reads operands and opcodes from instruction memory
* Executes ALU operations using FSM control
* Updates status flags
* Continues processing until all memory instructions are completed

---

## Architecture

The design consists of the following blocks:

### 1. Instruction Memory

The instruction memory stores:

* Operand A values
* Operand B values
* Opcodes

The memory module automatically cycles through all stored instructions.

Stored opcodes:

| Opcode | Operation   |
| ------ | ----------- |
| 00     | Addition    |
| 01     | Subtraction |
| 10     | Bitwise AND |
| 11     | Bitwise OR  |

Example operand pairs:

* 0001, 1010
* 0010, 1001
* 0100, 1100
* 1000, 0011

---

### 2. FSM Controller

The FSM controls execution flow.

States:

* FETCH
* EXECUTE
* STORE
* FLAGS

The FSM transitions through these stages for every instruction.

---

### 3. Register Blocks

Registers store:

* Operand A
* Operand B
* Opcode
* ALU output

This provides pipelined execution.

---

### 4. ALU

Performs arithmetic and logical operations.

Supported operations:

| Opcode | Operation   |
| ------ | ----------- |
| 00     | Addition    |
| 01     | Subtraction |
| 10     | Bitwise AND |
| 11     | Bitwise OR  |

---

### 5. Status Flags

The ALU generates:

* Carry Flag
* Zero Flag
* Sign Flag
* Overflow Flag

These flags are updated after execution.

---

## Inputs

* **clk** → Clock signal
* **rst** → Reset signal

---

## Outputs

* **Y [3:0]** → ALU output
* **carry_flag** → Carry status
* **zero_flag** → Zero status
* **sign_flag** → Sign status
* **ov_flag** → Overflow status
* **operations_flag** → Indicates operation completion
* **done** → Indicates all instruction memory entries processed

---

## FSM Design

### States

The controller uses 4 states:

* FETCH
* EXECUTE
* STORE
* FLAGS

---

## State Descriptions

### FETCH

* Read operands and opcode from instruction memory
* Load registers

---

### EXECUTE

* Perform ALU computation

---

### STORE

* Store ALU output

---

### FLAGS

* Update ALU flags
* Determine completion status

---

## State Transition Flow

```text id="3r89wn"
FETCH → EXECUTE → STORE → FLAGS → FETCH
```

Transition to FLAGS occurs when:

* Carry is set
* Zero is set
* Sign is set
* Overflow occurs
* All instructions are completed

---

## Instruction Memory Operation

The instruction memory maintains:

* Operand counter
* Opcode counter

Execution order:

1. Read opcode
2. Read operand pair
3. Execute operation
4. Move to next instruction

When all combinations are processed:

```text id="19f3wd"
done = 1
```

---

## Data Flow

```text id="7my7la"
Instruction Memory
        ↓
   FSM Controller
        ↓
       ALU
        ↓
 Output + Status Flags
```

---

## Simulation

### Compile

```bash id="c8s0k2"
iverilog -o fsm_mem_sim ALU_with_status_flags.v instruction_memory.v N_bit_register.v FSM_with_memory.v up_counter.v tb.v
```

### Run

```bash id="n50e6u"
vvp fsm_mem_sim
```

### View Waveform

```bash id="6j6x8u"
gtkwave tb.vcd
```

Simulation tools used:

* Verilog HDL
* Icarus Verilog
* GTKWave

---

## Expected Behavior

1. Instruction memory provides operands and opcode
2. FSM fetches instruction
3. ALU executes selected operation
4. Output is generated
5. Status flags update
6. System moves to next instruction

After all instructions are processed:

```text id="w40e74"
done = 1
```

---

## Learning Outcomes

This project helps in understanding:

* Memory-driven processor design
* Instruction sequencing
* FSM control logic
* ALU operations
* Register pipelining
* Status flag generation
* Embedded controller architecture
