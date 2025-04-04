`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2024 03:26:19 PM
// Design Name: 
// Module Name: RingCounter
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

module RingCounter(
    input clk,
    input digsel,
    output [3:0] sel
    );
    
    FDRE # (.INIT(1'b0)) rc1 (.C(clk), .R(1'b0), .CE(digsel), .D(sel[0]), .Q(sel[1]));
    FDRE # (.INIT(1'b0)) rc2 (.C(clk), .R(1'b0), .CE(digsel), .D(sel[1]), .Q(sel[2]));
    FDRE # (.INIT(1'b0)) rc3 (.C(clk), .R(1'b0), .CE(digsel), .D(sel[2]), .Q(sel[3]));
    FDRE # (.INIT(1'b1)) rc4 (.C(clk), .R(1'b0), .CE(digsel), .D(sel[3]), .Q(sel[0]));
    
endmodule

