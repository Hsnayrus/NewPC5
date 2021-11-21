module decoder2_4(x, D, en);
	input [1:0] x;
	input en;
	output [3:0] D;
	wire [3:0] w;
	
	//when enable is on(1), the decoder behaves as normal. 
	//when enable is low, the output is 0
	//it is established though the use of an and gate
	decoder1_2 decoder1_2_0(.x(x[1]), .D(w[3:2]), .en(en));
	decoder1_2 decoder1_2_1(.x(x[0]), .D(w[1:0]), .en(en));
	
	and and3(D[0], w[3], w[1], en);
	and and2(D[1], w[3], w[0], en);
	and and1(D[2], w[2], w[1], en);
	and and0(D[3], w[2], w[0], en);

	

	
	
	//suddenly my brain came up with a different implementation version - check logic with TAs during office hours
	//in the end choose either above or below, NOT BOTH
	
//	wire [1:0] y;
//	not not0(y[1], x[1]);
//	not not1(y[0], x[0]);
//	and and3(D[3], en, x[1], x[0]);
//	and and2(D[2], en, x[1], y[0]);
//	and and1(D[1], en, y[1], x[0]);
//	and and0(D[0], en, y[1], y[0]);
//
//	
endmodule 