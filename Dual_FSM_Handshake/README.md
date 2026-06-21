# Project 10: Dual FSM Handshake

## Overview
This project implements a **dual FSM handshake mechanism** for coordinated data transfer between a data controller and an ALU controller.

The system uses:
- Two independent FSMs
- Handshake signals for synchronization
- ALU for computation
- Register for storing final result

This design demonstrates how multiple FSMs can communicate using control signals such as **load**, **acknowledge**, and **done**.

---

## Features
- Dual FSM architecture
- Handshake-based communication
- Synchronized data transfer
- ALU operation control
- Register-based result storage
- Modular design

---

## Architecture

The system consists of four major blocks:

### 1. Data Controller FSM
Responsible for:
- Receiving external input
- Loading operands and opcode
- Sending data to ALU controller
- Receiving ALU result
- Storing output in register

---

### 2. ALU Controller FSM
Responsible for:
- Waiting for data load request
- Receiving operands/opcode
- Triggering ALU operation
- Returning result to Data Controller

---

### 3. ALU
Performs:
- Addition
- Subtraction
- Bitwise AND
- Bitwise OR

---

### 4. Register
Stores the final ALU output.

---

## Data Controller FSM States

### S0 — IDLE
Waits for `start`.

### S1 — LOAD
Sends operands and opcode to ALU controller.

### S2 — WAIT
Waits for ALU computation completion.

### S3 — STORE
Receives ALU result and stores it.

### S4 — NEXT
Determines whether to start next transaction.

---

## ALU Controller FSM States

### S0 — IDLE
Waits for load signal.

### S1 — LOAD & EXECUTE
Receives data and enables ALU.

### S2 — OUTPUT
Returns ALU result and waits for acknowledgement.

---

## Handshake Signals

| Signal | Description |
|--------|-------------|
| `load` | Request to send data |
| `data_loaded` | Data accepted by ALU controller |
| `alu_done1` | ALU computation finished |
| `alu_done` | ALU controller signals result ready |
| `rcvd` | Data controller acknowledges receipt |
| `data_stored` | Register confirms data storage |

---

## ALU Operations

| Opcode | Operation |
|--------|-----------|
| 00 | Addition |
| 01 | Subtraction |
| 10 | Bitwise AND |
| 11 | Bitwise OR |

---

## Handshake Flow

1. Data Controller waits for `start`
2. Sends operands + opcode using `load`
3. ALU Controller receives data
4. ALU computation begins
5. ALU asserts completion
6. ALU Controller sends result back
7. Data Controller stores result
8. Transaction completes

---

## Simulation

### Tools Used
- Icarus Verilog
- GTKWave

### Compile
```bash
iverilog -o mechanism mechanism_tb.v handshake_mechanism.v data_controller_FSM.v alu_controller_FSM.v alu.v N_bit_register.v
```

### Run
```bash
vvp mechanism
```

### View Waveform
```bash
gtkwave mechanism.vcd
```

---

## Test Case

### Input
- A = 1001
- B = 0011
- Opcode = 00 (Addition)

### Expected Operation
```text
1001 + 0011 = 1100
```

Expected final register output:
```text
Q = 1100
```

---

## Learning Outcomes
This project demonstrates:
- Multi-FSM system design
- Handshake protocols
- FSM synchronization
- Controller-to-controller communication
- Practical hardware coordination mechanisms

This project is especially useful for understanding communication protocols used in:
- Processor pipelines
- Bus protocols
- Hardware accelerators
- Network-on-Chip systems
