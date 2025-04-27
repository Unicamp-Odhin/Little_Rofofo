read_verilog -sv main.sv


set_param general.maxThreads 16

read_xdc "pinout.xdc"

# synth
synth_design -top "top" -part "xc7a100tcsg324-1"

# place and route
opt_design
place_design
route_design

# write bitstream
write_bitstream -force "./build/out.bit"