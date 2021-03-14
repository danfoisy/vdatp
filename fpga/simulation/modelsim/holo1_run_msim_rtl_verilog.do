transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/FlashFifo.v}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/Sqrtf.v}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/Int2Float.v}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/MultK.v}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/Float2Int.v}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/Pll.v}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/PosColRam.v}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/CoeffMult.v}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/CoeffAdd.v}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5/db {D:/projects/holo/FPGA/Holo5/db/pll_altpll.v}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/QPIFlash.sv}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/pwm.sv}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/CalcPhase.sv}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/Reset.sv}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/led.sv}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/PwmCtrl.sv}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/Rotate1D.sv}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/Holo.sv}
vlog -sv -work work +incdir+D:/projects/holo/FPGA/Holo5 {D:/projects/holo/FPGA/Holo5/HoloTop.sv}

