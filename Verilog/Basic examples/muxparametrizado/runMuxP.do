vlib ./work

vlog -work work ../muxparametrizado/MuxP.v
vlog -work work ../muxparametrizado/MuxPTB.v

vsim MuxPTB

#run full sim or part of it..
run -all
#run 10 us

quit
