# Parametrized FSM Generator

## Overview

This project implements a **parameterized Finite State Machine (FSM)** in Verilog.
Unlike fixed FSM designs, this module allows the number of states to be configured using a parameter `N`.

The FSM cycles sequentially through `N` states:

* State 0 → State 1 → State 2 → ... → State N−1 → State 0

An output signal `Dout` becomes HIGH when the FSM reaches the final state (`N−1`).

This project demonstrates:

* Parameterized Verilog design
* FSM state transitions
* Counter-like state sequencing
* Scalable digital system design

---

## Problem Statement

Design a configurable FSM that:

* Contains `N` states
* Advances one state on every clock cycle
* Resets to State 0 when reset is asserted
* Wraps back to State 0 after reaching the last state
* Produces a HIGH output at the final state

---

## Inputs

* **clk** → Clock signal
* **rst** → Reset signal

---

## Outputs

* **Dout** → Goes HIGH when FSM reaches final state (`N−1`)

---

## FSM Design

### States

The FSM contains `N` states numbered as:

* S0
* S1
* S2
* ...
* S(N−1)

---

### State Transition Logic

* On reset:

  * FSM returns to **S0**
* On each positive clock edge:

  * FSM transitions to next state
* If current state is `S(N−1)`:

  * FSM wraps back to **S0**

Transition sequence:
S0 → S1 → S2 → ... → S(N−1) → S0

---

## Output Logic

The output `Dout` is asserted only when the FSM reaches the final state.

```verilog
Dout = (PS == N-1);
```

Thus:

* `Dout = 1` at state `S(N−1)`
* `Dout = 0` otherwise

---

## Simulation

### Compile

```bash
iverilog -o para_fsm parametrized_FSM.v para_FSM_tb.v
```

### Run

```bash
vvp para_fsm
```

### View Waveform

```bash
gtkwave para_fsm_tb.vcd
```

Simulation tools used:

* Verilog HDL
* Icarus Verilog
* GTKWave

---

## Testbench Configuration

The testbench instantiates:

```verilog
para_FSM #(3)
```

This means:

* Total states = 3
* States = S0, S1, S2

Sequence:
S0 → S1 → S2 → S0 → ...

`Dout` becomes HIGH at:

* S2

---

## Expected Behavior

After reset:

* FSM starts at State S0

Then:

* Clock cycle 1 → S1
* Clock cycle 2 → S2 → `Dout = 1`
* Clock cycle 3 → S0
* Repeats continuously

---

## Learning Outcomes

This project helps in understanding:

* FSM implementation in Verilog
* Parameterized hardware design
* State encoding using `$clog2`
* Sequential and combinational logic separation
* Scalable FSM architectures
