`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2024 08:44:10 PM
// Design Name: 
// Module Name: SlugSM
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


module SlugSM(
    input btnR, btnL, btnC, btnU,
    input empty, clk,Hit,GG,
    input [14:0] LP, RP,
    output SL, SR, hover ,Mid,
    output [8:0] PS,
    output [15:0] led
    );
    wire [8:0] NS;
    wire [14:0]  ML, MR, RR, RL, LL, LR;
    assign ML = (LP == 15'd352);
    assign MR = (RP == 15'd368);
    assign LL = (LP == 15'd282);
    assign LR = (RP == 15'd298);
    assign RL = (LP == 15'd422);
    assign RR = (RP == 15'd438);
    
    FDRE # (.INIT(1'b1)) rc1 (.C(clk), .R(1'b0), .CE(1'b1 & ~GG), .D(NS[0]), .Q(PS[0]));
    FDRE # (.INIT(8'b0)) rc2[8:1] (.C({8{clk}}), .R({8{1'b0}}), .CE({8{1'b1}}), .D(NS[8:1]), .Q(PS[8:1]));
    
    
    //game hasnt staarteed idle
    assign NS[0] = PS[0] & ~btnC;
    //game starts mid
    assign NS[1] = (PS[0] & btnC) |(PS[1]& ~btnL & ~btnR) | ((PS[4]|PS[7]) & (MR & ML));
    //left movement 
    assign NS[2] = (~(LL & LR) & PS[2] & ~PS[4]) | (btnL & ~btnR & PS[1]); //m->l
    assign NS[3] = (PS[2] & (LL & LR) & ~(RR & RL) ) | (PS[3] & (LL & LR));//left
    assign NS[4] = (~PS[2] & btnR & ~btnL & PS[3]) | (PS[4] & ~(MR & ML));//l->2
    //SLIDE RIGHT 
    assign NS[5] = (btnR & ~btnL & PS[1]) | (PS[5] & ~(RR & RL) & ~PS[7]);//m->r
    assign NS[6] = (PS[6] & (RR & RL)) | (PS[5] & (RR & RL) & ~(LL & LR)) ;//right
    assign NS[7] = (PS[6] & btnL & ~btnR & ~PS[5]) | (PS[7] & ~(MR & ML));//r->m
    //HOVER
    assign NS[8] = ((PS[1] |PS[2] |PS[3] |PS[4] |PS[5] |PS[6] |PS[7] | PS[8]) & Hit )| PS[8];
    
    assign Mid = MR & ML;
    


    assign SL  = (PS[2] | PS[7])& ~btnU  & ~GG ;
    assign SR  = (PS[4]| PS[5]) & ~btnU  & ~GG;

    
    
endmodule
