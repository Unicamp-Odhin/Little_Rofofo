yosys read_verilog LR.v

yosys synth_gowin -json ./build/out.json -abc9
