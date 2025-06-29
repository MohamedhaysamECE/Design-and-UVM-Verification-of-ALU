#vlib work
vlog -cover bcst -sv *.*v
vsim -coverage work.ALU_TOP

log -r /*
#add wave *
add wave -r sim:/ALU_TOP/intf1/*

run -all
coverage save counter_coverage.ucdb
coverage report -detail -cvg -codeAll > coverage_report.txt
quit
