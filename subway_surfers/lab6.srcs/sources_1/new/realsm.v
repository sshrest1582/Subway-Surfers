`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2024 03:37:32 AM
// Design Name: 
// Module Name: realsm
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


module realsm(
    input btnC, Signal, Signal2,clk,GG,
    output S1, S2
 
    );
    wire [2:0] PS, NS;
    FDRE # (.INIT(1'b1)) rc1 (.C(clk), .R(1'b0), .CE(1'b1 & ~GG), .D(NS[0]), .Q(PS[0]));
    FDRE # (.INIT(2'b0)) rc2[2:1] (.C({2{clk}}), .R({2{1'b0 }}), .CE({2{1'b1& ~GG}}), .D(NS[2:1]), .Q(PS[2:1]));
    
    assign NS[0] = (PS[0] | PS[1] | PS[2]) & (~Signal | ~Signal2);
    assign NS[1] = (PS[0] & Signal);
    assign NS[2] = (PS[0] & Signal2) ;
    //assign NS[3] = (PS[3] & ~Signal) | PS[0] & Signal2
    assign S1 = NS[1] & ~GG;
    assign S2 =  NS[2] & ~GG;


 
    
    
    
endmodule
