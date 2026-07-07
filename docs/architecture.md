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
| random_card.v | Generates card values from 1 to 11 |
| hand_manager.v | Stores player/dealer cards |
| score_calculator.v | Calculates player/dealer scores |
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
score_calculator
   ↓
sevenseg_driver
   ↓
Basys 3 display
```

---

## Card Representation

Version 1 stores only Blackjack card values.

Cards are represented as 4-bit values:

| Card Type | Stored Value |
|---|---|
| 2-9 | 2-9 |
| 10/J/Q/K | 10 |
| Ace | 11 |

Suits are ignored in Version 1.

This keeps the first version focused on RTL design, FSM control, score calculation, simulation, and FPGA integration.

---

## Top-Level Block Diagram

```text
                 +----------------+
clk ------------>|     top.v      |
btnC ----------->|                |
btnU ----------->|                |
btnR ----------->|                |
                 +-------+--------+
                         |
                         v

              +---------------------+
              |  Button Conditioner |
              +----------+----------+
                         |
          reset_pulse, hit_pulse, stand_pulse
                         |
                         v

              +---------------------+
              |    Blackjack FSM    |
              +----------+----------+
                         |
       draw_player, draw_dealer, clear_game
                         |
                         v

              +---------------------+        +---------------------+
              | Random Card Gen     |------->|    Hand Manager     |
              +---------------------+ card   +----------+----------+
                                                   |
                                      player_cards, dealer_cards
                                                   |
                                                   v
                                           +---------------+
                                           | Score Calc    |
                                           +-------+-------+
                                                   |
                                      player_score, dealer_score
                                                   |
                                                   v
                                           +---------------+
                                           | Display Driver|
                                           +-------+-------+
                                                   |
                                           seg, an, led
```

---

## Module Responsibilities

| Module | Type | Responsibility |
|---|---|---|
| button_conditioner | Sequential | Converts messy button input into clean one-clock pulses |
| blackjack_fsm | Sequential | Controls game flow and decides when actions happen |
| random_card | Sequential | Continuously cycles through card values and outputs one when requested |
| hand_manager | Sequential | Stores player and dealer cards |
| score_calculator | Combinational | Calculates hand totals from stored cards |
| display_driver | Sequential/Combinational | Converts game information into LEDs and seven-segment display outputs |
| top | Structural | Connects all modules together |