# Real Time Clock

## Overview
This project implements a **24-hour Real Time Clock (RTC)** in Verilog.  
The clock tracks:

- Hours (`00–23`)
- Minutes (`00–59`)
- Seconds (`00–59`)

Each digit is maintained separately using counters and then converted into **7-segment display encoding** for display output.

This design demonstrates:

- Cascaded counter design  
- Time rollover logic  
- 24-hour format implementation  
- Binary-to-7-segment decoding  

---

## Features
- Real-time counting of **seconds, minutes, and hours**
- Supports **24-hour clock format**
- Outputs time as **7-segment encoded digits**
- Automatic rollover:
  - `59 sec → 00 sec + minute increment`
  - `59 min → 00 min + hour increment`
  - `23:59:59 → 00:00:00`

---

## Module Structure

### 1. RTC Module
Main clock module that:

- Maintains six counters:
  - `count1` → Seconds lower digit
  - `count2` → Seconds upper digit
  - `count3` → Minutes lower digit
  - `count4` → Minutes upper digit
  - `count5` → Hours lower digit
  - `count6` → Hours upper digit

- Converts each counter value to 7-segment output.

### 2. Testbench
Simulates clock operation with:

- Reset logic
- Clock generation
- Output monitoring

---

# Inputs and Outputs

## Inputs
| Signal | Width | Description |
|--------|-------|-------------|
| `clk` | 1 | Clock input |
| `rst` | 1 | Reset input |

---

## Outputs
| Signal | Width | Description |
|--------|-------|-------------|
| `HR_M` | 8 | Hour tens digit (7-segment encoded) |
| `HR_L` | 8 | Hour ones digit (7-segment encoded) |
| `MIN_M` | 8 | Minute tens digit |
| `MIN_L` | 8 | Minute ones digit |
| `SEC_M` | 8 | Second tens digit |
| `SEC_L` | 8 | Second ones digit |

---

# Working Principle

---

## Second Counting
The seconds are split into two digits:

- `count1` → ones place (0–9)
- `count2` → tens place (0–5)

Logic:

```text
00 → 01 → 02 → ... → 09
09 → 10
...
59 → reset seconds and increment minute
```

---

## Minute Counting
Minutes also use two counters:

- `count3` → ones place
- `count4` → tens place

Logic:

```text
00 → 01 → ... → 59
59 → reset minutes and increment hour
```

---

## Hour Counting
Hours use:

- `count5` → ones place
- `count6` → tens place

Supports 24-hour format:

```text
00 → 01 → ... → 23
23 → 00
```

Special logic:

```verilog
if (count6 == 2 && count5 == 3)
```

This detects **23 hours** and resets back to `00`.

---

# Counter Hierarchy

```text
count1 → sec ones
count2 → sec tens
count3 → min ones
count4 → min tens
count5 → hr ones
count6 → hr tens
```

Each counter overflow increments the next counter.

---

# 7-Segment Encoding

Each counter value is mapped to corresponding 7-segment binary code.

Example:

| Digit | Encoding |
|-------|----------|
| 0 | 01111110 |
| 1 | 00110000 |
| 2 | 01101101 |
| 3 | 01111001 |
| 4 | 00110011 |
| 5 | 01011011 |
| 6 | 01011111 |
| 7 | 01110000 |
| 8 | 01111111 |
| 9 | 01111011 |

Example:

```verilog
case (count1)
0: SEC_L = 8'b0111_1110;
1: SEC_L = 8'b0011_0000;
...
endcase
```

---

# Simulation

Clock generation:

```verilog
always #1 clk = ~clk;
```

Reset:

```verilog
rst = 1;
#2;
rst = 0;
```

Simulation runtime:

```verilog
#7210;
```

---

# Example Timing Behavior

```text
00:00:00
00:00:01
00:00:02
...
00:00:59
00:01:00
...
23:59:59
00:00:00
```

---

# Design Highlights
- Fully synchronous design  
- Hierarchical cascading counters  
- Separate counters for each decimal digit  
- Built-in 7-segment display encoding  
- Supports complete 24-hour operation  

---

# Limitations
- Clock input is assumed to represent **1-second interval**
- Uses repeated case statements for 7-segment encoding (can be optimized)
- No AM/PM mode

---

# Possible Improvements
- Add alarm functionality  
- Add stopwatch mode  
- Add manual time setting  
- Add 12-hour AM/PM mode  
- Replace repetitive 7-segment logic with reusable decoder module  

---

# Learning Outcomes
This project helps understand:

- Multi-stage counters  
- Digital clock design  
- Time rollover handling  
- FSM-free sequential logic design  
- Binary-to-display decoding  

---

# Conclusion
This project successfully implements a **Real-Time Clock in Verilog** using cascaded counters and 7-segment display outputs. It demonstrates how digital systems manage time progression and handle hierarchical rollover conditions efficiently.
