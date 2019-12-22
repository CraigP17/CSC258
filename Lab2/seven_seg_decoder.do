# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in Part3.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns seven_seg_decoder.v

# Load simulation using mux as the top level simulation module.
vsim seven_seg_decoder

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

# b
# Test Case. Displaying b
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1

# Output HEX[0],HEX[1]

# Run simulation for a few ns.
run 50ns



# A
# Test Case. Displaying A
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1

# Output HEX[3]

# Run simulation for a few ns.
run 50ns



# 3
# Test Case. Displaying 3
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0

# Output HEX[4], HEX[5]

# Run simulation for a few ns.
run 50ns



# 1
# Test Case. Displaying 1
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

# Output HEX[0], HEX[3], HEX[4], HEX[5], HEX[6]

# Run simulation for a few ns.
run 50ns



# 4
# Test Case. Displaying 4
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0

# Output HEX[0], HEX[3], HEX[4]

# Run simulation for a few ns.
run 50ns



# 5
# Test Case. Displaying 5
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0

# Output HEX[1], HEX[4]

# Run simulation for a few ns.
run 50ns
