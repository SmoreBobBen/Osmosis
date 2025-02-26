`timescale 1ns / 1ps


module Molecule(
    input clk_i,
    input reset_i,
    input frameClk,
    input [15:0] initX,
    input [15:0] initY,
    input init,
    output [15:0] currentX,
    output [15:0] currentY
    );
    
    //wires and outputs
    wire RL, DU;
    wire [15:0] xpos, ypos;
    wire [1:0] UTC, DTC;
    wire Lcol, Rcol;
    assign currentX = xpos;
    assign currentY = ypos;
    
    //collision detection
    assign Lcol = (xpos <= 8);
    assign Rcol = (xpos >= 615);
    assign Ucol = (ypos <= 8);
    assign Dcol = (ypos >= 455);
    
    //store direction states    
    FDRE #(.INIT(1'b0)) RLDFF (.C(clk_i), .R(reset_i), .CE(frameClk), .D(RL&(~Rcol)|Lcol), .Q(RL));
    FDRE #(.INIT(1'b0)) DUDFF (.C(clk_i), .R(reset_i), .CE(frameClk), .D(DU&(~Dcol)|Ucol), .Q(DU));

    
    //coordinate counters
    countUD16L XPOS (.clk_i(clk_i), .reset_i(reset_i), .Up_i(frameClk&RL), .Dw_i(frameClk&(~RL)), .LD_i(init), .Din_i(initX), 
                     .Q_o(xpos), .UTC_o(UTC[0]), .DTC_o(DTC[0]));
    countUD16L YPOS (.clk_i(clk_i), .reset_i(reset_i), .Up_i(frameClk&DU), .Dw_i(frameClk&(~DU)), .LD_i(init), .Din_i(initY), 
                     .Q_o(ypos), .UTC_o(UTC[1]), .DTC_o(DTC[1]));
    
    
endmodule
