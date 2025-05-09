module full_adder(
    input  logic [31:0] FA_A_i,
    input  logic [31:0] FA_B_i,
    output logic [31:0] FA_R_o,
    input  logic [1:0] FA_SIZE_i,
    input  logic FA_OP_i
);
    // O FA_OP_i indica o módulo de operação:
    // 0: sum
    // 1: sub

    // FA_SIZE_i indica qual o tamanho dos blocos:
    // 00:      1 operação  de 32 bits
    // 01:      2 operações de 16 bits
    // 10:      4 operações de 8 bits
    // default: 1 operação  de 32 bit, mas pode ser usada para operações de 64

    logic [2:0] carry;
    logic [2:0] carry_enable;

    logic [31:0] FA_B_tmp;
    assign FA_B_tmp = FA_OP_i ? ~FA_B_i : FA_B_i;

    // Lógica para habilitar as variações
    always_comb begin
        case (FA_SIZE_i)
            2'b00: begin
                carry_enable = 3'b111;
            end
            2'b01: begin
                carry_enable = 3'b101;
            end 
            2'b10: begin
                carry_enable = 3'b000;
            end
            default: begin
                carry_enable = 3'b111;
            end
        endcase
    end


    eight_bit_adder u0_eight_bit_adder (
        .EBA_A_i(FA_A_i[7:0]),
        .EBA_B_i(FA_B_tmp[7:0]),
        .EBA_R_o(FA_R_o[7:0]),
        .EBA_C_i(FA_OP_i),
        .EBA_C_o(carry[0])
    );

    eight_bit_adder u1_eight_bit_adder (
        .EBA_A_i(FA_A_i[15:8]),
        .EBA_B_i(FA_B_tmp[15:8]),
        .EBA_R_o(FA_R_o[15:8]),
        .EBA_C_i((carry[0] & carry_enable[0]) | FA_OP_i),
        .EBA_C_o(carry[1])
    );

    eight_bit_adder u2_eight_bit_adder (
        .EBA_A_i(FA_A_i[23:16]),
        .EBA_B_i(FA_B_tmp[23:16]),
        .EBA_R_o(FA_R_o[23:16]),
        .EBA_C_i((carry[1] & carry_enable[1]) | FA_OP_i),
        .EBA_C_o(carry[2])
    );

    eight_bit_adder u3_eight_bit_adder (
        .EBA_A_i(FA_A_i[31:24]),
        .EBA_B_i(FA_B_tmp[31:24]),
        .EBA_R_o(FA_R_o[31:24]),
        .EBA_C_i((carry[2] & carry_enable[2]) | FA_OP_i),
        .EBA_C_o()
    );

endmodule