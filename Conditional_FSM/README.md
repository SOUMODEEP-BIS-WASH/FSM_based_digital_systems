# Conditional FSM

## Overview
This project implements a **conditional finite state machine (FSM) based ALU system** where state transitions depend on ALU status flags.

The design combines:
- A 4-bit ALU with status flag generation
- FSM-based operation sequencing
- Conditional state transitions using ALU flags

Unlike earlier FSM ALU projects with fixed transitions, this design introduces **decision-based state transitions**, making it closer to practical control systems and processors.

---

## Features
- 4-bit ALU operations:
  - Addition
  - Subtraction
  - Bitwise AND
  - Bitwise OR
- Status flag generation:
  - Carry
  - Zero
  - Sign
  - Overflow
- FSM-controlled execution
- Conditional transitions based on output flags
- Simulation waveform generation using GTKWave

---

## FSM States

### FETCH
- Captures input operands `A`, `B`
- Captures operation select `S`

### EXECUTE
- ALU performs selected operation
- Status flags are generated

### WRITEBACK
- Stores ALU result into output register `Y`
- Determines next state using status flags

---

## Conditional Transition Logic

After WRITEBACK:

- If **Zero = 1** or **Overflow = 1**
  - Transition to `FETCH`

- If **Carry = 1** or **Sign = 1**
  - Stay in `WRITEBACK`

- Otherwise
  - Stay in `WRITEBACK`

This introduces flag-driven FSM behavior.

---

## ALU Operations

| Opcode | Operation |
|--------|-----------|
| 00 | Addition |
| 01 | Subtraction |
| 10 | Bitwise AND |
| 11 | Bitwise OR |

---

## Status Flags

### Carry
Set when arithmetic carry occurs.

### Zero
Set when output is zero.

### Sign
Reflects MSB of output.

### Overflow
Set when signed overflow occurs.

---

## Simulation

### Tools Used
- Icarus Verilog
- GTKWave

### Compile
```bash
iverilog -o status_tb testbench.v conditional_FSM.v ALU_with_status_flags.v
```

### Run
```bash
vvp status_tb
```

### View Waveform
```bash
gtkwave status_tb.vcd
```

---

## Test Cases
The testbench verifies:

### Test 1: Addition
- A = 1001
- B = 0110
- Opcode = 00

### Test 2: Subtraction
- A = 1001
- B = 0001
- Opcode = 01

Observations:
- ALU output
- Carry flag
- Zero flag
- Sign flag
- Overflow flag
- FSM transitions

---

## Learning Outcomes
This project demonstrates:
- Conditional FSM design
- Status-driven control flow
- ALU + controller integration
- Practical flag-based decision making

This is an important step toward designing processors, controllers, and instruction execution units.
