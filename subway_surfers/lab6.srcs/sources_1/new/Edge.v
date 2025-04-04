`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2024 12:17:24 AM
// Design Name: 
// Module Name: Edge
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


module Edge(
    input btnU,
    input clk,
    output edger
    );
    
    wire w;
    wire w1;
    
    FDRE #(.INIT(1'b0) ) FF_Edge1 (.C(clk), .R(1'b0), .CE(1'b1), .D(btnU), .Q(w));
    FDRE #(.INIT(1'b0) ) FF_Edge2 (.C(clk), .R(1'b0), .CE(1'b1), .D(w), .Q(w1));

    assign edger = ~w1 & ~w & btnU;
    

endmodule
