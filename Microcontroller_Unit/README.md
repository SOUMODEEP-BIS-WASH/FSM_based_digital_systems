# Microcontroller Unit

## Overview

This project implements a simplified **Microcontroller Unit (MCU)** using Verilog HDL.

The design combines:

* FSM-based Controller
* Arithmetic Logic Unit (ALU)
* Register Storage Unit

The controller FSM manages the flow of data between the ALU and register block, enabling sequential execution of arithmetic and logical operations.

This project demonstrates how a microcontroller control unit coordinates:

* Fetching inputs
* Executing instructions
* Storing results

---

## Problem Statement

Design a microcontroller-style control unit that:

* Accepts input operands and opcode
* Controls ALU execution using an FSM
* Waits for ALU completion
* Stores ALU result into a register
* Signals operation completion

---

## Architecture

The design consists of 3 major blocks:

### 1. Controller FSM

The FSM acts as the control unit.

Responsibilities:

* Monitor start signal
* Load operands and opcode
* Enable ALU execution
* Enable register storage
* Control operation sequencing

---

### 2. ALU

Performs arithmetic and logical operations.

Supported operations:

| Opcode | Operation   |
| ------ | ----------- |
| 00     | Addition    |
| 01     | Subtraction |
| 10     | Bitwise AND |
| 11     | Bitwise OR  |

The ALU produces:

* Result output
* Completion signal (`alu_done`)

---

### 3. Register Unit

Stores the ALU output.

The register block:

* Captures result on clock edge
* Generates storage completion signal (`reg_done`)

---

## Inputs

* **start** → Starts operation
* **A [3:0]** → Operand A
* **B [3:0]** → Operand B
* **opcode [1:0]** → Operation select
* **clk** → Clock signal
* **rst** → Reset signal

---

## Outputs

* **Q [3:0]** → Final stored result
* **alu_out [3:0]** → ALU output
* **alu_done** → ALU execution complete
* **reg_done** → Register storage complete
* **alu_on** → ALU enable signal
* **reg_on** → Register enable signal

---

## FSM Design

### States

The controller FSM contains 5 states:

* S0 → IDLE
* S1 → FETCH OPCODE
* S2 → EXECUTE
* S3 → STORE
* S4 → DONE

---

## State Descriptions

### S0 — IDLE

* Wait for start signal
* System remains idle until operation begins

---

### S1 — FETCH OPCODE

* Load input operands
* Load opcode into controller

---

### S2 — EXECUTE

* Enable ALU
* Perform selected operation
* Wait until `alu_done`

---

### S3 — STORE

* Enable register block
* Store ALU result
* Wait until `reg_done`

---

### S4 — DONE

* Operation completed
* System returns to IDLE or starts next operation

---

## State Transition Flow

```text id="wq3k2m"
IDLE → FETCH → EXECUTE → STORE → DONE
```

Transition behavior:

* Start signal moves FSM from IDLE to FETCH
* ALU completion moves FSM to STORE
* Register completion moves FSM to DONE

---

## Control Signals

The FSM generates:

* **alu_on**

  * Enables ALU execution

* **reg_on**

  * Enables register storage

These control signals coordinate datapath operation.

---

## Data Flow

```text id="zk53m0"
Inputs (A, B, Opcode)
        ↓
 Controller FSM
        ↓
      ALU
        ↓
   Register Unit
        ↓
    Output (Q)
```

---

## Simulation

### Compile

```bash id="0mzvlf"
iverilog -o mcu_sim alu.v N_bit_register.v cotroller_FSM.v controller_unit.v controller_tb.v
```

### Run

```bash id="jlwm6t"
vvp mcu_sim
```

### View Waveform

```bash id="l6i6pz"
gtkwave controller_tb.vcd
```

Simulation tools used:

* Verilog HDL
* Icarus Verilog
* GTKWave

---

## Expected Behavior

1. System starts in IDLE state
2. Start signal initiates operation
3. Operands and opcode are loaded
4. ALU executes selected operation
5. ALU output is generated
6. Result is stored in register
7. Output becomes available at Q

Example:

* A = 1001
* B = 0110
* Opcode = 00 (Addition)

Result:

```text id="g7uh7l"
Q = 1111
```

---

## Learning Outcomes

This project helps in understanding:

* Microcontroller control flow
* FSM-based control units
* ALU control logic
* Datapath design
* Register storage operations
* Control and status handshaking
* Basic processor architecture
