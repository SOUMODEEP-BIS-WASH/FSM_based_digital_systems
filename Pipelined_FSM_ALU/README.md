# Pipelined FSM ALU

## Overview

This project implements a **multi-stage FSM-controlled ALU** using Verilog HDL.

The design combines:

* Finite State Machine (FSM)
* Pipeline-style registers
* Arithmetic Logic Unit (ALU)
* Multi-cycle execution flow

The system divides ALU computation into three stages:

1. Fetch
2. Execute
3. Writeback

This improves architectural clarity by separating computation into well-defined stages.

> **Note:** Although pipeline registers are used, this is **not a true fully pipelined ALU**, since new inputs are only accepted during the FETCH state.

---

## Problem Statement

Design an ALU system that:

* Accepts operands and opcode
* Processes operations using staged execution
* Separates instruction processing into multiple FSM states
* Produces output after computation completes

---

## Architecture

The design consists of:

### 1. Input Registers

Stores:

* Operand A
* Operand B
* Opcode

These values are captured during FETCH.

---

### 2. ALU Block

Performs arithmetic and logic operations.

Supported operations:

| Opcode | Operation   |
| ------ | ----------- |
| 00     | Addition    |
| 01     | Subtraction |
| 10     | Bitwise AND |
| 11     | Bitwise OR  |

---

### 3. Pipeline Registers

Intermediate register stages store:

* Input operands
* Opcode
* ALU result

This mimics pipeline behavior.

---

### 4. FSM Controller

Controls progression through execution stages.

States:

* FETCH
* EXECUTE
* WRITEBACK

---

## Inputs

* **A [3:0]** → Operand A
* **B [3:0]** → Operand B
* **S [1:0]** → Opcode
* **clk** → Clock
* **rst** → Reset

---

## Output

* **Y [3:0]** → Final ALU output

---

## FSM Design

### State Descriptions

### FETCH

Capture operands and opcode.

```text
A_in <= A
B_in <= B
op_code <= S
```

---

### EXECUTE

Perform ALU computation and store result.

```text
alu_result <= alu_out
```

---

### WRITEBACK

Write computed result to output.

```text
Y <= alu_result
```

---

## State Transition Flow

```text
FETCH → EXECUTE → WRITEBACK → FETCH
```

---

## Data Flow

```text
Input → Fetch Register → ALU → Result Register → Output
```

---

## Pipeline Behavior

This design uses pipeline-style registers but is not fully pipelined.

### Limitation

New inputs are sampled only during FETCH.

This means:

* Current operation must complete all 3 stages
* Only then can the next input be accepted

Therefore throughput is:

* **1 output every 3 cycles**

instead of true pipelining:

* **1 output every cycle (after pipeline fill)**

---

## Simulation

### Compile

```bash
iverilog -o pipeline_sim pipelined_FSM.v pipelined_tb.v
```

### Run

```bash
vvp pipeline_sim
```

### View Waveform

```bash
gtkwave pipelined_tb.vcd
```

Simulation tools used:

* Verilog HDL
* Icarus Verilog
* GTKWave

---

## Expected Behavior

Example Input:

```text
A = 1001
B = 0110
S = 00
```

Operation:

```text
Addition
```

Execution timeline:

* Cycle 1 → FETCH
* Cycle 2 → EXECUTE
* Cycle 3 → WRITEBACK

Output:

```text
Y = 1111
```

---

## Learning Outcomes

This project helps in understanding:

* FSM-based datapath control
* Multi-cycle ALU design
* Pipeline register usage
* Execution staging
* Differences between staged design and true pipelining
* Processor datapath fundamentals
