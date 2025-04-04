`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 10:54:27 AM
// Design Name: 
// Module Name: Pixel_address
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


module Pixel_address(
    input clk, GG,
    output led,
    output outlands,
    output [14:0] Vrow, Hcol
    );
    
    wire [14:0] R, C;
    assign R = (Hcol == 15'd799);
    assign C = (Hcol == 15'd799) & (Vrow == 15'd524) ;
    FDRE # (.INIT(1'b0)) trid (.C(clk), .R(1'b0), .CE(outlands), .D(1'b0), .Q(led));
    assign outlands = C;
    countUD15L rows (.clk(clk), .UD(1'b0), .CE(1'b1), .LD(R), .Din(15'b0), .Q(Hcol));
    /////////////////////////THIS IS WRON FOR THE CCCC VALUES LOOOOK AT IT CLOSER 
    countUD15L cols (.clk(clk), .UD(~(Hcol == 15'd799) ), .CE((Hcol == 15'd799)), .LD(C), .Din(15'b0), .Q(Vrow));


endmodule
