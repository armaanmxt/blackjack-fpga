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
            if (counter == 4'd13)
                counter <= 4'd1;
            else
                counter <= counter + 1;

            if (draw)
                rank <= counter;
        end
    end

endmodule