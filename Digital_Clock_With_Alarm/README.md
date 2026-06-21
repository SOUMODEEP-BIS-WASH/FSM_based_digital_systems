# Digital Clock with Alarm

## Overview
This project implements a **Digital Clock with Alarm functionality** in Verilog.

The design simulates a real-time clock that:
- Tracks **hours**
- Tracks **minutes**
- Tracks **seconds**
- Triggers an **alarm signal** when the current time matches a preset alarm time

This project demonstrates sequential logic, counters, timekeeping logic, and event-based triggering.

---

# Features

- 24-hour digital clock
- Time tracking in:
  - Hours (0–23)
  - Minutes (0–59)
  - Seconds (0–59)
- Alarm functionality
- Automatic rollover handling:
  - Seconds → Minutes
  - Minutes → Hours
  - Hours → Reset to 0

---

# Inputs and Outputs

---

## Inputs

| Signal | Width | Description |
|--------|-------|-------------|
| `H_A` | 8-bit | Alarm hour |
| `M_A` | 8-bit | Alarm minute |
| `S_A` | 8-bit | Alarm second |
| `clk` | 1-bit | Clock |
| `rst` | 1-bit | Reset |

---

## Outputs

| Signal | Width | Description |
|--------|-------|-------------|
| `alarm` | 1-bit | Alarm trigger |
| `H` | 8-bit | Current hour |
| `M` | 8-bit | Current minute |
| `S` | 8-bit | Current second |

---

# Internal Registers

The clock internally stores current time using:

```verilog
reg [7:0] ch, cm, cs;
```

Where:
- `ch` → Current hour
- `cm` → Current minute
- `cs` → Current second

---

# Clock Logic

At every positive clock edge:

### Second Counter
- Increment seconds until 59

```verilog
if(cs < 59)
    cs <= cs + 1;
```

---

### Minute Counter
When seconds roll over:

```verilog
if(cm < 59)
    cm <= cm + 1;
```

---

### Hour Counter
When minutes and seconds roll over:

```verilog
if(ch < 23)
    ch <= ch + 1;
```

---

### Full Day Rollover
After:

- 23 hours
- 59 minutes
- 59 seconds

Clock resets to:

```text
00:00:00
```

---

# Alarm Logic

Alarm is triggered when current time matches alarm time.

```verilog
if((H == H_A) && (M == M_A) && (S == S_A))
    alarm = 1'b1;
else
    alarm = 1'b0;
```

---

# Working Example

Alarm time set to:

```text
01:00:00
```

When clock reaches:

```text
01:00:00
```

Output becomes:

```text
alarm = 1
```

---

# Testbench

The testbench verifies:
- Clock counting behavior
- Alarm triggering behavior
- Time rollover functionality

---

## Test Setup

```verilog
rst = 1;
H_A = 1;
M_A = 0;
S_A = 0;
```

Alarm is configured for:

```text
1 hour, 0 minute, 0 second
```

---

## Clock Generation

```verilog
always #1 clk = ~clk;
```

Clock toggles every 1 time unit.

---

## Simulation Duration

```verilog
#7210;
```

This allows simulation long enough to observe:
- Clock progression
- Alarm activation

---

# Sample Output

```text
TIME = 7200 | HR = 1 | MIN = 0 | SEC = 0 | ALARM = 1
```

This confirms alarm activates at the correct time.

---

# Key Concepts Demonstrated

- Sequential logic
- Nested counters
- Timekeeping systems
- Event triggering
- Alarm matching logic
- Counter rollover handling

---

# Applications

This design can be extended into:
- Alarm clocks
- Digital watches
- Embedded timers
- Scheduling systems
- Real-time monitoring systems

---

# Possible Improvements

Future enhancements could include:

- Alarm enable/disable control
- Snooze function
- Multiple alarms
- 12-hour format with AM/PM
- Seven-segment display output
- FPGA implementation

---

# Simulation

Simulation generates:
- Console outputs via `$monitor`
- VCD waveform file

```verilog
$dumpfile("tb.vcd");
$dumpvars(0,tb);
```

---

# Tools Used

- Verilog HDL
- GTKWave
- Icarus Verilog / ModelSim / Vivado Simulator

---

# Expected Learning Outcomes

By completing this project, you gain understanding of:
- Counter-based digital design
- Clock-driven sequential systems
- Time rollover handling
- Alarm/event detection mechanisms

---

# Conclusion

This project demonstrates the design of a digital clock with alarm functionality using Verilog. It combines multiple sequential counters with comparison logic to simulate a practical real-world timing system.

It is a strong example of counter-based digital system design and serves as a foundation for more advanced timing applications.
