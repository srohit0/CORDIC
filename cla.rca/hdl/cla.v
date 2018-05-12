
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
/********************************Test Case ***************

module test ;


reg [`CLA_SIZE:0] A, B;
reg CI;
wire [`CLA_SIZE:0] S;

CLA testit ( S, CO, A, B, CI );

initial
    begin
    CI <= 0;
    A <= 12; B<= 4095 ;
    $monitor ( "CI=%d A=%d B=%d S=%d CO=%d",CI,A,B,S,CO);
    end
endmodule

********************************Test Case ***************/


module CLA ( s, co, a, b, ci );

input ci;
input [`CLA_SIZE:0] a, b;
output [`CLA_SIZE:0] s;
output co;

reg [`CLA_SIZE:0] carrychain;
integer i;

wire [`CLA_SIZE:0] p = a ^ b;
wire [`CLA_SIZE:0] g = a & b;
wire [`CLA_SIZE+1:0] shiftedcarry = {carrychain, ci};
wire [`CLA_SIZE:0] s = p ^ shiftedcarry[`CLA_SIZE:0];
wire co = shiftedcarry[`CLA_SIZE+1];

always @ (a or b or ci or g or p)
begin
        carrychain[0] = g[0] | (p[0] & ci);
        for ( i = 1; i <= `CLA_SIZE; i = i + 1)
                carrychain[i] = g[i] | (p[i] & carrychain[i-1]);
end

endmodule

