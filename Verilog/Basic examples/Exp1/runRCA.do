vlib ./work

vlog -work work ../Exp1/Ripple_Carry_Adder_eight_bits_v.v
vlog -work work ../Exp1/RCATB.v

vsim RCATB

#run full sim or part of it..
run -all
#run 15 us

quit
