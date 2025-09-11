vlog tb.v
vsim tb +test_name=consecutive
do wave.do
#add wave -r sim:/tb/dut/*
run -all
