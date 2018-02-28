module dff(in1,in2,a,b,clk);
input[7:0] in1,in2;
input clk;
output[7:0] a,b;
wire[7:0] in1,in2;
wire clk;
reg[7:0] a,b;

always @(posedge clk)
		begin
		a<=in1;
		b<=in2;
		end
endmodule

module max(in1,in2,out,clk);
input[7:0] in1,in2;
input clk;
output[7:0] out;
wire[7:0] in1,in2;
wire clk;
reg[7:0] out;
always @(*)
		begin
		if(in1>in2)
		out = in1;
		else
		out = in2;
		end
endmodule

		module mod(in1,in2,out);
		input[7:0] in1,in2;
		output[7:0] out;
		wire[7:0] in1,in2;
		reg[7:0] out;
always @(*)
		begin
if(in1>in2)
		out = in1-in2;
		else 
		out = in2-in1;
		end
		endmodule

		module adder(in1,in2,out,clk);
		input[7:0] in1,in2;
		input clk;
		wire clk;
		wire[7:0] in1,in2;
		output[7:0] out;
		reg[7:0] out;
always @(*)
		begin
		out = in1+in2;
		end
		endmodule

		module mult(in1,out);
		input [7:0] in1;
		output[7:0] out;
		wire [7:0] in1;
		reg[7:0] out;
always @(*)
		begin
		out = 5*in1;
		end
		endmodule

		module subt(in1,in2,out);
		input[7:0] in1,in2;
		output[7:0] out;
		wire[7:0] in1,in2;
		reg[7:0] out;
always @(*)
		begin
		out = in1-in2;
		end
		endmodule

		module test;
		reg[7:0] in1;
		reg[7:0] in2;
		reg clk;
		wire [7:0]out;
		wire [7:0]temp;
		wire [7:0]temp2;
		wire [7:0]ans;
		reg [7:0]faltu;
		wire [7:0]faltu2;
		reg [7:0]faltu3;
		wire [7:0]faltu4;
		wire [7:0] c;
		wire [7:0] d;
		wire [7:0] a;
		wire [7:0] b;
always @(*)
		begin
#5 clk <= ~clk;
		end
		dff d1(in1,in2,a,b,clk);
		max m1(a,b,out,clk);
		mod m2(a,b,temp);
		mult m4(temp,faltu2);
		subt su(faltu,faltu2,faltu4);
		max m3(faltu3,faltu4,temp2,clk);
		dff d2(out,temp2,c,d,clk);
		adder a1(c,d,ans,clk);
		initial begin
		$monitor($time,"%d",ans);
		in1 = 1; in2 = 1;clk = 0;faltu = 23;
		faltu3 = 0;
		#15 in1 = 1;in2 = 0;
		end
		endmodule

/*module test;

reg in1,in2;
wire a,b;
reg clk;
always @(*)
		begin
#5 clk <= ~clk;
		end

dff d1(in1,in2,a,b,clk);
mod m2(a,b,temp);


initial begin
$monitor("%d %d %d %d",out1,out2,out3,out4);
clk = 0;in1 = 1;in2 = 0;
#10 in1 = 0;in2 = 1;
end

endmodule*/


/*module test;
		reg[7:0] in1,in2;
		wire[7:0] out;
		reg clk;
		max m(in1,in2,out,clk);
		always @(*)
		begin
		clk <= ~clk;
		end
		initial begin
		$monitor("%d",out);
		in1 = 0;in2 = 23;
		end
endmodule*/
