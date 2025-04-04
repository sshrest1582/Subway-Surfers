`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2024 10:31:54 AM
// Design Name: 
// Module Name: topmod
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


module topmod(
    input [15:0] sw,
    input btnU,
    input btnD,
    input btnC,
    input btnL,
    input btnR,
    input clkin,
    output [15:0] led,
    output [3:0] an,
    output [6:0] seg,
    output Hsync,
    output Vsync,
    output dp,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue
    );
    //wires for vga
    wire clk, digsel, GG;
    assign dp = 1'b0;
    labVGA_clks vgacalls(
    .clkin(clkin),
    .greset(btnD),  
    .clk(clk),
    .digsel(digsel));
    
    //wires for pixel address
    wire [14:0] V, H;
    wire PC;
    Pixel_address pixies(
    .clk(clk),
    .led(led[5]),
    .Vrow(V),
    .GG(GG),
    .Hcol(H),
    .outlands(PC)
    );
    
    wire SyncH, SyncV;
    Syncs he_scores(
     .V(V), 
     .H(H),
     .Hsync(SyncH), 
     .Vsync(SyncV)
    );
    
    FDRE # (.INIT(1'b1)) f1 (.C(clk), .R(1'b0), .CE(1'b1), .D(SyncH), .Q(Hsync));
    FDRE # (.INIT(1'b1)) f2 (.C(clk), .R(1'b0), .CE(1'b1), .D(SyncV), .Q(Vsync));
    wire Hit, Start, Run, Phase, gamestart;
    wire Go, Left, Right, Hover, gogo;
    FDRE # (.INIT(1'b0)) hoverd (.C(clk), .R(1'b0), .CE(1'b1), .D(btnU), .Q(Hover));
    FDRE # (.INIT(1'b0)) go (.C(clk), .R(1'b0), .CE(1'b1), .D(btnC), .Q(Go));
    FDRE # (.INIT(1'b0)) rights (.C(clk), .R(1'b0), .CE(1'b1), .D(btnR), .Q(Right));
    FDRE # (.INIT(1'b0)) lefts (.C(clk), .R(1'b0), .CE(1'b1), .D(btnL), .Q(Left));
    wire loader;
    wire done;
    GameMachine gamer(.Go(Go), .Hit(Hit), .clk(clk),.StartGame(Run), .GG(GG),.Idle(loader));

    //FDRE #(.INIT(1'b0)) over(.C(clk), .CE(done), .D(1'b1), .Q(GG));
//
    wire [3:0] spitten;

    //wires for vga
    wire [3:0] R, B, G;
    wire [3:0] r, g, b;
    wire empty, sammy;
    assign empty = 15'd236;   
   //wire [14:0] LP, RP;
    VGA vbg(
    .H(H), 
    .V(V),
    .Hsync(Hsync),
    .Vsync(Vsync),
    .btnC(Go),
    .clk(clk),
    .R(R), 
    .G(G), 
    .B(B)
    );

    wire Mid;
     Slug Slugger(
    .H(H), 
    .V(V),
    .Vsync(Vsync),
    .btnR(Right), 
    .btnL(Left), 
    .btnC(Go),
    .GG(GG), 
    .led(led),
    .btnU(Hover),
    .clk(clk),
    .Hit(Hit),

    .slug(sammy),
    .R(r), 
    .G(g),
    .Mid(Mid), 
    .B(b)

    );
       
    

    
    NRG cloud9(
    .btnU(btnU),
    .clk(clk),
    .Vscode(Vsync),
    .col(PC),
    .run(Run),
    .GG(GG),
    .Mid(Mid),
    .G(spitten),
    .H(H), 
    .empty(empty),
    .V(V)
    );
    

    wire [14:0]train_timer;
    wire two2,two, six, frame;
    //TIMER UD
    //use ~latch to turn on then set latch so when two is high stay high and stop 
    countUD15L timetrack (.clk(clk), .CE(frame & Run&~GG ),.UD(1'b0), .LD(15'b0), .Din(15'd0), .Q(train_timer));
    FDRE #(.INIT(1'b0)) leftotright(.C(clk), .CE( ~GG&(train_timer == 120)), .D(1'b1), .Q(two));
    FDRE #(.INIT(1'b0)) Midasd(.C(clk), .CE((train_timer <= 360) & ~GG), .D(1'b1), .Q(six));  
    wire RV, MV;
    assign MV = six ;
    assign RV = two ;
  //   FDRE # (.INIT(1'b1)) f2 (.C(clk), .R(1'b0), .CE(1'b1), .D(SyncV), .Q(Vsync));
    wire six2;
    assign two2 = ~|(train_timer ^ 15'd120);
    assign six2 = ~|(train_timer ^ 15'd360);    


    
    wire sumL1, sumL2, sumR1,sumR2,sumM1, sumM2;
    wire Ltrain2, Ltrain1, LtrainOut,LtrainOut2;
    wire [7:0] LLFG2, LLFG1;
    assign frame = PC;
    

        
    wire Rtrain2, Rtrain1, RtrainOut, RtrainOut2;

    
    wire Mtrain2, Mtrain1, MtrainOut,  MtrainOut2;

    wire [14:0] botTrain, topTrain;
    wire MLP, RLP, LLP, MRP, LRP, RRP;
    assign MLP =(H >= 16'd330);
    assign MRP = ((H <= 16'd390));
    assign LLP =(H >= 16'd260);
    assign LRP = ((H <= 16'd320));
    assign RLP =(H >= 16'd400);
    assign RRP = ((H <= 16'd460));
    
    wire [14:0] P1, P2, P3, P4, P5, P6,L1,L2,R1,R2,M1,M2;
    wire L2sig, R2sig, M2sig, M1sig, L1sig, R1sig , calling;
    wire SUML1, SUML2;
    realsm left(
     .Signal(L1sig & ~GG ), .Signal2((L2sig&~GG)|(Go&~GG)),.clk(clk),
    .S1(SUML1), .S2(SUML2)
    );

    traincall Ltrsdain1(.GG(GG),
    .clk(clk), .TT(L1),.PC(PC & ~GG),.points(P1), .Run(Run & ~GG),.sel(15'd400),.Idle(loader), .Relay(SUML2 & ~GG), .L(LLP), .R(LRP),.V(V),.Color(Ltrain1),.Signal(L1sig));
    
    traincall Ltrdain2(
    .clk(clk), .TT(L2),.PC(PC & ~GG),.points(P2), .Run(Run & ~GG),.sel(15'd400),  .Idle(loader),.Relay(SUML1 &~GG),.L(LLP), .R(LRP),.V(V),.Color(Ltrain2),.Signal(L2sig ));        

    wire SUMR1, SUMR2, Rsig;
    realsm right(.GG(GG),
     .Signal(R1sig), .Signal2(R2sig|(two2)),.clk(clk),
    .S1(SUMR1), .S2(SUMR2)
    );
    
    traincall Rtrain(.GG(GG),
    .clk(clk), .PC(PC),.TT(R1), .Run(Run&~GG),.points(P3),.sel(15'd400),.Idle(loader), .Relay(SUMR2& ~GG),.L(RLP), .R(RRP),.V(V),.Color(Rtrain1),.Signal(R1sig));
    
    traincall R2train2(.GG(GG),
    .clk(clk), .PC(PC), .TT(R2),.Run(Run&~GG),.sel(15'd400), .points(P4),.Idle(loader),.Relay(SUMR1& ~GG), .L(RLP), .R(RRP),.V(V),.Color(Rtrain2),.Signal(R2sig));
 

    wire SUMM1, SUMM2;
    realsm MIDSF(.GG(GG),
     .Signal(M1sig), .Signal2(M2sig| six2),.clk(clk),
    .S1(SUMM1), .S2(SUMM2)
    );
    traincall MIDSFS(.GG(GG),
    .clk(clk), .PC(PC), .TT(M1),.Run(Run&~GG),.sel(15'd440),.Idle(loader), .Relay(SUMM2& ~GG),.points(P5),.L(MLP), .R(MRP),.V(V),.Color(Mtrain1),.Signal(M1sig));
    
    traincall M2train2(.GG(GG),
    .clk(clk), .PC(PC), .TT(M2),.Run(Run&~GG),.sel(15'd440), .Idle(loader),.Relay(SUMM1& ~GG), .L(MLP), .points(P6),.R(MRP),.V(V),.Color(Mtrain2),.Signal(M2sig));
    assign Hit = ~Phase &~sw[3]&(sammy & (Ltrain2 | Rtrain2| Mtrain2| Mtrain1 | Rtrain1 | Ltrain1));
     //~Phase ~Phase
     wire [15:0]frankly, pew;
     wire [3:0] fleshing, fp;
   //assign led[15] = Hit;
    assign Phase = Run & ~empty & Mid & btnU;
    
    wire flashsig, flashs, score1;
    wire [14:0] flashC, flashD, score;
//    countUD15L counts(.clk(clk), .CE(PC & Phase),.LD(btnD),.UD(1'b0), .Din(5'b0),.Q(flashC));
//    assign flashsig = flashC[2];
    assign score = L1 ==10'd380 |L2==10'd380|R1==10'd380|R2==10'd380|M1==10'd380|M2==10'd380;
    wire[3:0] ringO, selO;
    Edge CALLS(.clk(clk), .btnU(score), .edger(score1));
    
    wire [15:0] tott;
    RingCounter ringcounter(.clk(clk), .digsel(digsel), .sel(ringO));
    countUD15L countsdsd(.clk(clk), .CE(score1),.LD(1'b0),.UD(1'b0), .Din(1'b1),.Q(tott));
    Selector select(.N({8'b0000000,tott[7:0]}), .sel(ringO), .H(selO));
    
    hex7seg hex(.n(selO), .seg(seg));
    assign an[0] = ~ringO[0];
    assign an[1] = ~ringO[1];
    assign an[2] = 1'b1;//~ringO[2];
    assign an[3] = 1'b1;//~ringO[3];
    assign dp = 1'b1;
    
    countUD15L countsd(.clk(clk), .CE((PC & GG)|(PC & Phase)),.LD(btnD),.UD(1'b0), .Din(5'b0),.Q(flashD));
   assign flashs = flashD[2];
   assign vgaBlue = {2{sammy & flashs}} & 4'b0000| {4{sammy & ~flashsig}}& 4'b0000 |{4{sammy & ~flashs}} & 4'b1111|b | B | ({4{Ltrain2}} & 4'b1111) | ({4{Ltrain1}} & 4'b1111) | ({4{Rtrain2 }} & 4'b1111)|({4{Mtrain2}} & 4'b1111)|({4{Mtrain1}} & 4'b1111) |({4{Rtrain1}} & 4'b1111) ;//trainB | testtrainB;
   assign vgaRed = {2{sammy & flashs}} & 4'b0000|{4{sammy & ~flashsig}}& 4'b1111 |r | R |({4{Ltrain1 }} & 4'b0000) |({4{Ltrain2 }} & 4'b0000) |({4{Rtrain1}} & 4'b0000)|({4{Rtrain2}} & 4'b0000) |({4{Mtrain1}} & 4'b0000)|({4{Mtrain2}} & 4'b0000);
   assign vgaGreen = {2{sammy & ~flashs}} & 4'b1111 |g |{4{sammy & ~flashsig}}& 4'b1111| G | spitten  |({4{Ltrain1 }} & 4'b0000) |({4{Ltrain2 }} & 4'b0000) |({4{Rtrain1}} & 4'b0000)|({4{Rtrain2}} & 4'b0000) |({4{Mtrain1}} & 4'b0000)|({4{Mtrain2}} & 4'b0000);//trainG | testtraing;
    
endmodule



