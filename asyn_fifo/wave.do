onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/wr_clk
add wave -noupdate /tb/dut/rd_clk
add wave -noupdate /tb/dut/res
add wave -noupdate /tb/dut/wr_en
add wave -noupdate /tb/dut/rd_en
add wave -noupdate -radix unsigned /tb/dut/wdata
add wave -noupdate -radix unsigned /tb/dut/rdata
add wave -noupdate /tb/dut/full
add wave -noupdate /tb/dut/empty
add wave -noupdate /tb/dut/overflow
add wave -noupdate /tb/dut/underflow
add wave -noupdate -radix unsigned /tb/dut/wr_ptr
add wave -noupdate -radix unsigned /tb/dut/rd_ptr
add wave -noupdate -radix unsigned /tb/dut/wr_ptr_rd_clk
add wave -noupdate -radix unsigned /tb/dut/rd_ptr_wr_clk
add wave -noupdate /tb/dut/wr_toggle_f
add wave -noupdate /tb/dut/rd_toggle_f
add wave -noupdate /tb/dut/wr_toggle_f_rd_clk
add wave -noupdate /tb/dut/rd_toggle_f_wr_clk
add wave -noupdate /tb/dut/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {510 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 214
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {133 ps} {531 ps}
