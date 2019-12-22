# Set the working dir, where all compiled Verilog goes.
vlib work

# Compile all Verilog modules in Part2.v to working dir;
# could also have multiple Verilog files.
# The timescale argument defines default time unit
# (used when no unit is specified), while the second number
# defines precision (all times are rounded to this value)
vlog -timescale 1ns/1ns mux.v

# Load simulation using mux as the top level simulation module.
vsim mux

# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

# 1st test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

force {SW[9]} 0
force {SW[8]} 0

# Output 0

# Run simulation for a few ns.
run 50ns


# 2nd test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 0

force {SW[9]} 0
force {SW[8]} 0

# Output 1

# Run simulation for a few ns.
run 50ns


# 3rd test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0

force {SW[9]} 0
force {SW[8]} 0

# Output 0

# Run simulation for a few ns.
run 50ns


# 4th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0

force {SW[9]} 0
force {SW[8]} 0

# Output 0

# Run simulation for a few ns.
run 50ns


# 5th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1

force {SW[9]} 1
force {SW[8]} 1

# Output 1

# Run simulation for a few ns.
run 50ns


# 6th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0

force {SW[9]} 0
force {SW[8]} 1

# Output 0

# Run simulation for a few ns.
run 50ns


# 7th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 0
force {SW[3]} 1

force {SW[9]} 1
force {SW[8]} 0

# Output 0

# Run simulation for a few ns.
run 50ns


# 8th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 0

force {SW[9]} 1
force {SW[8]} 0

# Output 0

# Run simulation for a few ns.
run 50ns


# 9th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1

force {SW[9]} 1
force {SW[8]} 0

# Output 1

# Run simulation for a few ns.
run 50ns


# 10th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1

force {SW[9]} 0
force {SW[8]} 0

# Output 0

# Run simulation for a few ns.
run 50ns


# 11th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1

force {SW[9]} 1
force {SW[8]} 1

# Output 1
# Run simulation for a few ns.
run 50ns


# 12th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 1
force {SW[1]} 1
force {SW[2]} 0
force {SW[3]} 1

force {SW[9]} 1
force {SW[8]} 0

# Output 0

# Run simulation for a few ns.
run 50ns


# 13th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 0
force {SW[1]} 1
force {SW[2]} 1
force {SW[3]} 1

force {SW[9]} 0
force {SW[8]} 1

# Output 1

# Run simulation for a few ns.
run 50ns


# 14th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 1
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 0

force {SW[9]} 1
force {SW[8]} 1

# Output 0

# Run simulation for a few ns.
run 50ns


# 15th test case
# Set input values using the force command, signal names need to be in {} brackets.
force {SW[0]} 0
force {SW[1]} 0
force {SW[2]} 1
force {SW[3]} 1

force {SW[9]} 0
force {SW[8]} 1

# Output 0

# Run simulation for a few ns.
run 50ns
