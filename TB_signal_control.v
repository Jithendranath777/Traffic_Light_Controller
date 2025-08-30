`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/27/2025 07:01:20 PM
// Design Name: 
// Module Name: TB_signal_control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//==========================================================
// Testbench for Traffic Signal Controller (sig_control)
//==========================================================

module TB_signal_control;

// DUT I/O
wire [1:0] MAIN_SIG, CNTRY_SIG;
reg CAR_ON_CNTRY_RD;
reg CLOCK, CLEAR;

// Instantiate the DUT
// Instantiate signal controller with named mapping
sig_control SC (
    .hwy(MAIN_SIG),
    .cntry(CNTRY_SIG),
    .X(CAR_ON_CNTRY_RD),
    .clock(CLOCK),
    .clear(CLEAR)
);


//----------------------------------------------------------
// Monitor values
//----------------------------------------------------------
initial begin
    $monitor($time, " ns | Main Sig = %b | Country Sig = %b | Car_on_cntry = %b",
             MAIN_SIG, CNTRY_SIG, CAR_ON_CNTRY_RD);
end

//----------------------------------------------------------
// Clock Generation (10ns period -> 100 MHz simulation clock)
//----------------------------------------------------------
initial begin
    CLOCK = 1'b0;
    forever #5 CLOCK = ~CLOCK;
end

//----------------------------------------------------------
// Reset / Clear signal control
//----------------------------------------------------------
initial begin
    CLEAR = 1'b1;                 // Assert reset
    repeat (5) @(negedge CLOCK);  // Hold reset for 5 cycles
    CLEAR = 1'b0;                 // Deassert reset
end

//----------------------------------------------------------
// Apply stimulus
//----------------------------------------------------------
initial begin
    CAR_ON_CNTRY_RD = 1'b0;

    repeat(20) @(negedge CLOCK); CAR_ON_CNTRY_RD = 1'b1;
    repeat(10) @(negedge CLOCK); CAR_ON_CNTRY_RD = 1'b0;
    repeat(20) @(negedge CLOCK); CAR_ON_CNTRY_RD = 1'b1;
    repeat(10) @(negedge CLOCK); CAR_ON_CNTRY_RD = 1'b0;
    repeat(20) @(negedge CLOCK); CAR_ON_CNTRY_RD = 1'b1;
    repeat(10) @(negedge CLOCK); CAR_ON_CNTRY_RD = 1'b0;

    repeat(10) @(negedge CLOCK); 
    $stop;   // End simulation
end

endmodule
