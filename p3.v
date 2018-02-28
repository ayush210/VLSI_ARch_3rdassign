module dflipflop(clk,in,out);
input[7:0] in;
input clk;
wire[7:0] in;
wire clk;
output[7:0] out;
reg[7:0] out;
always @(posedge clk)
		begin
		out <= in; 
		end
endmodule

/*module lookuptable(inp,outp);
reg look[7:0];
input[2:0] inp;
output outp;
reg outp;
wire[2:0] inp;
initial begin
look[0] = 1;look[1] = 0;look[2] = 1;look[3]=0;look[4] = 1;look[5]=0;look[6]=1;look[7]=0;
end
always @(inp)
		begin
outp <= look[inp];
end
endmodule*/

/*module mux8(select,in0,in1,in2,in3,in4,in5,in6,in7,out);
input in0,in1,in2,in3,in4,in5,in6,in7;
input [2:0]select;
wire in0,in1,in2,in3,in4,in5,in6,in7;
output out;
reg out;
always @(select or in0 or in1 or in2 or in3 or in4 or in5 or in6 or in7)
		begin
		case(select)
		0: out = in0;
		1: out = in1;
		2: out = in2;
		3: out = in3;
		4: out = in4;
		5: out = in5;
		6: out = in6;
		7: out = in7;
		endcase
		end
endmodule*/

module mult(inpu1,inpu2,outpu);
input[7:0] inpu1,inpu2;
output[7:0] outpu;
reg[7:0] outpu;
wire[7:0] inpu1,inpu2;
always @(inpu1 or inpu2)
		begin
			outpu <= inpu1 * inpu2;
		end
endmodule

module adder(i1,i2,sum);
input[7:0] i1,i2;
output[7:0] sum;
wire[7:0] i1,i2;
reg[7:0] sum;
always @(i1 or i2)
		begin 
		sum <= i1 + i2;
		end
endmodule

/*module control(in1,clk,ou);
input clk,in1;
output ou;
wire in1,clk;
wire w1,w2,w3,w4,w5,w6,w7,w8,o;
wire out;
reg ou;
reg [2:0]select;
dflipflop d1(clk,in1,w1);
dflipflop d2(clk,w1,w2);
dflipflop d3(clk,w2,w3);
dflipflop d4(clk,w3,w4);
dflipflop d5(clk,w4,w5);
dflipflop d6(clk,w5,w6);
dflipflop d7(clk,w6,w7);
dflipflop d8(clk,w7,w8);
mux8 mu1(select,w1,w2,w3,w4,w5,w6,w7,w8,out);
lookuptable l1(select,mu);
mult m(out,mu,mul);
adder a1(mul,o,o);
initial begin
select = 0;
$monitor($time," %d",out);
end
always @(*)
		begin
#1 select <= (select+1)%8;
		end
always @(*)
		begin
		ou <= o;
		end
endmodule*/

module top;

reg clk;
reg[7:0] in;
reg[7:0] b0,b1,b2,b3,b4,b5,b6,b7;
wire[7:0] x0,x1,x2,x3,x4,x5,x6,x7;
wire[7:0] y0,y1,y2,y3,y4,y5,y6;
wire[7:0] a0,a1,a2,a3,a4,a5;
wire[7:0] ans;

mult m0(in,b0,x0);
mult m1(in,b1,x1);
mult m2(in,b2,x2);
mult m3(in,b3,x3);
mult m4(in,b4,x4);
mult m5(in,b5,x5);
mult m6(in,b6,x6);
mult m7(in,b7,x7);
adder q0(y0,x1,a0);
adder q1(y1,x2,a1);
adder q2(y2,x3,a2);
adder q3(y3,x4,a3);
adder q4(y4,x5,a4);
adder q5(y5,x6,a5);
adder q6(y6,x7,ans);
dflipflop d0(clk,x0,y0);
dflipflop d1(clk,a0,y1);
dflipflop d2(clk,a1,y2);
dflipflop d3(clk,a2,y3);
dflipflop d4(clk,a3,y4);
dflipflop d5(clk,a4,y5);
dflipflop d6(clk,a5,y6);

always @(*)
		begin
#5 clk<= ~clk;
		end

initial begin
$monitor($time,"%d",ans);
b0 = 1;b1=2;b2 = 1;b3=2;b4=1;b5=2;b6=1;b7=2;
clk = 0;
#5 in <= 1;
#10 in <= 0;
#10 in <= 1;
#10 in <= 0;
#10 in <= 1;
#10 in <= 0;
#10 in <= 1;
#10 in <= 1;
end

endmodule
