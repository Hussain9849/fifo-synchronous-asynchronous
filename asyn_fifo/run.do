vlog tb.v
vsim tb +test_name=underflow
do wave.do
#add wave -r sim:/tb/dut/*
run -all
