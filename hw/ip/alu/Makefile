
.PHONY: all run clean

all:  run

alu.sv.stamp: alu.sv
	touch $@
	vlog $<

tb_alu.sv.stamp: tb_alu.sv
	touch $@
	vlog $<

run: alu.sv.stamp tb_alu.sv.stamp
	vsim -c tb_alu -do "run -a ; q"

clean:
	rm -rf transcript *.wlf work *.stamp


