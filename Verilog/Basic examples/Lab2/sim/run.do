vlib ./work

vlog -work work ../src/low.v
vlog -work work ../src/top.v
vlog -work work ../src/top_tb.v

vsim top_tb

#run full sim or part of it..
run -all
#run 10 us

quit
