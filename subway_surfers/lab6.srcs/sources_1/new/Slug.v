`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 03:57:43 PM
// Design Name: 
// Module Name: Slug
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


module Slug(
    input [14:0] H, V,
    input Vsync, clk,btnU, btnC, btnL, btnR,Hit,GG,
    output  Mid,slug,
    output [3:0] R, G, B,
    output [15:0] led
    
   
    );
     //input [14:0] LP, RP
    wire[14:0] LP, RP;
    wire top, bott;
    assign R = 4'b1111 & {4{slug}};
    assign B = 4'b0000 & {4{slug}};
    assign G = 4'b1111 & {4{slug}};
    assign top = (V<=15'd328) & (V>= 15'd312) ; 
    assign bott = (H<=RP) & (H>= LP) ;
    assign slug = bott && top;
    wire SL, SR, hover;

    wire eggy1, eggy0;
    SlugSM(
    .btnR(btnR), 
    .btnL(btnL), 
    .led(led),
    .btnC(btnC), 
    .btnU(btnU),
    .clk(clk),
    .LP(LP), 
    .GG(GG),
    .RP(RP),
    .SL(SL), 
    .SR(SR), 
    .hover(hover),
    .Hit(Hit),
//    .Start(Start),
   // .Run(Run),

    .Mid(Mid)
    );
    
    Edge edging(
    .btnU(Vsync & ~GG),
    .clk(clk),
    .edger(eggy0)
    );
    
    Edge edger(
    .btnU(~Vsync & ~GG),
    .clk(clk),
    .edger(eggy1)
    );
   
    wire [14:0] load1, load2;
    FDRE # (.INIT(1'b1)) MPS (.C(clk), .R(1'b0), .CE(1'b1), .D(1'b0), .Q(load1));
    FDRE # (.INIT(1'b1)) MPS2 (.C(clk), .R(1'b0), .CE(1'b1), .D(1'b0), .Q(load2));
    countUD15L edgecounter(.clk(clk), .CE(~GG & ((eggy0|eggy1) & (SR | SL))), .UD((1'b1 &  SL) | (1'b0 & SR)) ,.LD(load1), .Din(15'd352), .Q(LP));
    
    countUD15L edgry(.clk(clk), .CE(~GG & ((eggy0|eggy1) & (SR | SL))), .UD((1'b1 &  SL) | (1'b0 & SR)) ,.LD(load1), .Din(15'd368), .Q(RP));
    
endmodule

