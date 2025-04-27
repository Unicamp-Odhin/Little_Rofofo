module top (
    input  logic clk,
    input  logic CPU_RESETN,

    output logic [15:0]LED,

    input  logic mosi,
    output logic miso,
    input  logic sck,
    input  logic cs,

    output logic M_CLK,      // Clock do microfone
    output logic M_LRSEL,    // Left/Right Select (Escolha do canal)

    input  logic M_DATA,     // Dados do microfone

    output logic [7:0] JC
);


endmodule
