`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2024 08:43:55 PM
// Design Name: 
// Module Name: Syncs
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


module Syncs(
    input [14:0] V, H,
    output Hsync, Vsync
    );
    assign Vsync = ~((V <= 15'd490) & (V >= 15'd489));
  
    assign Hsync = ~((H >= 15'd655) & (H <= 15'd750));

endmodule
