`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/06/2024 10:42:50 AM
// Design Name: 
// Module Name: count5
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


module countUD5L(
    //input clk,
    input UD,
    input CE,
    input LD,
    input clk,
    input [4:0] Din ,
    output UTC,
    output DTC,
    output [4:0] Q
    );
    wire [4:0] inc, dec, out, UD0, UD1, UD2, UD3, UD4, d, ender;
    
    assign inc[0] = CE ^ out[0];
    assign inc[1] = (CE & out[0]) ^ out[1]; 
    assign inc[2] = (CE & out[0] & out[1]) ^ out[2]; 
    assign inc[3] = (CE & out[0] & out[1] & out[2]) ^ out[3]; 
    assign inc[4] = (CE & out[0] & out[1] & out[2] & out[3]) ^ out[4];

    assign dec[0] = CE ^ out[0];
    assign dec[1] = (CE & ~out[0]) ^ out[1]; 
    assign dec[2] = (CE & ~out[0] & ~out[1]) ^ out[2]; 
    assign dec[3] = (CE & ~out[0] & ~out[1] & ~out[2]) ^ out[3]; 
    assign dec[4] = (CE  & ~out[0] & ~out[1] & ~out[2] & ~out[3]) ^ out[4];

 
    mux add (.i0(inc), .i1(dec), .s(UD), .y(d));
    mux res (.i0(d), .i1(Din), .s(LD), .y(ender));
    
    FDRE #(.INIT(1'b1)) FF1 (.C(clk), .CE(CE | LD), .R(1'b0), .D(ender[0]), .Q(out[0]));
    FDRE #(.INIT(1'b1)) FF2 (.C(clk), .CE(CE | LD), .R(1'b0), .D(ender[1]), .Q(out[1]));
    FDRE #(.INIT(1'b1)) FF3 (.C(clk), .CE(CE | LD), .R(1'b0), .D(ender[2]), .Q(out[2]));
    FDRE #(.INIT(1'b1)) FF4 (.C(clk), .CE(CE | LD), .R(1'b0), .D(ender[3]), .Q(out[3]));
    FDRE #(.INIT(1'b1)) FF5 (.C(clk), .CE(CE | LD), .R(1'b0), .D(ender[4]), .Q(out[4]));

    assign UTC = out[0] & out[1] & out[2] & out[3] & out[4];
    assign DTC = ~(out[0] | out[1] | out[2] | out[3] | out[4]);
    assign Q[0] = out[0];
    assign Q[1] = out[1];
    assign Q[2] = out[2];
    assign Q[3] = out[3]; 
    assign Q[4] = out[4];  
    
endmodule