
.PHONY: all build run clean

all: build run

build:
	vlog alu.sv tb_alu.sv

run:
	vsim -c tb_alu -do "run -a ; q"

clean:
	rm -rf transcript *.wlf work


