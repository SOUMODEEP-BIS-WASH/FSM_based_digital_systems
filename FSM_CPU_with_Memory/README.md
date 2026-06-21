# FSM CPU with Memory

## Overview

This project extends the FSM-based simple CPU by integrating a dedicated **data memory block**.

The CPU not only executes instructions using an FSM-controlled datapath but also stores ALU results into memory locations during execution. This introduces basic processor-memory interaction similar to real computer architectures.

The design includes:

* Instruction Memory
* Data Memory
* ALU with Status Flags
* Program Counter
* Memory Counter
* FSM-based Control Unit

This project demonstrates how computation and storage are coordinated in a CPU using finite state machines.

---

## Problem Statement

Design an FSM-controlled CPU that:

* Fetches instructions from instruction memory
* Executes arithmetic and logical operations
* Stores ALU results into data memory
* Updates status flags
* Supports conditional branching
* Tracks memory storage completion

---

## Architecture

The system consists of the following major blocks:

### 1. Instruction Memory

Stores 8 instructions of 10 bits each.

Instruction format:

* Bits `[9:8]` → Operation Select
* Bits `[7:4]` → Operand A
* Bits `[3:0]` → Operand B

---

### 2. Data Memory

A dedicated memory block stores ALU results.

Memory specifications:

* 6 memory locations
* Each location stores 4-bit data

```text id="3czq4p"
mem[0] ... mem[5]
```

Each computed ALU result is written into memory during execution.

---

### 3. Register Blocks

Pipeline registers store:

* Operand A
* Operand B
* ALU operation select
* ALU output

Parameterized register modules are used.

---

### 4. ALU

The ALU performs arithmetic and logical operations.

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

* **Carry Flag**
* **Zero Flag**
* **Sign Flag**
* **Overflow Flag**

These flags are used for control and branching decisions.

---

### 6. Program Counter (PC)

Tracks instruction execution.

Range:

```text id="7ot6h2"
0 → 7
```

Used to fetch instructions sequentially or through branching.

---

### 7. Memory Counter (MC)

Tracks current memory write location.

Range:

```text id="v2e8p3"
0 → 5
```

Each STORE operation writes ALU output into:

```text id="op3ah7"
mem[MC]
```

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
* **operations_flag** → Instruction completion flag
* **mem_flag** → Memory completion flag

---

## FSM Design

### States

The CPU FSM consists of 4 major states:

* FETCH
* EXECUTE
* STORE
* FLAGS

---

### State Descriptions

#### FETCH

* Fetch instruction from instruction memory
* Load operands into registers

---

#### EXECUTE

* Perform ALU computation

---

#### STORE

* Store ALU output
* Write result into data memory
* Increment memory counter

---

#### FLAGS

* Update ALU flags
* Handle branching logic
* Update program counter

---

## State Transition Flow

```text id="6ue90d"
FETCH → EXECUTE → STORE → FLAGS → FETCH
```

Transitions depend on:

* Carry flag
* Zero flag
* Sign flag
* Overflow flag
* Program counter status
* Memory counter status

---

## Memory Operation

During STORE stage:

```text id="h35cw4"
ALU Output → Data Memory
```

Example:

* First result → mem[0]
* Second result → mem[1]
* ...
* Sixth result → mem[5]

After reaching the final memory location:

* Memory counter resets
* `mem_flag` becomes active

---

## Branching Logic

Conditional branching is supported using ALU flags.

Branch conditions:

* Branch on Zero
* Branch on Carry
* Branch on Sign

Possible PC jumps:

* +1
* +2
* +3
* +4

This enables simple control-flow execution.

---

## Simulation

### Compile

```bash id="1m9vcz"
iverilog -o cpu_mem_sim ALU_with_status_flags.v N_bit_register.v FSM_with_memory.v tb.v
```

### Run

```bash id="0g1g0f"
vvp cpu_mem_sim
```

### View Waveform

```bash id="mtyc2w"
gtkwave mem1.vcd
```

Simulation tools used:

* Verilog HDL
* Icarus Verilog
* GTKWave

---

## Expected Behavior

1. CPU starts in FETCH state
2. Instruction is loaded
3. ALU executes operation
4. Result is stored in output register
5. Result is written to memory
6. Memory counter increments
7. Flags are updated
8. Program counter moves to next instruction or branches

The cycle continues until:

* Instruction execution completes
* Memory fills up

---

## Learning Outcomes

This project helps in understanding:

* FSM-based CPU design
* Processor-memory interaction
* Data memory operations
* ALU flag generation
* Conditional branching
* Memory addressing
* Register pipelining
* Basic computer architecture concepts
