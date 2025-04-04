`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2024 11:16:46 AM
// Design Name: 
// Module Name: GameMachine
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


module GameMachine(
    input Go, Hit, clk,
    output StartGame, Idle, GG,
    output [15:0] led
    );
    wire [2:0] NS, PS;
    
    FDRE # (.INIT(1'b1)) trid (.C(clk), .R(1'b0), .CE(1'b1), .D(NS[0]), .Q(PS[0]));
    FDRE # (.INIT(2'b00)) trid2[2:1] (.C({2{clk}}), .R({2{1'b0}}), .CE({2{1'b1}}), .D(NS[2:1]), .Q(PS[2:1]));
    
    
    //game hasnt staarteed idle
    assign NS[0] = PS[0] & ~Go;
    //game starts no hit
    assign NS[1] = (PS[0] & Go) |(PS[1]& ~Hit);
    //hit and game over 
    assign NS[2] = (PS[1] & Hit) | PS[2];
   
    assign StartGame = PS[1];
    assign GG = PS[2];
endmodule
