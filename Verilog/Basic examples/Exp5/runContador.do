vlib ./work

vlog -work work ../Exp5/Contador.v
vlog -work work ../Exp5/ContadorTB.v

vsim ContadorTB

#run full sim or part of it..
run -all
#run 10 us

quit
