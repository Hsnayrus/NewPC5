module decoder3_8(x, D, en);
	input [2:0] x;
	input en;
	output [7:0] D;
	//wire [2:0] y; //temp for not gate use
	wire [5:0] w;
	decoder2_4 d2_4_0(.x(x[2:1]), .D(w[5:2]), .en(en)); 
	decoder1_2 d1_2_0(.x(x[0]),.D(w[1:0]), .en(en));
	
	and and0(D[1], w[5], w[1], en);
	and and1(D[0], w[5], w[0], en);
	
	and and2(D[3], w[4], w[1], en);
	and and3(D[2], w[4], w[0], en);
	
	and and4(D[5], w[3], w[1], en);
	and and5(D[4], w[3], w[0], en);
	
	and and6(D[7], w[2], w[1], en);
	and and7(D[6], w[2], w[0], en);
endmodule 