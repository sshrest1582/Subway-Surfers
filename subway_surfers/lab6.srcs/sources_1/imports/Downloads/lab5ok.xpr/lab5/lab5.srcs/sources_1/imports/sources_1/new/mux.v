`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2024 10:50:47 AM
// Design Name: 
// Module Name: mux
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


module mux(
    input s,
    input [15:0]i0,
    input [15:0]i1,
    output [15:0]y 
    );
    assign y[0] = ~s&i0[0] | s&i1[0] ;
    assign y[1] = ~s&i0[1] | s&i1[1] ;
    assign y[2] = ~s&i0[2] | s&i1[2] ;
    assign y[3] = ~s&i0[3] | s&i1[3] ;
    assign y[4] = ~s&i0[4] | s&i1[4] ;
    assign y[5] = ~s&i0[5] | s&i1[5] ;
    assign y[6] = ~s&i0[6] | s&i1[6] ;
    assign y[7] = ~s&i0[7] | s&i1[7] ;
    assign y[8] = ~s&i0[8] | s&i1[8] ;
    assign y[9] = ~s&i0[9] | s&i1[9] ;
    assign y[10] = ~s&i0[10] | s&i1[10] ;
    assign y[11] = ~s&i0[11] | s&i1[11] ;
    assign y[12] = ~s&i0[12] | s&i1[12] ;
    assign y[13] = ~s&i0[13] | s&i1[13] ;
    assign y[14] = ~s&i0[14] | s&i1[14] ;
    assign y[15] = ~s&i0[15] | s&i1[15];
    
    
endmodule
