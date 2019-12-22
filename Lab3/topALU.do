# Set the working dir, where all compiled Verilog goes.
vlib work

vlog -timescale 1ns/1ns topALU.v

# Load simulation using topALU as the top level simulation module.
vsim topALU
# Log all signals and add some signals to waveform window.
log {/*}
# add wave {/*} would add all items in top level simulation module.
add wave {/*}

#                       CASE 0, OUTPUTTING A + 1

# Test Case 1 A = 0000
    force {SW[0]} 0
    force {SW[1]} 0
    force {SW[2]} 0
    force {SW[3]} 0
    force {SW[4]} 0
    force {SW[5]} 0
    force {SW[6]} 0
    force {SW[7]} 0

    force {KEY[2]} 0
    force {KEY[1]} 0
    force {KEY[0]} 0

    run 50ns
#Output 0001

# Test Case 1 A = 0111
    force {SW[0]} 0
    force {SW[1]} 0
    force {SW[2]} 0
    force {SW[3]} 0

    force {SW[4]} 1
    force {SW[5]} 1
    force {SW[6]} 1
    force {SW[7]} 0

    force {KEY[2]} 0
    force {KEY[1]} 0
    force {KEY[0]} 0

    run 50ns
#Output 00000001

# Test Case 2 A = 0111
    force {SW[0]} 0
    force {SW[1]} 0
    force {SW[2]} 0
    force {SW[3]} 0

    force {SW[4]} 1
    force {SW[5]} 1
    force {SW[6]} 1
    force {SW[7]} 0

    force {KEY[2]} 0
    force {KEY[1]} 0
    force {KEY[0]} 0

    run 50ns
#Output 00001000

# Test Case 3 A = 0111 B should have no effect
    force {SW[0]} 1
    force {SW[1]} 1
    force {SW[2]} 1
    force {SW[3]} 1

    force {SW[4]} 1
    force {SW[5]} 1
    force {SW[6]} 1
    force {SW[7]} 0

    force {KEY[2]} 0
    force {KEY[1]} 0
    force {KEY[0]} 0

    run 50ns
#Output 0001000

# Test Case 4 A = 0101
    force {SW[0]} 0
    force {SW[1]} 0
    force {SW[2]} 0
    force {SW[3]} 0

    force {SW[4]} 1
    force {SW[5]} 0
    force {SW[6]} 1
    force {SW[7]} 0

    force {KEY[2]} 0
    force {KEY[1]} 0
    force {KEY[0]} 0

    run 50ns
#Output 00000110

# Test Case 5 A = 1111
    force {SW[0]} 0
    force {SW[1]} 0
    force {SW[2]} 0
    force {SW[3]} 0

    force {SW[4]} 1
    force {SW[5]} 1
    force {SW[6]} 1
    force {SW[7]} 1

    force {KEY[2]} 0
    force {KEY[1]} 0
    force {KEY[0]} 0

    run 100ns
#Output 00010000

#                   CASE 1 A + B USING CARRY RIPPLE ADDER

# Test Case 1 A = 1111 B = 0000
    force {SW[0]} 0
    force {SW[1]} 0
    force {SW[2]} 0
    force {SW[3]} 0

    force {SW[4]} 1
    force {SW[5]} 1
    force {SW[6]} 1
    force {SW[7]} 1

    force {KEY[2]} 0
    force {KEY[1]} 0
    force {KEY[0]} 1

    run 50ns
# Output: 00001111
# HEX: f 0 0 0 0 f

# Test Case 2 A = 0111 B = 0011
    force {SW[0]} 1
    force {SW[1]} 1
    force {SW[2]} 0
    force {SW[3]} 0

    force {SW[4]} 1
    force {SW[5]} 1
    force {SW[6]} 1
    force {SW[7]} 0

    force {KEY[2]} 0
    force {KEY[1]} 0
    force {KEY[0]} 1

    run 50ns
# Output: 00001010
# HEX: 7 0 3 0 0 A

# Test Case 3 0111 + 0111
    force {SW[0]} 1
    force {SW[1]} 1
    force {SW[2]} 1
    force {SW[3]} 0

    force {SW[4]} 1
    force {SW[5]} 1
    force {SW[6]} 1
    force {SW[7]} 0

    force {KEY[2]} 0
    force {KEY[1]} 0
    force {KEY[0]} 1

    run 50ns
# Output: 00001110
# HEX: 7 0 7 0 0 E

# Test Case 4 0101 + 1010
    force {SW[0]} 0
    force {SW[1]} 1
    force {SW[2]} 0
    force {SW[3]} 1

    force {SW[4]} 1
    force {SW[5]} 0
    force {SW[6]} 1
    force {SW[7]} 0

    force {KEY[2]} 0
    force {KEY[1]} 0
    force {KEY[0]} 1

    run 100ns
# Output: 00001111
# HEX: 5 0 A 0 0 f

#                 CASE 2 A + B USING VERILOG OPERATOR '+'

# Test Case 1 A = 1111; B = 0000
    force {SW[0]} 0
    force {SW[1]} 0
    force {SW[2]} 0
    force {SW[3]} 0

    force {SW[4]} 1
    force {SW[5]} 1
    force {SW[6]} 1
    force {SW[7]} 1

    force {KEY[2]} 0
    force {KEY[1]} 1
    force {KEY[0]} 0

    run 50ns
# Output: 00001111
# HEX: f 0 0 0 0 f

# Test Case 2 A = 0111; B = 0011
    force {SW[0]} 1
    force {SW[1]} 1
    force {SW[2]} 0
    force {SW[3]} 0

    force {SW[4]} 1
    force {SW[5]} 1
    force {SW[6]} 1
    force {SW[7]} 0

    force {KEY[2]} 0
    force {KEY[1]} 1
    force {KEY[0]} 0

    run 50ns
# Output: 00001010
# HEX: 7 0 3 0 0 A

# Test Case 3 0111 + 0111
    force {SW[0]} 1
    force {SW[1]} 1
    force {SW[2]} 1
    force {SW[3]} 0

    force {SW[4]} 1
    force {SW[5]} 1
    force {SW[6]} 1
    force {SW[7]} 0

    force {KEY[2]} 0
    force {KEY[1]} 1
    force {KEY[0]} 0

    run 50ns
# Output: 00001110
# HEX: 7 0 7 0 0 E

# Test Case 4 0101 + 1010
    force {SW[0]} 0
    force {SW[1]} 1
    force {SW[2]} 0
    force {SW[3]} 1

    force {SW[4]} 1
    force {SW[5]} 0
    force {SW[6]} 1
    force {SW[7]} 0

    force {KEY[2]} 0
    force {KEY[1]} 1
    force {KEY[0]} 0

    run 100ns
# Output: 00001111
# HEX: 5 0 A 0 0 f

#						CASE 3
# 0101
# 0111


#func 011 Case 3
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1

#SET VALUES OF A
force {SW[7]} 0
force {SW[6]} 1
force {SW[5]} 0
force {SW[4]} 1

#SET VALUES OF B
force {SW[3]} 0
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

#LEDR OUTPUT 01110010
#HEX0 7
#HEX2 5
#HEX4 2
#HEX5 7

run 50ns


#0001
#0010


#func 011 Case 3
force {KEY[2]} 0
force {KEY[1]} 1
force {KEY[0]} 1

#SET VALUES OF A
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 1

#SET VALUES OF B
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0

# Run simulation for a few ns.
run 100ns
#OUTPUT LEDR = 00110011
#HEX0 2
#HEX2 1
#HEX4 3
#HEX5 3

#-----------CASE 4 TESTS----------------

#1000
#0010


#force values to case 4
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0

#SET VALUES OF A
force {SW[7]} 1
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0

#SET VALUES OF B
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 1
force {SW[0]} 0

# Run simulation for a few ns.
run 50ns

#OUTPUT = 00000001
#HEX0 = 2
#HEX2 = 8
#HEX4 = 1
#HEX5 = 0


#0000
#0000


#force values to case 4
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0

#SET VALUES OF A
force {SW[7]} 0
force {SW[6]} 0
force {SW[5]} 0
force {SW[4]} 0

#SET VALUES OF B
force {SW[3]} 0
force {SW[2]} 0
force {SW[1]} 0
force {SW[0]} 0

# Run simulation for a few ns.
run 50ns

#OUTPUT = 00000000
#HEX0 = 0
#HEX2 = 0
#HEX4 = 0
#HEX5 = 0


#1111
#1111


#force values to case 4
force {KEY[2]} 1
force {KEY[1]} 0
force {KEY[0]} 0

#SET VALUES OF A
force {SW[7]} 1
force {SW[6]} 1
force {SW[5]} 1
force {SW[4]} 1

#SET VALUES OF B
force {SW[3]} 1
force {SW[2]} 1
force {SW[1]} 1
force {SW[0]} 1

# Run simulation for a few ns.
run 100ns

#OUTPUT = 00000001
#HEX0 = f
#HEX2 = f
#HEX4 = 1
#HEX5 = 0

#                 CASE 5 Concatenating, INPUT APPEARS AT OUTPUT

# Test Case 1 A = 1111; B = 1111
    force {SW[0]} 1
    force {SW[1]} 1
    force {SW[2]} 1
    force {SW[3]} 1

    force {SW[4]} 1
    force {SW[5]} 1
    force {SW[6]} 1
    force {SW[7]} 1

    force {KEY[2]} 1
    force {KEY[1]} 0
    force {KEY[0]} 1

    run 50ns
# Output: 11111111
# HEX: f 0 f 0 f f

# Test Case 1 A = 0000; B = 0000
    force {SW[0]} 0
    force {SW[1]} 0
    force {SW[2]} 0
    force {SW[3]} 0

    force {SW[4]} 0
    force {SW[5]} 0
    force {SW[6]} 0
    force {SW[7]} 0

    force {KEY[2]} 1
    force {KEY[1]} 0
    force {KEY[0]} 1

    run 50ns
# Output: 00000000
# HEX: 0 0 0 0 0 0
