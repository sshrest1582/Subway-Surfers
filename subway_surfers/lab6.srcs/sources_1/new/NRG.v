`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2024 09:44:25 PM
// Design Name: 
// Module Name: NRG
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


module NRG(
    input btnU,
    input clk,
    input Vscode,
    input run,
    input Mid,GG,
    input [14:0] col,
    output [3:0] G,
    input [14:0] H, V,
    output bars, empty
    
    );
    
    wire start, top, bott;
    wire [14:0] acid;
    
    assign bott = (V < 15'd300) & (V >= (15'd300 - acid ));
    assign top = (H >= 15'd20) & (H <= 15'd40);
    assign bars = top & bott;
    assign G = 4'b1111 & {4{bars}};
    assign empty = acid == 15'd0 ;
    FDRE #(.INIT(1'b1)) ff1 (.C(clk), .R(1'b0), .CE(1'b1  & ~GG), .D(1'b0), .Q(start));
    countUD15L call (.clk(clk), .CE(col &  Mid&(((acid > 15'd0)  & ~GG | (~btnU & ~GG)) & ((acid <= 15'd193) | btnU))& run), .UD(btnU), .LD(start), .Din(15'd193), .Q(acid));
endmodule
