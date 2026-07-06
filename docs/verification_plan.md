# Verification Plan

## Philosophy

Every RTL module must be verified before it is connected to the rest of the system.

The workflow for every module is:

1. Design
2. RTL Implementation
3. Testbench
4. Icarus Verilog Simulation
5. GTKWave Inspection
6. Debug
7. Git Commit
8. Integration

No module will be added to the FPGA before passing simulation.