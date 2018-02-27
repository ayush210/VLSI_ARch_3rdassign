module dff(x,clock,out,reset);
input reset;
input [1:0]x;
input clock;
output [1:0]out;
reg out;
always @(posedge clock)
		begin
		if(reset==1)
		begin
			out <= 0;
		end
		else 
		begin
			out <= x;
		end
		end

endmodule

module adder(sum,a,b);
input [3:0]a,b;
input c_0;
output [3:0]sum;
wire [3:0] sum;
wire p0,p1,p2,p3,g0,g1,g2,g3;
assign c_0 = 0;
wire c1,c2,c3,c4;
assign p0=a[0]^b[0];
assign p1=a[1]^b[1];
assign p2=a[2]^b[2];
assign  p3=a[3]^b[3];
assign  g0=a[0]&b[0];
assign  g1=a[1]&b[1];
assign  g2=a[2]&b[2];
assign  g3=a[3]&b[3];
assign  c1=g0|(p0&c_0);
assign  c2=g1|(p1&g0)|(p1&p0&c_0);
assign  c3=g2|(p2&g1)|(p2&p1&g0)|(p2&p1&p0&c_0);
assign  c4=g3|(p3&g2)|(p3&p2&p1&g1)|(p3&p2&p1&g0)|(p3&p2&p1&p0&c_0);
assign  sum[0]=p0^c_0;
assign  sum[1]=p1^c1;
assign  sum[2]=p2^c2;
assign  sum[3]=p3^c3;

        endmodule


module firfilter(x,clock,outvalue,reset);
input [1:0]x;
input clock,reset;
output [3:0]outvalue;
//reg outvalue;
wire [1:0] d11;
wire [1:0] d12,d13,d14,d15,d16,d17,d18;
wire [3:0] m1,m2,m3,m4,m5,m6,m7,m8;
wire [3:0] sum1,sum2,sum3,sum4,sum5,sum6;
parameter h1=4'b0001;
parameter h2=4'b0010;
parameter h3=4'b0011;
parameter h4=4'b0100;
parameter h5=4'b0101;
parameter h6=4'b0110;
parameter h7=4'b0111;
parameter h8=4'b1000;
dff d1(x,clock,d11,reset);
dff d2(d11,clock,d12,reset);
dff d3(d12,clock,d13,reset);
dff d4(d13,clock,d14,reset);
dff d5(d14,clock,d15,reset);
dff d6(d15,clock,d16,reset);
dff d7(d16,clock,d17,reset);
dff d8(d17,clock,d18,reset);
assign m1 = d11>>h1;
assign m2 = d12>>h2;
adder a1(sum1,m1,m2);
assign m3 = d13>>h3;
adder a2(sum2,sum1,m3);
assign m4 = d14>>h4;
adder a3(sum3,sum2,m4);
assign m5 = d15>>h5;
adder a4(sum4,sum3,m5);
assign m6 = d16>>h6;
adder a5(sum5,sum4,m6);
assign m7 = d17>>h7;
adder a6(sum6,sum5,m7);
assign m8 = d18>>h8;
adder a7(outvalue,sum6,m8);
//initial begin
//$monitor("time=%d m1=%d m2=%d m3=%d",$time,d11,d12,d13);
//end
endmodule 

module test;
reg reset;
reg [1:0]x;
reg	clock;
wire [3:0]out;
firfilter f1(x,clock,out,reset);
always 
	begin
		#10 clock <= ~clock;
	end
initial 
begin
clock = 1;reset = 1;
$monitor("time=%d input=%d output=%d",$time,x,out);
#20 reset=0;x= 0 ; 
#20 x = 2 ; 
#20 x = 3 ; 
#20 x = 2 ; 
end
endmodule
