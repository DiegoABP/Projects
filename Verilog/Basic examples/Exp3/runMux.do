vlib ./work

vlog -work work ../Exp3/Mux.v
vlog -work work ../Exp3/MuxTB.v

vsim MuxTB

#run full sim or part of it..
run -all
#run 10 us

quit
