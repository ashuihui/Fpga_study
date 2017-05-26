module taxi(cp1,cp2,stop,reset,run,waitTime,money);
	input wire cp1;
	input wire cp2;
	input wire stop;
	input wire reset;
	
	output reg [17:0] run;
	output reg [15:0] waitTime;
	output reg [13:0] money;
	
	reg [15:0] time2;
	reg [15:0] time3;
	reg [15:0] timeyu;
	reg [11:0] runyu;
	reg [17:0] run2;
	
	initial
	begin
		run=18'd0;
		waitTime=15'd0;
		
		money=14'd0;
		time2=16'd0;
		time3=16'd0;
		runyu=11'd0;
		run2=18'd0;
	end
	
	always@(posedge cp1)
	begin
		if(reset)
			begin 
			run=18'd0;
			end
		else
			begin
			run=run+18'd10;
			end 
	end	
	
	always@(posedge cp2)
	begin
		if(reset)
			begin 
			waitTime=8'd0;
			time2=16'd0;
			end
		else if(stop)
			begin
				time2=time2+16'd1;
				waitTime=time2/7'd60;
				if(waitTime<=0)
					waitTime=16'd1;
				else
					waitTime=waitTime;
			end
		else
			begin
				waitTime=waitTime;
				time2=time2;
			end 
	end	
	
	
	always@(run,waitTime)
	begin
		if(reset)
			begin 
			money=14'd0;
			end
		else
			begin
				if(run<=14'd3000)
					money=14'd80;
				else
					begin
						runyu=run%14'd3000;
						run2=(run-14'd3000)/1000;
						time3=waitTime/3'd3;
						timeyu=waitTime%3'd3;
						money=14'd80+(run2+time3)*4'd14;
						if(runyu!=0)
							money=money+4'd14;
						else
							money=money;
						if(timeyu!=0)
							money=money+4'd14;
						else
							;
					end
			end 
	end	
	
endmodule