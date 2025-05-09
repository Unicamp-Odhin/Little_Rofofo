module full_adder(
    input  logic [31:0] FA_A_i,
    input  logic [31:0] FA_B_i,
    input  logic [1:0]  FA_OP_i,
    output logic [31:0] FA_R_o,
    input logic FA_C_i
);
    // O FA_OP_i indica o módulo de operação:
    // 00:        2 soma de 16 bits
    // 01:        4 soma de 08 bits
    // default:   1 soma de 32 bits

    logic [2:0] carry;
    logic [2:0] carry_enable;

    // Lógica para habilitar as variações
    always_comb begin
        case (FA_OP_i)
            2'b00: begin
                carry_enable = 3'b101;
            end
            2'b01: begin
                carry_enable = 3'b000;
            end
            default: begin
                carry_enable = 3'b111;
            end
        endcase
    end


    eight_bit_adder u0_eight_bit_adder (
        .EBA_A_i(FA_A_i[7:0]),
        .EBA_B_i(FA_B_i[7:0]),
        .EBA_R_o(FA_R_o[7:0]),
        .EBA_C_i(FA_C_i),
        .EBA_C_o(carry[0])
    );

    eight_bit_adder u1_eight_bit_adder (
        .EBA_A_i(FA_A_i[15:8]),
        .EBA_B_i(FA_B_i[15:8]),
        .EBA_R_o(FA_R_o[15:8]),
        .EBA_C_i(carry[0] & carry_enable[0]),
        .EBA_C_o(carry[1])
    );

    eight_bit_adder u2_eight_bit_adder (
        .EBA_A_i(FA_A_i[23:16]),
        .EBA_B_i(FA_B_i[23:16]),
        .EBA_R_o(FA_R_o[23:16]),
        .EBA_C_i(carry[1] & carry_enable[1]),
        .EBA_C_o(carry[2])
    );

    eight_bit_adder u3_eight_bit_adder (
        .EBA_A_i(FA_A_i[31:24]),
        .EBA_B_i(FA_B_i[31:24]),
        .EBA_R_o(FA_R_o[31:24]),
        .EBA_C_i(carry[2] & carry_enable[2]),
        .EBA_C_o()
    );

endmodule