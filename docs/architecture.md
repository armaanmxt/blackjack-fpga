# Blackjack FPGA Architecture

## Overview

The design is divided into independent hardware modules.

Each module performs one specific task.

The top module connects every subsystem together.

---

## Planned Modules

- Clock Divider
- Debouncer
- Edge Detector
- Random Card Generator
- Hand Memory
- Score Calculator
- Dealer Logic
- Blackjack FSM
- Display Driver
- Seven Segment Driver

---

## Development Strategy

Each module will be:

- Designed
- Simulated
- Verified
- Integrated