module decoder5_32(x, D, en);
	input en;
	input [4:0] x;
	output [31:0] D;
	
	wire [11:0] w;
//	//Here i design 5_32 decoder based on one 3-8 decoder and one 2-4 decoder.
//	//Based on the putputs from both of these, there will be 12 wires present

	decoder3_8 d3_8_0(.x(x[4:2]), .D(w[11:4]), .en(en));
	decoder2_4 d2_4_1(.x(x[1:0]), .D(w[3:0]), .en(en));

	and and0(D[28], w[11], w[3], en);
	and and1(D[29], w[11], w[2], en);
	and and2(D[30], w[11], w[1], en);
	and and3(D[31], w[11], w[0], en);
	
	
	and and4(D[24], w[10], w[3], en);
	and and5(D[25], w[10], w[2], en);
	and and6(D[26], w[10], w[1], en);
	and and7(D[27], w[10], w[0], en);
	
	and and8(D[20], w[9], w[3], en);
	and and9(D[21], w[9], w[2], en);
	and and10(D[22], w[9], w[1], en);
	and and11(D[23], w[9], w[0], en);
	
	
	and and12(D[16], w[8], w[3], en);
	and and13(D[17], w[8], w[2], en);
	and and14(D[18], w[8], w[1], en);
	and and15(D[19], w[8], w[0], en);
	
	and and16(D[12], w[7], w[3], en);
	and and17(D[13], w[7], w[2], en);
	and and18(D[14], w[7], w[1], en);
	and and19(D[15], w[7], w[0], en);
	
	and and20(D[8], w[6], w[3], en);
	and and21(D[9], w[6], w[2], en);
	and and22(D[10], w[6], w[1], en);
	and and23(D[11], w[6], w[0], en);
	
	and and24(D[4], w[5], w[3], en);
	and and25(D[5], w[5], w[2], en);
	and and26(D[6], w[5], w[1], en);
	and and27(D[7], w[5], w[0], en);
	
	and and28(D[0], w[4], w[3], en);
	and and29(D[1], w[4], w[2], en);
	and and30(D[2], w[4], w[1], en);
	and and31(D[3], w[4], w[0], en);
	
	
//	wire [4:0] w;
//	
//	not not0(w[4], ctrlBits[0]);
//	not not1(w[3], ctrlBits[1]);
//	not not2(w[2]. ctrlBits[2]);
//	not not3[w[1], ctrlBits[3]);
//	not not4(w[0], ctrlBits[4]);
//		
//	and and0(d[0], w[4], w[3], w[2], w[1], w[0]);
//	and and1(d[1], w[4], w[3], w[2], w[1], ctrlBits[0]);
//	and and2(d[2], w[4], w[3], w[2], ctrlBits[1], w[0]);
//	and and3(d[3], w[4], w[3], w[2], w[1], 
//	and and4
//	and and5
//	and and6
	
endmodule 