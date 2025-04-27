module top (
    input  logic clk,
    input  logic reset,
    input  logic rx,
    output logic tx,
    output logic [3:0]led,
    inout [5:0]gpios
);

logic [7:0] leds;

assign led = leds[3:0];


endmodule
