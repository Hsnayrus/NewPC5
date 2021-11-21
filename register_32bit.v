module register_32bit(q, d, clk, en, clr);
input clk, en, clr;
input [31:0] d;
output [31:0] q;

generate
    genvar i;
	for(i=0;i<32;i=i+1) begin: connecting32DFFE
         dffe_ref dffe0(q[i], d[i], clk, en, clr); 
    end
endgenerate

endmodule
