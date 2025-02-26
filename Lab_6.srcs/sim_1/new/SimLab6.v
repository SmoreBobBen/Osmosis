module SimLab6();
    //create input registers
    reg clkin;
    reg [15:0] sw;
    reg btnL;
    reg btnR;
    reg btnU;
    reg btnD;
    reg btnC; // reset
    //create output wires
    wire [6:0] seg;
    wire dp;
    wire [3:0] an;
    wire Hsync;
    wire Vsync;
    wire [3:0] vgaRed;
    wire [3:0] vgaBlue;
    wire [3:0] vgaGreen;
    //declare tested module here
    Lab6Top Lab6Module (
        .clkin(clkin),
        .sw(sw),
        .btnL(btnL),
        .btnR(btnR),
        .btnU(btnU),
        .btnC(btnC),
        .seg(seg),
        .dp(dp),
        .an(an),
        .Hsync(Hsync),
        .Vsync(Vsync),
        .vgaRed(vgaRed),
        .vgaBlue(vgaBlue),
        .vgaGreen(vgaGreen)
    );
    
    //clk cycle stuff
    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;
	 

	initial    // Clock process for clkin
	begin
	  //btnC = 1'bx;
	  //btnR = 1'b0;
	  //btnU = 1'bx;
	  //btnD = 1'bx;
	  //btnL = 1'bx;
    
       #OFFSET
		clkin = 1'b1;
       forever
         begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clkin = ~clkin;
         end
	  end
    //end clk cycle stuff
    
    
    initial begin
        btnC = 1'b0;
        btnD = 1'b0;
        btnU = 1'b0;
        btnL = 1'b0;
        btnR = 1'b0;
        sw = 16'h0000;

        #200;
        
        //put tests here
        
        
    end
endmodule 
