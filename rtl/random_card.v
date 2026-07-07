`timescale 1ns / 1ps

module random_card(
    input clk,
    input reset,
    input draw,
    output reg [3:0] rank
);

    reg [3:0] counter = 4'd1;

    always @(posedge clk) begin
        if (reset) begin           // begin resetting counter and rank if reset is high
            counter <= 4'd1;    // 4 bit value of decimal 1, ace = 1, use non blocking assignment
            rank <= 4'd1;        // 4 bit value of decimal 1, rank 1 = ace
        end else begin
            if (counter == 4'd13)   // checks if value is currently 13
                counter <= 4'd1;    // if it is 13, restart back to 1
            else
                counter <= counter + 1;      // otherwise just keep adding one to wherever the counter is at

            if (draw)
                rank <= counter;       // if draw is high (1), then save currently value into rank
        end
    end

endmodule



// Full clock-cycle example

// Let’s say reset is off and draw is off.

// Before clock edge:

// counter = 1
// rank = 1
// draw = 0

// After clock edge:

// counter = 2
// rank = 1

// Next clock:

// counter = 3
// rank = 1

// Next clock:

// counter = 4
// rank = 1

// The counter keeps spinning, but the output rank stays the same.

// Now suppose:

// counter = 9
// rank = 1
// draw = 1

// After that clock edge:

// counter = 10
// rank = 9

// The module drew a 9.