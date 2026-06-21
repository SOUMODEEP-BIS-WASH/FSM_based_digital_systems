# FSM ALU Register Counter Combo (Parametrized)

## Overview

This project implements a **parameterized FSM-based digital system** combining multiple hardware components into a single datapath.

The design integrates:

* Arithmetic Logic Unit (ALU)
* Status Flag Generator
* Parameterized Registers
* Parameterized Up Counter
* FSM Controller

This project demonstrates how multiple reusable modules can be combined to create a more complete digital system.

---

## Problem Statement

Design an FSM-controlled digital system that:

* Accepts operands and opcode inputs
* Performs ALU operations
* Stores intermediate results using registers
* Uses a counter for operation tracking
* Generates status flags for control decisions

---

## Architecture

The design consists of the following blocks:

### 1. ALU with Status Flags

Performs arithmetic and logical operations and generates status signals.

Outputs:

* Result
* Carry
* Zero
* Sign
* Overflow

Supported operations:

| Opcode | Operation   |
| ------ | ----------- |
| 00     | Addition    |
| 01     | Subtraction |
| 10     | Bitwise AND |
| 11     | Bitwise OR  |

---

### 2. Parameterized Register Blocks

Registers store:

* Operand A
* Operand B
* Opcode
* ALU output

This enables staged processing across FSM states.

---

### 3. Parameterized Up Counter

A reusable counter module tracks system operations.

Functions:

* Reset
* Preset
* Increment
* Hold

Counter width is configurable using parameters.

---

### 4. FSM Controller

The FSM controls system execution.

States:

* FETCH
* EXECUTE
* STORE
* FLAGS

---

## Inputs

* **A [3:0]** → Operand A
* **B [3:0]** → Operand B
* **S [1:0]** → Opcode
* **clk** → Clock signal
* **rst** → Reset signal

---

## Outputs

* **Y [3:0]** → ALU output
* **carry_flag** → Carry flag
* **zero_flag** → Zero flag
* **sign_flag** → Sign flag
* **ov_flag** → Overflow flag
* **operations_flag** → Indicates operation completion

---

## FSM Design

### FETCH

* Load operands and opcode into registers

---

### EXECUTE

* Perform ALU computation
* Update counter enable logic

---

### STORE

* Store ALU output

---

### FLAGS

* Update status flags
* Check operation completion

---

## State Transition Flow

```text
FETCH → EXECUTE → STORE → FLAGS → FETCH
```

---

## Counter Behavior

The system uses a 2-bit counter to track operations.

Counter increments during execution when:

```text
alu_out != Y
```

Operation completion occurs when:

```text
count == 2'b11
```

At this point:

```text
operations_flag = 1
```

---

## Data Flow

```text
Inputs → Registers → ALU → Output Register
                  ↓
               Counter
                  ↓
            FSM Controller
```

---

## Parameterization

This design uses parameterized modules for flexibility.

Example:

```verilog
module up_counter #(parameter N = 4)
```

Benefits:

* Reusable design
* Scalable architecture
* Easy module customization

---

## Simulation

### Compile

```bash
iverilog -o combo_sim ALU_with_status_flags.v N_bit_register.v up_counter.v FSM_combo.v tb.v
```

### Run

```bash
vvp combo_sim
```

### View Waveform

```bash
gtkwave tb.vcd
```

Simulation tools used:

* Verilog HDL
* Icarus Verilog
* GTKWave

---

## Expected Behavior

1. System captures input operands
2. ALU executes selected operation
3. Result is stored
4. Counter tracks operations
5. Status flags update
6. Completion flag asserts after counter reaches maximum

Example:

* Counter progresses from 00 → 01 → 10 → 11
* After reaching 11, operations complete

---

## Learning Outcomes

This project helps in understanding:

* FSM-controlled datapaths
* ALU design with status flags
* Register-based staging
* Counter integration
* Parameterized module design
* Digital system integration
