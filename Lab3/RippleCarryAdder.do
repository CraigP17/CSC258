# Set the working dir, where all compiled Verilog goes.
vlib work

vlog -timescale 1ns/1ns RippleCarryAdder.v

# Load simulation using mux as the top level simulation module.
vsim carryadder

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

# Test Case 1 0000 + 0000
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
# Output 0000

# Test Case 2 0001 + 0000
  force {SW[0]} 0
  force {SW[1]} 0
  force {SW[2]} 0
  force {SW[3]} 0

  force {SW[4]} 1
  force {SW[5]} 0
  force {SW[6]} 0
  force {SW[7]} 0

  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output 0001

# Test Case 3 0001 + 0001
  force {SW[0]} 1
  force {SW[1]} 0
  force {SW[2]} 0
  force {SW[3]} 0

  force {SW[4]} 1
  force {SW[5]} 0
  force {SW[6]} 0
  force {SW[7]} 0

  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output 0010

# Test Case 4 0011 + 0011
  force {SW[0]} 1
  force {SW[1]} 1
  force {SW[2]} 0
  force {SW[3]} 0

  force {SW[4]} 1
  force {SW[5]} 1
  force {SW[6]} 0
  force {SW[7]} 0

  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output 0110

# Test Case 4 0011 + 0111
  force {SW[0]} 1
  force {SW[1]} 1
  force {SW[2]} 1
  force {SW[3]} 0

  force {SW[4]} 1
  force {SW[5]} 1
  force {SW[6]} 0
  force {SW[7]} 0

  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output 1010

# Test Case 5 0111 + 0111
  force {SW[0]} 1
  force {SW[1]} 1
  force {SW[2]} 1
  force {SW[3]} 0

  force {SW[4]} 1
  force {SW[5]} 1
  force {SW[6]} 1
  force {SW[7]} 0

  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output 1110

# Test Case 6 1010 + 0101
  force {SW[0]} 1
  force {SW[1]} 0
  force {SW[2]} 1
  force {SW[3]} 0

  force {SW[4]} 0
  force {SW[5]} 1
  force {SW[6]} 0
  force {SW[7]} 1

  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output 1111

# Test Case 7 1010 + 0101
  force {SW[0]} 0
  force {SW[1]} 1
  force {SW[2]} 0
  force {SW[3]} 1

  force {SW[4]} 1
  force {SW[5]} 0
  force {SW[6]} 1
  force {SW[7]} 0

  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output 1111

# Test Case 8 0011 + 0011
  force {SW[0]} 1
  force {SW[1]} 1
  force {SW[2]} 0
  force {SW[3]} 0

  force {SW[4]} 1
  force {SW[5]} 1
  force {SW[6]} 0
  force {SW[7]} 0

  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output 0110

# Test Case 9 0111 + 0001
  force {SW[0]} 1
  force {SW[1]} 0
  force {SW[2]} 0
  force {SW[3]} 0

  force {SW[4]} 1
  force {SW[5]} 1
  force {SW[6]} 1
  force {SW[7]} 0

  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output 1000

# Test Case 10 0001 + 0111
  force {SW[0]} 1
  force {SW[1]} 1
  force {SW[2]} 1
  force {SW[3]} 0

  force {SW[4]} 1
  force {SW[5]} 0
  force {SW[6]} 0
  force {SW[7]} 0

  force {SW[8]} 0
  force {SW[9]} 0
  run 50ns
# Output 1000
