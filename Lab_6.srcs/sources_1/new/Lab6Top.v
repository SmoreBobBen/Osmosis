`timescale 1ns / 1ps


module Lab6Top(
    input clkin,
    input [15:0] sw,
    input btnL,
    input btnR,
    input btnU,
    input btnD,
    input btnC, // reset
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [15:0] led,
    output Hsync,
    output Vsync,
    output [3:0] vgaRed,
    output [3:0] vgaBlue,
    output [3:0] vgaGreen
    );
    
    //wires
    wire clk, digsel, frameClk;
    wire [15:0] vpx, hpx;
    wire [15:0] rxa, rya; //molecule positions, format: [color][direction][letter a-d]
    
    //debug assignments
    wire [15:0] sww;
    assign sww = sw;
    wire btnLw, btnRw, btnUw, btnDw;
    assign btnLw = btnL;
    assign btnRw = btnR;
    assign btnUw = btnU;
    assign btnDw = btnD;
    assign dp = 1'b1;
    assign an = 4'b1110;
    assign seg = 7'h00;
    
    //tie values
    assign led = 16'h0000;
    
    //make the clock
    labVGA_clks clkMod (.clkin(clkin), .greset(btnC), .clk(clk), .digsel(digsel));
    
    
    //GAME ELEMENTS -------------------------------------------------------------
    Molecule RedMolA (.clk_i(clk), .reset_i(btnC), .frameClk(frameClk),
                      .initX(16'd50), .initY(16'd50), .init(btnL), .currentX(rxa), .currentY(rya));
    
    
    //DISPLAY -------------------------------------------------------------------
    //pixel position
    PixelPosition PixPos (.clk_i(clk), .reset_i(btnC), .vpx(vpx), .hpx(hpx), .frameClk(frameClk));
    
    //pixel processor
    PixelProcessor PixProc (.clk_i(clk), .reset_i(btnC), .vpx(vpx), .hpx(hpx),
                            .Red(vgaRed), .Blu(vgaBlue), .Grn(vgaGreen),
                            .Hsync(Hsync), .Vsync(Vsync),
                            .borderOn(1'b1), .membraneOn(1'b0),
                            .XRedMolA(rxa), .YRedMolA(rya));
    
    
endmodule
