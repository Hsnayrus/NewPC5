module decoder1_2(x, D, en);
	input x;
	input en;
	output [1:0] D;
	wire y;
	
	//when enable is on(1), the decoder behaves as normal. 
	//when enable is low, the output is 0
	//it is established though the use of an and gate
	not not0(y,x);
	and and0(D[0], en, y);
	and and1(D[1], en, x);
	
endmodule 