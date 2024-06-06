vlib ./work

vlog -work work ../Exp2/Deco.v
vlog -work work ../Exp2/DecoTB.v

vsim DecoTB

#run full sim or part of it..
run -all
#run 10 us

quit
