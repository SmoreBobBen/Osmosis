`timescale 1ns / 1ps


module PixelProcessor(
    input clk_i,
    input reset_i,
    input borderOn,
    input membraneOn,
    input [15:0] vpx,
    input [15:0] hpx,
    
    input [15:0] XRedMolA,
    input [15:0] YRedMolA,
    
    output [3:0] Red,
    output [3:0] Grn,
    output [3:0] Blu,
    output Hsync,
    output Vsync
    );
    
    //wires
    wire active;
    wire Hs, Vs;
    wire [3:0] R, G, B;
    
    //determine current frame
    assign active = (hpx <= 639)&(vpx <= 479);
    assign Hs = (hpx >= 655)&(hpx <= 750);
    assign Vs = (vpx == 489)|(vpx == 490);
    
    //debug
    assign R = {4{active
               &((vpx>=(YRedMolA))&(vpx<((YRedMolA)+(16)))&(hpx>=(XRedMolA))&(hpx<((XRedMolA)+(16))))}};
    assign G = {4{active&borderOn&((vpx<=7)|(vpx>=472)|(hpx<=7)|(hpx>=632))}};
    assign B = {4{active&(1'b0)}};
    
    //synchronize values
    FDRE #(.INIT(1'b0)) RED0 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(R[0]), .Q(Red[0]));
    FDRE #(.INIT(1'b0)) RED1 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(R[1]), .Q(Red[1]));
    FDRE #(.INIT(1'b0)) RED2 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(R[2]), .Q(Red[2]));
    FDRE #(.INIT(1'b0)) RED3 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(R[3]), .Q(Red[3]));

    FDRE #(.INIT(1'b0)) GRN0 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(G[0]), .Q(Grn[0]));
    FDRE #(.INIT(1'b0)) GRN1 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(G[1]), .Q(Grn[1]));
    FDRE #(.INIT(1'b0)) GRN2 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(G[2]), .Q(Grn[2]));
    FDRE #(.INIT(1'b0)) GRN3 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(G[3]), .Q(Grn[3]));

    FDRE #(.INIT(1'b0)) BLU0 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(B[0]), .Q(Blu[0]));
    FDRE #(.INIT(1'b0)) BLU1 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(B[1]), .Q(Blu[1]));
    FDRE #(.INIT(1'b0)) BLU2 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(B[2]), .Q(Blu[2]));
    FDRE #(.INIT(1'b0)) BLU3 (.C(clk_i), .R(reset_i), .CE(1'b1), .D(B[3]), .Q(Blu[3]));
    
    FDRE #(.INIT(1'b1)) HSYNC (.C(clk_i), .R(reset_i), .CE(1'b1), .D(~Hs), .Q(Hsync));
    FDRE #(.INIT(1'b1)) VSYNC (.C(clk_i), .R(reset_i), .CE(1'b1), .D(~Vs), .Q(Vsync));




    
endmodule
