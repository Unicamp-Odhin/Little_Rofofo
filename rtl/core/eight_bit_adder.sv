module eight_bit_adder(
    input  logic [7:0] EBA_A_i,
    input  logic [7:0] EBA_B_i,
    output logic [7:0] EBA_R_o,
    output logic EBA_ZR_o,
    input logic EBA_C_i,
    output logic EBA_C_o
);

    assign {EBA_C_o, EBA_R_o} = EBA_A_i + EBA_B_i + EBA_C_i;
    assign EBA_ZR_o = ~(|EBA_R_o);

endmodule