`timescale 1ns / 1ps
`define Y2RDELAY 3  // Yellow → Red delay
`define R2GDELAY 2  // Red → Green delay

module sig_control(
    output reg [1:0] hwy, cntry,   // Highway & Country lights
    input X, clock, clear          // Inputs
);

parameter RED=2'd0, YELLOW=2'd1, GREEN=2'd2;
parameter S0=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4;

reg [2:0] state, next_state;

// State register
always @(posedge clock)
    state <= clear ? S0 : next_state;

// Output logic
always @(state) begin
    hwy=GREEN; cntry=RED;     // defaults
    case(state)
        S1: hwy=YELLOW;
        S2: hwy=RED;
        S3: begin hwy=RED; cntry=GREEN; end
        S4: begin hwy=RED; cntry=YELLOW; end
    endcase
end

// Next-state logic
always @(state or X) begin
    case(state)
        S0: next_state = X ? S1 : S0;
        S1: begin repeat(`Y2RDELAY) @(posedge clock); next_state=S2; end
        S2: begin repeat(`R2GDELAY) @(posedge clock); next_state=S3; end
        S3: next_state = X ? S3 : S4;
        S4: begin repeat(`Y2RDELAY) @(posedge clock); next_state=S0; end
        default: next_state = S0;
    endcase
end
endmodule
