module sell(clk,cint,get2,get6,backAll,money,haveGood2,haveGood6,put2,put6,putMoney);
	input wire clk;
	input wire [3:0] cint;
	input wire get2;
	input wire get6;
	input wire backAll;
	output reg [7:0] money;
	output reg haveGood2;
	output reg haveGood6;
	output reg put2;
	output reg put6;
	output reg putMoney;
	
	reg re2;
	reg re6;
	reg [7:0] outMoney;
	reg  reMoney;
	
	initial
	begin
		money=8'd0;
		outMoney=8'd0;
		haveGood2=1;
		haveGood6=1;
		put2=0;
		put6=0;
		reMoney=0;
		
	end
	
	always@(posedge clk)
	begin
		if(get2)
			begin
				re2=1;
				re6=0;
			end
		else if(get6)
			begin
				re2=0;
				re6=1;
			end
		else
			begin
				re2=re2;
				re6=re6;
			end
			
		money=money+cint;
		if(backAll)
			begin
				outMoney=outMoney+money;
				money=8'd0;
				put2=0;
				put6=0;
			end
		else if(re2&&haveGood2)
			begin
				if(money>2)
					begin
						put2=1;
						put6=0;
						re2=0;
						money=money-4'd2;
					end
				else
					begin
						put2=0;
					end
			end
		else if(re6&&haveGood6)
			begin
				if(money>6)
					begin
						put6=1;
						put2=0;
						re6=0;
						money=money-4'd6;
					end
				else
					put6=0;
			end
		else
			begin
				put2=0;
				put6=0;
			end
		
		if(outMoney!=0)
			begin
				reMoney=1;
				outMoney=outMoney-8'd1;
			end
		else
			reMoney=0;
	end 
	always@(reMoney)
	begin
		if(reMoney)
			begin
				putMoney=clk;
			end
		else
			putMoney=0;
	end	
endmodule