module buy(clk,buy2,buy6,back,cancel,sure,get2,get6,backAll);
	input wire clk;
	input wire buy2;
	input wire buy6;
	input wire back;
	input wire cancel;
	input wire sure;
	output reg get2;
	output reg get6;
	output reg backAll;
	
	reg  re2;
	reg  re6;
	reg	 Ba;
	
	initial
	begin
		re2=0;
		re6=0;
		get2=0;
		get6=0;
		Ba=0;
		backAll=0;
	end
	
	always@(posedge clk)
	begin
		if(buy2&&!buy6&&!back)
			begin
			re2=1;
			re6=0;
			Ba=0;
			end
		else if(!buy2&&buy6&&!back) 
			begin
			re6=1;
			re2=0;
			Ba=0;
			end
		else if(!buy2&&!buy6&&back) 
			begin
			Ba=1;
			re6=0;
			re2=0;
			end
		else
			begin
				re2=0;
				re6=0;
				Ba=0;
			end
		if(cancel)
			begin
				re6=0;
				re2=0;
				get2=0;
				get6=0;
				Ba=0;
				backAll=0;
			end
		else
			begin
				if(sure)
					begin
						get2=re2;
						get6=re6;
						backAll=Ba;
					end
				else
					begin
					get2=0;
					get6=0;
					backAll=0;
					end
			end	
	end 
endmodule	