vlib ./work

vlog -work work ../Exp1/one_bit_full_adder_v.v
vlog -work work ../Exp1/FATB.v

vsim FATB

#run full sim or part of it..
run -all
#run 10 us

quit
