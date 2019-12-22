# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in Part3.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns sevenOneMux.v

# Load simulation using mux as the top level simulation module.
vsim mux

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

# Test Case 1. All off
  force {SW[0]} 0
  force {SW[1]} 0
  force {SW[2]} 0
  force {SW[3]} 0
  force {SW[4]} 0
  force {SW[5]} 0
  force {SW[6]} 0
  force {SW[7]} 0
  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output LEDR = 0

# Test Case 2. Testing Case 0
  force {SW[0]} 1
  force {SW[1]} 0
  force {SW[2]} 0
  force {SW[3]} 0
  force {SW[4]} 0
  force {SW[5]} 0
  force {SW[6]} 0
  force {SW[7]} 0
  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output LEDR = 1

# Test Case 3. Testing Case 1
  force {SW[0]} 0
  force {SW[1]} 1
  force {SW[2]} 0
  force {SW[3]} 0
  force {SW[4]} 0
  force {SW[5]} 0
  force {SW[6]} 0
  force {SW[7]} 1
  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output LEDR = 1

# Test Case 4.
  force {SW[0]} 1
  force {SW[1]} 0
  force {SW[2]} 1
  force {SW[3]} 1
  force {SW[4]} 1
  force {SW[5]} 1
  force {SW[6]} 1
  force {SW[7]} 1
  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output LEDR = 0

# Test Case 5. Testing Case 2
  force {SW[0]} 0
  force {SW[1]} 0
  force {SW[2]} 1
  force {SW[3]} 0
  force {SW[4]} 0
  force {SW[5]} 0
  force {SW[6]} 0
  force {SW[7]} 0
  force {SW[8]} 1
  force {SW[9]} 0
  run 50ns
# Output LEDR = 1

# Test Case 6.
  force {SW[0]} 1
  force {SW[1]} 1
  force {SW[2]} 0
  force {SW[3]} 1
  force {SW[4]} 1
  force {SW[5]} 1
  force {SW[6]} 1
  force {SW[7]} 0
  force {SW[8]} 1
  force {SW[9]} 0
  run 50ns
# Output LEDR = 0

# Test Case 5. Testing Case 3
  force {SW[0]} 0
  force {SW[1]} 0
  force {SW[2]} 0
  force {SW[3]} 1
  force {SW[4]} 0
  force {SW[5]} 0
  force {SW[6]} 0
  force {SW[7]} 1
  force {SW[8]} 1
  force {SW[9]} 0
  run 50ns
# Output LEDR = 1

# Test Case 6.
  force {SW[0]} 1
  force {SW[1]} 1
  force {SW[2]} 1
  force {SW[3]} 0
  force {SW[4]} 1
  force {SW[5]} 1
  force {SW[6]} 1
  force {SW[7]} 1
  force {SW[8]} 1
  force {SW[9]} 0
  run 50ns
# Output LEDR = 0

# Test Case 5. Testing Case 4
  force {SW[0]} 0
  force {SW[1]} 0
  force {SW[2]} 0
  force {SW[3]} 0
  force {SW[4]} 1
  force {SW[5]} 0
  force {SW[6]} 0
  force {SW[7]} 0
  force {SW[8]} 0
  force {SW[9]} 1
  run 50ns
# Output LEDR = 1

# Test Case 7.
  force {SW[0]} 1
  force {SW[1]} 1
  force {SW[2]} 1
  force {SW[3]} 1
  force {SW[4]} 0
  force {SW[5]} 1
  force {SW[6]} 1
  force {SW[7]} 0
  force {SW[8]} 0
  force {SW[9]} 1
  run 50ns
# Output LEDR = 0

# Test Case 8. Testing Case 5
  force {SW[0]} 0
  force {SW[1]} 0
  force {SW[2]} 0
  force {SW[3]} 0
  force {SW[4]} 0
  force {SW[5]} 1
  force {SW[6]} 0
  force {SW[7]} 1
  force {SW[8]} 0
  force {SW[9]} 1
  run 50ns
# Output LEDR = 1

# Test Case 9.
  force {SW[0]} 1
  force {SW[1]} 1
  force {SW[2]} 1
  force {SW[3]} 1
  force {SW[4]} 1
  force {SW[5]} 0
  force {SW[6]} 1
  force {SW[7]} 1
  force {SW[8]} 0
  force {SW[9]} 1
  run 50ns
# Output LEDR = 0

# Test Case 10. Testing Case 6
  force {SW[0]} 0
  force {SW[1]} 0
  force {SW[2]} 0
  force {SW[3]} 0
  force {SW[4]} 0
  force {SW[5]} 0
  force {SW[6]} 1
  force {SW[7]} 0
  force {SW[8]} 1
  force {SW[9]} 1
  run 50ns
# Output LEDR = 1

# Test Case 11.
  force {SW[0]} 1
  force {SW[1]} 1
  force {SW[2]} 1
  force {SW[3]} 1
  force {SW[4]} 1
  force {SW[5]} 0
  force {SW[6]} 1
  force {SW[7]} 1
  force {SW[8]} 0
  force {SW[9]} 1
  run 50ns
# Output LEDR = 0

# Test Case 10. Testing Default
  force {SW[0]} 0
  force {SW[1]} 0
  force {SW[2]} 0
  force {SW[3]} 0
  force {SW[4]} 0
  force {SW[5]} 0
  force {SW[6]} 0
  force {SW[7]} 1
  force {SW[8]} 1
  force {SW[9]} 1
  run 50ns
# Output LEDR = 0
