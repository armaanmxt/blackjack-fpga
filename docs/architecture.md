# Blackjack FPGA Architecture

## Version 1 Goal

Implement a simplified Blackjack game on the Basys 3 FPGA.

The player can reset, hit, and stand. The dealer automatically plays after the player stands. The FPGA determines the winner.

---

## Hardware Inputs

| Input | Purpose |
|---|---|
| clk | 100 MHz Basys 3 clock |
| btnC | Reset / new game |
| btnU | Hit |
| btnR | Stand |

---

## Hardware Outputs

| Output | Purpose |
|---|---|
| led[15:0] | Debug/game state display |
| seg[6:0] | Seven-segment digit segments |
| an[3:0] | Seven-segment digit enables |
| dp | Decimal point |

---

## Main Modules

| Module | Job |
|---|---|
| top.v | Connects the whole design |
| button_conditioner.v | Cleans button presses |
| random_card.v | Generates card values from 1 to 10 |
| hand_manager.v | Stores player/dealer totals |
| blackjack_fsm.v | Controls game flow |
| sevenseg_driver.v | Displays scores/status |

---

## Simplified Data Flow

```text
Buttons
   ↓
button_conditioner
   ↓
blackjack_fsm
   ↓
hand_manager ← random_card
   ↓
sevenseg_driver
   ↓
Basys 3 display