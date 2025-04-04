`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2024 08:59:45 PM
// Design Name: 
// Module Name: VGA
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


module VGA(
    input [14:0] H, V, RP, LP,
    input [3:0] R1, G1, B1,
    output [3:0] R, G, B, 
    input clk, Hsync, Vsync, btnC
    );
    wire top, bott, left, right;
    wire [3:0] borders, valid;
    assign top = ((V<= 15'd7) & (V >= 15'd0)) & ((H<=15'd639) & (H >= 15'd0));
    assign bott = ((V<= 15'd479) & (V >= 15'd472)) & ((H<=15'd639) & (H >= 15'd0));
    assign left = ((V<= 15'd479) & (V >= 15'd0)) & ((H<=15'd8) & (H >= 15'd0));
    assign right = ((V<= 15'd479) & (V >= 15'd0)) & ((H<=15'd639) & (H >= 15'd632));
    assign borders = {4{left}} | {4{bott}} | {4{top}} | {4{right}};
    assign valid = ({4{(V>=15'd0)}}) & ({4{(V<=15'd479)}}) & ({4{(H<=15'd639)}}) & ({4{(H>=15'd0)}});

//    Slug Slugger(
//    .H(H), 
//    .V(V),
//    .R(R1), 
//    .G(G1), 
//    .B(B1),
//    .LP(LP),
//    .RP(RP)
//    );
    

        
    assign G = (4'b1111 & {4{borders}});
    assign B = (4'b1111 & {4{borders}});
    assign R = (4'b1111 & {4{borders}});
    
    
endmodule
