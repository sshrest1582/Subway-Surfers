`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2024 12:38:22 PM
// Design Name: 
// Module Name: trainsm
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


module traincall(
    input clk, PC, Run, L,R, Relay, GG,Idle,
    input [14:0] V, sel,
    output Color, Signal, 
    output [14:0] points, TT
    );
    wire [14:0] botTrain, topTrain, delay;
    wire holdtrain;
    //randomlength 
    wire [7:0]LFG, LFGout, Delayout;
    LFSR lfg (.clk(clk), .run(1'b1 & ~GG),.Q(LFG));
    FDRE #(.INIT(8'b0)) RNG[7:0] (.C({8{clk}}), .CE({8{Relay  & ~GG}}), .D(LFG), .Q(LFGout));
    
    wire fall, summon;
    FDRE #(.INIT(1'b0)) falling (.C(clk), .R(topTrain >= 15'd479), .CE(Relay & ~GG), .D(1'b1), .Q(fall));
   
    
    assign TT = topTrain;
        
    countUD15L bottomtrainL(
    .clk(clk), 
    .UD(1'b0),//fall
    .CE( PC & fall & ~GG & (botTrain <= 479)),
    //ld w     
    .LD(topTrain >= 479), 
    .Din(15'd0), 
    .Q(botTrain));
    

    
    countUD15L top(
    .clk(clk), 
    .UD(1'b0),
    .LD(topTrain >= 479),
    .CE(PC & fall  & ~GG& ( botTrain >=(15'd60 +LFGout[4:0]))),     
    .Din(15'd0), 
    .Q(topTrain)
    );
    
    assign Color = ((V >=topTrain) & (V <= botTrain)) & L & R ;
    
    countUD15L delaytimer(
    .clk(clk), 
    .UD(1'b0),                       
    .CE(PC & Run & ~GG),    
    .LD(topTrain == 400), 
    .Din(15'd0), 
    .Q(delay));
    assign Signal = ~GG &(botTrain == sel);
    
    countUD15L pointer(.clk(clk),.UD(1'b0),.CE((topTrain == 312) & ~GG),  .LD(1'b0),.Din(15'd0), .Q(points));  

endmodule
