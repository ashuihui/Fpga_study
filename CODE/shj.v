module shj(clk,one,fine,ten,buy2,buy6,back,cancel,sure,money,haveGood2,haveGood6,put2,put6,putMoney);
	input wire clk;
	
	input wire one;
	input wire fine;
	input wire ten;

	input wire buy2;
	input wire buy6;
	input wire back;
	input wire cancel;
	input wire sure;
	
	output wire [7:0] money;
	output wire haveGood2;
	output wire haveGood6;
	output wire put2;
	output wire put6;
	output wire putMoney;
	
	wire [3:0] cint;
	wire get2;
	wire get6;
	wire backAll;
	
	count count1(
				.clk(clk),
				.one(one),
				.fine(fine),
				.ten(ten),
				.cint(cint)
				);

	buy buy1(
			.clk(clk),
			.buy2(buy2),
			.buy6(buy6),
			.back(back),
			.cancel(cancel),
			.sure(sure),
			.get2(get2),
			.get6(get6),
			.backAll(backAll)
			);
	sell sell1(
				.clk(clk),
				.cint(cint),
				.get2(get2),
				.get6(get6),
				.backAll(backAll),
				.money(money),
				.haveGood2(haveGood2),
				.haveGood6(haveGood6),
				.put2(put2),
				.put6(put6),
				.putMoney(putMoney)
				);

endmodule