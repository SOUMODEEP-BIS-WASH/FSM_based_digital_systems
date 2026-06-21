# Project 12: Vending Machines

## Overview
This project implements multiple **Finite State Machine (FSM) based vending machine designs in Verilog**, starting from a simple single-coin machine to more advanced multi-item vending systems with selection and refund mechanisms.

The project demonstrates how FSMs can model real-world control systems such as vending machines by tracking money accumulation, item selection, dispensing, and refund handling.

---

# Designs Included

---

## 1. VM1 — Basic Vending Machine

### Description
A simple vending machine that:
- Accepts only **Rs 5 coins**
- Dispenses **1 item**
- Requires only one coin to dispense item

### Inputs
- `coin5` → Rs 5 coin input
- `clk` → Clock
- `rst` → Reset

### Output
- `item` → Item dispense signal

### FSM States
- **S0** → Idle / No coin inserted
- **S1** → Coin received, item available

### State Transition
- `S0 → S1` when coin inserted
- `S1 → S0` when no coin

### Features
- Simplest FSM implementation
- Demonstrates basic sequential state transition

---

## 2. VM2 — Multi-Coin Single Item Vending Machine

### Description
A vending machine that:
- Accepts **Rs 5 and Rs 10 coins**
- Dispenses **one item worth Rs 25**
- Extra money is **not refunded**
- Excess amount is reused

### Inputs
- `c5` → Rs 5 coin
- `c10` → Rs 10 coin
- `clk`
- `rst`

### Output
- `item`

### FSM States
| State | Amount |
|-------|--------|
| S0 | Rs 0 |
| S1 | Rs 5 |
| S2 | Rs 10 |
| S3 | Rs 15 |
| S4 | Rs 20 |
| S5 | Rs 25 |
| S6 | Rs 30 |

### Features
- Coin accumulation using FSM states
- Automatic dispense at Rs 25+
- No refund logic

---

## 3. VM3 — Multi-Item Vending Machine (No Refund)

### Description
A vending machine that:
- Accepts Rs 5 and Rs 10 coins
- Supports **3 item options**
- Uses selection line for item choice
- Extra money is **reused**, not refunded

### Items
| Selection | Item Cost |
|-----------|-----------|
| `01` | Rs 5 item |
| `10` | Rs 15 item |
| Automatic | Rs 25 item |

### Inputs
- `c5`
- `c10`
- `clk`
- `rst`
- `sel`

### Outputs
- `item5`
- `item15`
- `item25`

### Features
- Multi-output FSM
- Selection-based dispensing
- Carry-forward balance system

---

## 4. VM4 — Multi-Item Vending Machine (With Refund)

### Description
A vending machine that:
- Accepts Rs 5 and Rs 10 coins
- Supports 3 item types
- Refunds excess money

### Items
| Selection | Item Cost |
|-----------|-----------|
| `01` | Rs 5 |
| `10` | Rs 15 |
| Automatic | Rs 25 |

### Inputs
- `c5`
- `c10`
- `clk`
- `rst`
- `sel`

### Outputs
- `item5`
- `item15`
- `item25`
- `refund`

### Extra FSM State
- **S7 → Refund state**

### Features
- Refund handling logic
- Advanced vending machine FSM
- Practical real-world behavior

---

# Key Concepts Demonstrated

- Finite State Machine design
- Moore machine outputs
- Sequential state transitions
- Coin accumulation
- Item selection
- Refund logic
- Real-world control system modeling

---

# FSM Progression in This Project

This project gradually increases complexity:

1. **VM1** → Single coin, single item  
2. **VM2** → Multiple coins, single item  
3. **VM3** → Multiple coins, multiple items  
4. **VM4** → Multiple coins, multiple items + refund  

---

# Simulation

Each vending machine has its own dedicated testbench:

- `tb1.v` → VM1
- `tb2.v` → VM2
- `tb3.v` → VM3
- `tb4.v` → VM4

Simulation generates:
- VCD waveform files
- Console output via `$monitor`

Example:
```verilog
$dumpfile("tb1.vcd");
$dumpvars(0,tb1);
```

---

# Expected Learning Outcomes

By completing this project, you gain understanding of:
- FSM-based digital design
- State encoding
- Practical hardware control systems
- Real-world embedded logic implementation

---

# Tools Used

- Verilog HDL
- GTKWave
- Icarus Verilog / EDA Playground / ModelSim

---

# Conclusion

This project demonstrates how FSMs can effectively model increasingly complex vending machine behavior. Starting from a simple single-input machine and extending to multi-item selection with refund mechanisms provides strong practical understanding of FSM-based system design.
