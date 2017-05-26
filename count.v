 module	count(clk,one,fine,ten,cint);
	input wire clk;
	input wire one;
	input wire fine;
	input wire ten;
	output reg [3:0] cint;
	
	initial
	begin
		cint=4'd0;
	end
	
	always@(posedge clk)
	begin
		if(one&&!fine&&!ten)
		cint<=4'd1;
		else if(!one&&fine&&!ten)
		cint<=4'd5;
		else if(!one&&!fine&&ten)
		cint<=4'd10;
		else
		cint<=4'd0;
	end 
endmodule