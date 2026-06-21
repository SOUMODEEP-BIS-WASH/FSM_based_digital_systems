# Project 11: CLA Carry Alert FSM

## Overview
This project combines a **4-bit Carry Lookahead Adder (CLA)** with a **Finite State Machine (FSM)** to detect and alert whenever a carry-out occurs.

The design demonstrates:
- Fast arithmetic computation using CLA
- Output registration
- Carry monitoring using FSM
- Event-based alert generation

This project is useful for understanding how arithmetic units can be integrated with control logic for real-time monitoring and event detection.

---

## Features
- 4-bit Carry Lookahead Adder
- Fast carry computation using propagate/generate logic
- Output storage using register
- FSM-based carry monitoring
- Carry alert generation

---

## Architecture

The design consists of three major blocks:

### 1. Carry Lookahead Adder (CLA)
Performs fast addition of:
- Operand A
- Operand B
- Carry input (Cin)

Outputs:
- Sum (`S`)
- Carry out (`Cout`)

---

### 2. Register Block
Stores:
```text
{Cout, Sum}
```

Registered output:
```text
Q[4:0]
```

Where:
- `Q[4]` = Carry-out
- `Q[3:0]` = Sum

---

### 3. Carry Alert FSM
Monitors registered carry output and generates alert signal.

---

## CLA Logic

The CLA uses:

### Generate
```text
G = A & B
```

### Propagate
```text
P = A ^ B
```

Using generate and propagate signals, intermediate carries are computed in parallel:
- c1
- c2
- c3
- Cout

This reduces carry propagation delay compared to ripple-carry adders.

---

## FSM States

### S0 — No Carry
System is in normal state.

### S1 — Carry Detected
Carry output is high.

---

## FSM Transition Logic

| Current State | Din | Next State |
|---------------|-----|------------|
| S0 | 0 | S0 |
| S0 | 1 | S1 |
| S1 | 0 | S0 |
| S1 | 1 | S1 |

Where:
- `Din = Q[4] = Cout`

---

## Carry Alert Logic

The FSM continuously monitors carry output.

If:
```text
Cout = 1
```

Then:
```text
carry_alert = 1
```

Else:
```text
carry_alert = 0
```

---

## Simulation

### Tools Used
- Icarus Verilog
- GTKWave

### Compile
```bash
iverilog -o carry_alert carry_alert_tb.v carry_alert_mechanism.v carry_alert_FSM.v CLA.v N_bit_register.v DFF.v
```

### Run
```bash
vvp carry_alert
```

### View Waveform
```bash
gtkwave carry_alert_tb.vcd
```

---

## Test Cases

### Test 1
- A = 1000
- B = 0001
- Cin = 0

Expected:
- No carry alert

---

### Test 2
- A = 1111
- B = 1001
- Cin = 0

Expected:
- Carry generated
- Alert triggered

---

### Test 3
- A = 1000
- B = 0001
- Cin = 1

Expected:
- Sum with carry-in handling

---

### Test 4
- A = 1111
- B = 0001
- Cin = 1

Expected:
- Carry generated
- Alert triggered

---

## Learning Outcomes
This project demonstrates:
- Carry Lookahead Adder design
- Fast carry generation
- Arithmetic + FSM integration
- Event detection using control logic
- Real-time carry monitoring

This type of architecture is useful in:
- Arithmetic processors
- Overflow monitoring systems
- Error detection units
- Digital alert systems
