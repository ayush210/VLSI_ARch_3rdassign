module dflipflop(clk,in,out);
input in,clk;
wire in,clk;
output out;
reg out;
always @(posedge clk)
		begin
		out <= in; 
		end
endmodule

module lookuptable(inp,outp);
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
outp = look[inp];
end
endmodule

module mux8(select,in0,in1,in2,in3,in4,in5,in6,in7,out);
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
endmodule

module mult(inpu1,inpu2,outpu);
input inpu1,inpu2;
output outpu;
reg outpu;
wire inpu1,inpu2;
always @(inpu1 or inpu2)
		begin
			outpu <= inpu1 * inpu2;
		end
endmodule

module adder(i1,i2,sum);
input i1,i2;
output sum;
wire i1,i2;
reg sum;
always @(i1 or i2)
		begin 
		sum <= i1 + i2;
		end
endmodule

module control(in1,clk,ou);
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
endmodule

module top;
reg clk,in;
wire out;
control c1(in,clk,ou);
always @(*)
		begin
#5 clk <= ~clk;
		end
initial begin
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
