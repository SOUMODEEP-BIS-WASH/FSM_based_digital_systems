# Vending Machine with Self-Checking Testbench

## Overview
This project implements a **Finite State Machine (FSM) based vending machine** in Verilog along with a **self-checking testbench** for automated verification.

The vending machine:
- Accepts **Rs 5** and **Rs 10** coins
- Dispenses an item costing **Rs 15**
- Provides refund for extra money
- Includes timeout logic to reset if no coin is inserted for a certain duration

The main highlight of this project is the **self-checking testbench**, which automatically verifies expected outputs and reports pass/fail results without manual waveform inspection.

---

# Functional Requirements

- Coin inputs:
  - Rs 5 coin
  - Rs 10 coin

- Outputs:
  - Item dispense signal
  - Refund signal

- Additional behavior:
  - If user inserts insufficient money and remains inactive for a timeout period, machine resets automatically.

---

# FSM Design

## Inputs
- `c5` → Rs 5 coin input
- `c10` → Rs 10 coin input
- `clk` → Clock
- `rst` → Reset

## Outputs
- `item` → Item dispense signal
- `refund` → Refund signal

---

# FSM States

| State | Meaning |
|-------|---------|
| S0 | Rs 0 |
| S1 | Rs 5 |
| S2 | Rs 10 |
| S3 | Rs 15 (Item dispense) |
| S4 | Rs 20 (Item + Refund) |

---

# State Transition Logic

## From Idle
- Rs 5 inserted → S1
- Rs 10 inserted → S2

## From S1 (Rs 5)
- Rs 5 inserted → S2
- Rs 10 inserted → S3
- No activity for timeout → S0

## From S2 (Rs 10)
- Rs 5 inserted → S3
- Rs 10 inserted → S4
- No activity for timeout → S0

## Final States
- S3 → Dispense item
- S4 → Dispense item + refund

---

# Output Logic

| State | Item | Refund |
|-------|------|--------|
| S0 | 0 | 0 |
| S1 | 0 | 0 |
| S2 | 0 | 0 |
| S3 | 1 | 0 |
| S4 | 1 | 1 |

---

# Timeout Feature

A counter is used to track inactivity.

If:
- User inserts partial money
- Then no additional coin is inserted for **4 clock cycles**

Machine resets to initial state.

This simulates practical vending machine timeout behavior.

---

# Self-Checking Testbench

## Purpose
Instead of manually checking waveforms, the testbench:
- Applies test inputs
- Calculates expected output
- Compares DUT output with expected result
- Displays PASS/FAIL automatically

---

# Testbench Tasks

---

## Reset Task
Resets machine to initial state.

```verilog
task reset();
```

---

## Insert Task
Simulates coin insertion.

```verilog
task insert(input coin1, input coin2);
```

---

## Compare Task
Checks DUT outputs against expected values.

```verilog
task compare(...);
```

Prints:
- TEST OK
- TEST FAILED

---

## Self Check Task
Runs all test scenarios automatically.

```verilog
task self_check();
```

---

# Test Cases

---

## Test Case 1: Rs 5 + Rs 5 + Rs 5

Total = Rs 15

Expected:
- Item = 1
- Refund = 0

Result:
- PASS

---

## Test Case 2: Rs 10 + Rs 10

Total = Rs 20

Expected:
- Item = 1
- Refund = 1

Result:
- PASS

---

## Test Case 3: Rs 5 + Rs 10

Total = Rs 15

Expected:
- Item = 1
- Refund = 0

Result:
- PASS

---

## Test Case 4: Timeout Reset

Sequence:
- Insert Rs 5
- Wait beyond timeout
- Insert Rs 5

Expected:
- Machine resets before second coin
- No item dispensed

Result:
- PASS

---

# Key Concepts Demonstrated

- Finite State Machine design
- Timeout-based reset logic
- Automated verification
- Self-checking testbench methodology
- Task-based testbench design
- Functional validation

---

# Advantages of Self-Checking Testbench

Compared to traditional testbenches:

### Manual Testbench
- Requires waveform inspection
- Human verification needed

### Self-Checking Testbench
- Automatic verification
- Faster debugging
- Scalable for large projects
- Industry-style verification approach

---

# Simulation

Simulation generates:
- Console pass/fail logs
- VCD waveform dump

Example:

```verilog
$dumpfile("tb_self.vcd");
$dumpvars(0,self_checking_tb);
```

---

# Tools Used

- Verilog HDL
- GTKWave
- Icarus Verilog / ModelSim / Vivado Simulator

---

# Expected Learning Outcomes

By completing this project, you gain understanding of:
- FSM-based system design
- Real-world vending machine control logic
- Verification methodology
- Automated testbench design

---

# Conclusion

This project extends vending machine FSM design by introducing a self-checking verification environment. It demonstrates how digital systems can be validated automatically, reducing debugging effort and improving reliability.

This is an important step toward advanced verification methodologies used in real hardware design workflows.
