module dt(clk,star,finish,one,fine,ten,ticket,sure,money,needMoney,outT,outM);

	input wire clk;
	input wire [5:0] star;
	input wire [5:0] finish;
	
	input wire one;
	input wire fine;
	input wire ten;
	reg [3:0] cint;
	
	input wire [1:0] ticket;
	
	input wire sure;
	
	output reg [7:0] money;
	output reg [7:0] needMoney;
	output reg outT;
	output reg outM;
	
	reg [5:0] star1;
	reg [5:0] finish1;
	
	reg [1:0] direction1;
	reg [1:0] direction2;
	
	reg [1:0] ticket1;
	
	reg [3:0] zhan1;
	reg [3:0] zhan2;
	reg [5:0] zhan;
	
	reg [7:0] outMoney;
	reg [3:0] outTicket;
	
	reg rem;
	reg ret;
	
	initial
	begin
		cint=4'd0;
		star1=6'd0;
		finish1=6'd0;
		direction1=2'd0;
		direction2=2'd0;
		ticket1=2'd0;
		zhan1=4'd0;
		zhan2=4'd0;
		zhan=6'd0;
		outMoney=8'd0;
		outTicket=4'd0;
		ret=0;
		rem=0;
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
		
		money=money+cint;
		
		star1=star;
		finish1=finish;
		
		direction1=star1>>4;
		direction2=finish1>>4;
		
		zhan1=star1%6'd16;
		zhan2=finish1%6'd16;
		
		ticket1=ticket;
		
		if(direction1==direction2)
			begin
				if(zhan1>zhan2)			
					zhan=zhan1-zhan2;
				else
					zhan=zhan2-zhan1;				
			end
		else
			begin
				zhan=zhan1+zhan2;
			end
		
		if(zhan<=4'd8)
			needMoney=4'd2*ticket1;
		else if(zhan<=4'd12&&zhan>8)
			needMoney=4'd3*ticket1;
		else if(zhan<=5'd19&&zhan>12)
			needMoney=4'd4*ticket1;
		else if(zhan<=5'd26&&zhan>19)
			needMoney=4'd5*ticket1;
		else if(zhan>=27)
			needMoney=4'd6*ticket1;
			
		if(sure&&money>needMoney)
			begin
				money=money-needMoney;
				outTicket=ticket1;
				outMoney=money;
				money=0;
			end
		else
			money=money;
		
		if(outMoney!=0)
			begin
				rem=1;
				outMoney=outMoney-8'd1;
			end 
		else
			rem=0;
		
		if(outTicket!=0)
			begin
				ret=1;
				outTicket=outTicket-4'd1;
			end
		else
			ret=0;
	end 
	
	always@(rem)
	begin
		if(rem)
			begin
				outM=clk;
			end
		else
			outM=0;
	end	
	
	always@(ret)
	begin
		if(ret)
			begin
				outT=clk;
			end
		else
			outT=0;
	end
	
endmodule