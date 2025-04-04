`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/28/2024 03:53:29 PM
// Design Name: 
// Module Name: countUD15L
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



module countUD15L(
    input UD,
   // input increment,
    input clk,
    input CE,
    input LD,
    input [14:0] Din,
    output UTC,
    output DTC,
    output [14:0] Q
    );
    wire UTC0, UTC1, UTC2, DTC0, DTC1, DTC2;
 //   wire[2:0] val;
   // wire[2:0] val2;
    
    countUD5L c1 (.clk(clk), .UD(UD), .CE(CE), .LD(LD), .Din(Din[4:0]), .UTC(UTC0), .DTC(DTC0), .Q(Q[4:0]));
    countUD5L c2 (.clk(clk), .UD(UD), .CE((CE & UTC0 & ~UD) | (UD & DTC0 & CE)), .LD(LD), .Din(Din[9:5]), .UTC(UTC1), .DTC(DTC1), .Q(Q[9:5]));
    countUD5L c3 (.clk(clk), .UD(UD), .CE((UTC1 & CE & UTC0 & ~UD) | (UD & CE & DTC0 & DTC1)), .LD(LD), .Din(Din[14:10]), .UTC(UTC2), .DTC(DTC2), .Q(Q[14:10]));
    // LD | CE & ((UD & UTC0 & UTC1 & CE)|(~UD & DTC0 & DTC1 & CE))
    
    assign UTC = UTC0 & UTC1 & UTC2;
    assign DTC = DTC0 & DTC1 & DTC2;
endmodule
