vlib ./work

vlog -work work ../Aludefinitiva/adder.v
vlog -work work ../Aludefinitiva/ALU.v
vlog -work work ../Aludefinitiva/carry_lookahead_adderr.v
vlog -work work ../Aludefinitiva/decremento.v
vlog -work work ../Aludefinitiva/incremento.v
vlog -work work ../Aludefinitiva/ALUTB.v
vlog -work work ../Aludefinitiva/subtractor.v
vlog -work work ../Aludefinitiva/shift.v
vlog -work work ../Aludefinitiva/logicacomb.v


vsim ALUTB

#run full sim or part of it..
run -all
#run 10 us

quit
