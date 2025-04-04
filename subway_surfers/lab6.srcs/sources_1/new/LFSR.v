`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2024 03:49:26 PM
// Design Name: 
// Module Name: LFSR
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


module LFSR(
    input clk,
    input run,
    output [7:0] Q
    );
    

    
    FDRE #(.INIT(1'b1) ) FF_0 (.C(clk), .R(1'b0), .CE(run), .D(Q[0]^Q[5]^Q[6]^Q[7]), .Q(Q[0]));
    
    FDRE #(.INIT(1'b0) ) FF_1 (.C(clk), .R(1'b0), .CE(run), .D(Q[0]), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) FF_2 (.C(clk), .R(1'b0), .CE(run), .D(Q[1]), .Q(Q[2]));
    FDRE #(.INIT(1'b0) ) FF_3 (.C(clk), .R(1'b0), .CE(run), .D(Q[2]), .Q(Q[3]));
    FDRE #(.INIT(1'b0) ) FF_4 (.C(clk), .R(1'b0), .CE(run), .D(Q[3]), .Q(Q[4]));
    FDRE #(.INIT(1'b0) ) FF_5 (.C(clk), .R(1'b0), .CE(run), .D(Q[4]), .Q(Q[5]));
    FDRE #(.INIT(1'b0) ) FF_6 (.C(clk), .R(1'b0), .CE(run), .D(Q[5]), .Q(Q[6]));
    FDRE #(.INIT(1'b0) ) FF_7 (.C(clk), .R(1'b0), .CE(run), .D(Q[6]), .Q(Q[7]));
    
endmodule
