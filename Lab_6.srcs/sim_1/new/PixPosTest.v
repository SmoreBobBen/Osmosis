module SimPixPos();
    //reg Up, Down;
    reg clkin, reset;
    wire [15:0] vpx;
    wire [15:0] hpx;
    //declare tested module here
    PixelPosition PixPos (
        .clk_i(clkin),
        .reset_i(reset),
        .vpx(vpx),
        .hpx(hpx)
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
        reset = 1'b0;
        #200;
        
        //put tests here
        
        
    end
endmodule 
