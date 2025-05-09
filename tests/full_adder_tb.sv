module full_adder_tb;

    // Entradas
    logic [31:0] FA_A_i;
    logic [31:0] FA_B_i;
    logic [1:0]  FA_SIZE_i;
    logic        FA_OP_i;

    // Saídas
    logic [31:0] FA_R_o;

    // Instância do módulo a ser testado
    full_adder dut (
        .FA_A_i(FA_A_i),
        .FA_B_i(FA_B_i),
        .FA_R_o(FA_R_o),
        .FA_SIZE_i(FA_SIZE_i),
        .FA_OP_i(FA_OP_i)
    );

    // Tarefa para testar uma operação e exibir o resultado
    task test_operation(input [31:0] a, input [31:0] b, input [1:0] size, input op);
        begin
            FA_A_i = a;
            FA_B_i = b;
            FA_SIZE_i = size;
            FA_OP_i = op;
            #10;  // espera a propagação
            $display("A = %h, B = %h, R = %h, SIZE = %b, OP = %b",
                       a, b, FA_R_o, size, op);
        end
    endtask

    initial begin
        $dumpfile("full_adder_tb.vcd");
        $dumpvars(0, full_adder_tb);
        $display("Iniciando testes do full_adder...");

        // Testes de soma (FA_OP_i = 0)
        $display("\nTestes de soma:");
        // 1 operação de 32 bits
        $display("Operação de 32 bits:");
        test_operation(32'h00000001, 32'h00000001, 2'b00, 0);
        test_operation(32'hFFFFFFFF, 32'h00000001, 2'b00, 0);
        test_operation(32'h12345678, 32'h87654321, 2'b00, 0);
        test_operation(32'h0000FFFF, 32'hFFFF0000, 2'b00, 0);
        // 2 operações de 16 bits
        $display("Operação de 16 bits:");
        test_operation(32'h12345678, 32'h87654321, 2'b01, 0);
        test_operation(32'hFFFF0000, 32'h0000FFFF, 2'b01, 0);
        test_operation(32'hFFFFFFFF, 32'h00000001, 2'b01, 0);
        test_operation(32'hABCD1234, 32'h1234ABCD, 2'b01, 0);
        // 4 operações de 8 bits
        $display("Operação de 8 bits:");
        test_operation(32'h01020304, 32'h04030201, 2'b10, 0);
        test_operation(32'h7F807F80, 32'h80807F7F, 2'b10, 0);
        test_operation(32'hAABBCCDD, 32'hDDCCBBAA, 2'b10, 0);
        test_operation(32'h11223344, 32'h44332211, 2'b10, 0);
        test_operation(32'hFFFFFFFF, 32'h00000001, 2'b10, 0);
        test_operation(32'hFFFFFFFF, 32'h04030201, 2'b10, 0);


        // Testes de subtração (FA_OP_i = 1)
        $display("\nTestes de subtração:");
        // 1 operação de 32 bits
        $display("Operação de 32 bits:");
        test_operation(32'h00000002, 32'h00000001, 2'b00, 1);
        test_operation(32'h80000000, 32'h7FFFFFFF, 2'b00, 1);
        test_operation(32'h12345678, 32'h12340000, 2'b00, 1);
        test_operation(32'hFFFFFFFF, 32'h00000001, 2'b00, 1);
        // 2 operações de 16 bits
        $display("Operação de 16 bits:");
        test_operation(32'h12345678, 32'h12340000, 2'b01, 1);
        test_operation(32'hFFFF0000, 32'h0000FFFF, 2'b01, 1);
        test_operation(32'hABCD1234, 32'h1234ABCD, 2'b01, 1);
        test_operation(32'h0000FFFF, 32'hFFFF0000, 2'b01, 1);
        // 4 operações de 8 bits
        $display("Operação de 8 bits:");
        test_operation(32'h00000002, 32'h00000001, 2'b10, 1);
        test_operation(32'h0F0F0F0F, 32'h01010101, 2'b10, 1);
        test_operation(32'h0F0F0F0F, 32'h10100000, 2'b10, 1);
        test_operation(32'hF0F0F0F0, 32'h0F0F0F0F, 2'b10, 1);
        test_operation(32'hAAAAAAAA, 32'h55555555, 2'b10, 1);
        test_operation(32'h12345678, 32'h87654321, 2'b10, 1);

        $display("Testes finalizados.");
        $finish;
    end
endmodule
