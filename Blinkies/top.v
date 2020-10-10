////////////////////////////////////////////////////////////////////////////////
// Company:     Ridotech
// Engineer:    Juan Manuel Rico
// Create Date: 10/10/2020
// Module Name: top.v
//
// Description: Blinkies top module.
//
// Dependencies: 
//
// Revisions: 
//     0.01 - File created.
//
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
module top (
    input wire CLK,         // System clock (16Mhz).

    output wire USBPU,      // USB pull resistor.
    output wire PIN_14      // LED.
);

    // Drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

    // Generated 50Mhz clock.
    wire test_clk;

    pxClkGen pxClkGen_0 (
        .sys_clk (CLK),
        .px_clk (test_clk)
    );

    // 50Mhz / 2^25 = 1.49Hz ~ 0.671s
    assign PIN_14 = counter[25];

    // Slow counter.
    reg [27:0] counter = 0;
    always @(posedge test_clk)
    begin
        counter <= counter + 1;
    end

endmodule
