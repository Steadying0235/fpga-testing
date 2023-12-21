module led(
    input clk, // 27 MHz onboard clock
    output reg IO_voltage // Connect to an LED
);

// Crystal oscillator frequency is 27 MHz
parameter Clock_frequency = 27_000_000;
// The number of times needed to time 0.5 seconds
parameter count_value = Clock_frequency / 2 - 1;

reg [23:0] count_value_reg;
reg count_value_flag;

always @(posedge clk) begin
    if (count_value_reg < count_value) begin
        count_value_reg <= count_value_reg + 1;
    end else begin
        count_value_reg <= 0;
        IO_voltage <= ~IO_voltage; // Toggle the LED
    end
end

endmodule
