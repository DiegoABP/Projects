vlib ./work

vlog -work work ../Exp4/Buffer.v
vlog -work work ../Exp4/BufferTB.v

vsim BufferTB

#run full sim or part of it..
run -all
#run 10 us

quit
