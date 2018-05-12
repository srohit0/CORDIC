
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//--  The Free IP Project
//--  Verilog Free-CORDIC Core
//--  (c) 2000, The Free IP Project and Rohit Sharma (srohit@free-ip.com)
//--
//--
//--  FREE IP GENERAL PUBLIC LICENSE
//--  TERMS AND CONDITIONS FOR USE, COPYING, DISTRIBUTION, AND MODIFICATION
//--
//--  1.  You may copy and distribute verbatim copies of this core, as long
//--      as this file, and the other associated files, remain intact and
//--      unmodified.  Modifications are outlined below.
//--  2.  You may use this core in any way, be it academic, commercial, or
//--      military.  Modified or not.
//--  3.  Distribution of this core must be free of charge.  Charging is
//--      allowed only for value added services.  Value added services
//--      would include copying fees, modifications, customizations, and
//--      inclusion in other products.
//--  4.  If a modified source code is distributed, the original unmodified
//--      source code must also be included (or a link to the Free IP web
//--      site).  In the modified source code there must be clear
//--      identification of the modified version.
//--  5.  Visit the Free IP web site for additional information.
//--      http://www.free-ip.com
//--
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
`timescale 1ns/1ps

module cordic_Stimulas;
	reg [`REG_SIZE:0] theta;
	reg Sign;
	reg clock,reset;
	wire [`REG_SIZE:0] CosX,SinX;

parameter clockHigh = 30;//defines clock high(=clock low) duration.
parameter MC_cycle = 960;//defines total time (16*clock time) to compute Sin and Cos.

	cordic test(CosX,SinX,theta,Sign,clock,reset);
initial
	begin
        clock=1'b1;
	end
always
	begin
        #clockHigh clock = ~clock;
	end

	
	initial
		begin
		theta[7:0]=0;

			/* iteration to compute Sin and Cos from 0 to 45*/
		Sign=0;
            	for(theta[15:8]=0; theta[15:8] <= 45; theta[15:8] = theta[15:8] + 1)
		   begin
			reset=1;
			reset <= #1 0;
			#MC_cycle; $display($time," CosX = %b",CosX," SinX = %b ",SinX," theta=+%d",theta[15:8]);
				reset=1;
		   end 


			$finish;
		end

endmodule //cordic_Stimulas
