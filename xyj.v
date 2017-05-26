module xyj(R,EN,cp,JS,PS,ZZ,FZ,QX,PX,TS,count,BJ);
	input wire R,EN,cp;
	output reg JS,PS,ZZ,FZ,QX,PX,TS,BJ;
	output reg [9:0]count;
	reg [3:0]sec,cir1,cir2;
	reg [3:0]state;
	parameter S0=4'b0000,S1=4'b0001,S2=4'b0010,S3=4'b0011,
				S4=4'b0100,S5=4'b0101,S6=4'b0110,S7=4'b0111,
				S8=4'b1000,S9=4'b1001;
always@( posedge cp)
begin 
	if(R)
		begin
			JS<=0;PS<=0;ZZ<=0;FZ<=0;QX<=0;PX<=0;TS<=0;BJ<=0;
			count<=0;sec<=0;cir1<=0;cir2<=0;state<=S0;
		end	
	else if(EN)
		begin
			count<=count+10'd1;		
			case(state)
				S0:begin 
					QX<=1;	JS<=0;PS<=0;ZZ<=0;FZ<=0;PX<=0;TS<=0;BJ<=0;
					state<=S1;
					end
				S1:	begin
					JS<=1;	PS<=0;ZZ<=0;FZ<=0;BJ<=0;	
					if(sec<1)
						sec<=sec+4'b0001;
					else
						begin
							sec<=0;
							state<=S2;
						end
					end
				S2:begin
					ZZ<=1;	JS<=0;PS<=0;FZ<=0;BJ<=0;
					if(sec<2)
						sec<=sec+4'b0001;
					else
						begin
							sec<=0;
							state<=S3;
						end
					end
				S3:begin
					JS<=0;PS<=0;ZZ<=0;FZ<=0;
					if(sec<0)
						sec<=sec+4'b0001;
					else
						begin
						sec<=0;
						state<=S4;
						end
					end
				S4:begin
					FZ<=1;	JS<=0;PS<=0;ZZ<=0;BJ<=0;
					if(sec<2)
						sec<=sec+4'b0001;
					else
						begin
							sec<=0;
							state<=S5;
						end
					end
				S5:begin
					cir1<=cir1+4'b0001;
					JS<=0;PS<=0;ZZ<=0;FZ<=0;
					if(sec<0)
						sec<=sec+4'b0001;
					else
						begin
						sec<=0;
						end
					if(cir1<2)
						state<=S2;
					else
						begin 
							cir1<=0;
							state<=S6;
						end
					end
				S6:begin 
					PS<=1;	JS<=0;ZZ<=0;FZ<=0;BJ<=0;
					if(sec<1)
						sec<=sec+4'b0001;
					else
						begin
							sec<=0;
							if(PX)
								begin
									cir2<=cir2+4'b0001;
									if(cir2<2)
									state<=S1;
									else
										begin 
										cir2<=0;
										state<=S8;
										end	
								end 
							else
								state<=S7;
						end
					end
				S7:begin
					QX<=0;
					PX<=1;
					JS<=0;PS<=0;ZZ<=0;FZ<=0;
					state<=S1;
					end
				S8:begin
					PX<=0;
					TS<=1;
					ZZ<=1;
					PS<=1;
					JS<=0;FZ<=0;BJ<=0;
					if(sec<2)
						sec<=sec+4'b0001;
					else
						begin
							sec<=0;
							state<=S9;
						end
					end
				S9:begin
					BJ=1;	JS<=0;PS<=0;ZZ<=0;FZ<=0;QX<=0;PX<=0;TS<=0;	
					end
				default state<=S0;
			endcase 
		end
	else 
	begin
	sec<=0;
	cir1<=0;
	cir2<=0;
	count<=0;
	state<=S0;
	end
end
endmodule
