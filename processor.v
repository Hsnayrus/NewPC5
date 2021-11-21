/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset;
	 
    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 
	 wire clk4;
	 wire is_rType, is_addi, is_sub, is_add, is_or, is_sll, is_sra, is_sw, is_lw, is_j, is_bne, is_jal, is_jr, is_blt, is_bex, is_setx, is_jiType, rstatus, jump_bne, addOverflow, subOverflow, addiOverflow;
	 wire isNotEqual, isLessThan, overflow;
	 wire [4:0] Opcode, rd, rs, rt, shamt, ALU_op;
	 wire[15:0] immediate;
	 wire[26:0] target; // target is jump address for branching
	 wire[31:0] jump, targetExtended ,addressExtended, signExtended, data_operandA, data_operandB, data_result;
	 
	 assign Opcode    = q_imem[31:27];
	 assign is_rType  = ~Opcode[4] && ~Opcode[3] && ~Opcode[2] && ~Opcode[1] && ~Opcode[0];                    //00000
	 assign is_addi   = ~Opcode[4] && ~Opcode[3] && Opcode[2]  && ~Opcode[1] && Opcode[0];                    //00101
	 assign is_sw     = ~Opcode[4] && ~Opcode[3] && Opcode[2]  && Opcode[1]  && Opcode[0];                   //00111
	 assign is_lw     = ~Opcode[4] && Opcode[3]  && ~Opcode[2] && ~Opcode[1] && ~Opcode[0];                 //01000
	 assign is_add    = is_rType && ~ALU_op[4] && ~ALU_op[3] && ~ALU_op[2] && ~ALU_op[1] && ~ALU_op[0];    //00000
	 assign is_sub    = is_rType && ~ALU_op[4] && ~ALU_op[3] && ~ALU_op[2] && ~ALU_op[1] && ALU_op[0];    //00001 
	 assign is_j      = ~Opcode[4] && ~Opcode[3] && ~Opcode[2]&& ~Opcode[1] && Opcode[0];                //00001
	 assign is_bne    = (~Opcode[4] && ~Opcode[3] && ~Opcode[2]&& Opcode[1] && ~Opcode[0]);             //00010
	 assign is_jal    = ~Opcode[4] && ~Opcode[3] && ~Opcode[2]&& Opcode[1] && Opcode[0];               //00011
	 assign is_jr     = ~Opcode[4] && ~Opcode[3] && Opcode[2]&& ~Opcode[1] && ~Opcode[0];             //00100
	 assign is_blt    = ~Opcode[4] && ~Opcode[3] && Opcode[2]&& Opcode[1] && ~Opcode[0];             //00110
	 assign is_bex    = Opcode[4] && ~Opcode[3] && Opcode[2]&& Opcode[1] && ~Opcode[0];             //10110
	 assign is_setx   = Opcode[4] && ~Opcode[3] && Opcode[2]&& ~Opcode[1] && Opcode[0];            //10101
	 
	 assign rd     = q_imem[26:22];
	 assign rs     = q_imem[21:17];
	 assign rt     = q_imem[16:12];
	 assign shamt  = q_imem[11: 7];
	 assign ALU_op = is_rType? q_imem[6:2]  : 5'h00;
	 
	 assign immediate = q_imem[15:0]; 
	 
	 assign addOverflow  = is_add  && overflow;
	 assign subOverflow  = is_sub  && overflow;
	 assign addiOverflow = is_addi && overflow;
	 
	 assign jump_bne  = is_bne && isNotEqual;
	 
	 assign rstatus = ~(data_readRegA == 32'h00000000);
	 assign is_jiType = is_j || is_jal || (is_bex && rstatus);
	 
	 assign target              = q_imem[26:0];
	 assign targetExtended      = {5'h00, target};
	 assign signExtended[15: 0] = immediate;
	 assign signExtended[31:16] = immediate[15] ? 16'hFFFF : 16'h0000;
	 assign addressExtended     = {20'h00000, address_imem};
	 
	 reg[31:0] pc;
	 
	 always @(posedge clock) begin
		#1 pc <= jump;
	 end
	 
	 assign ctrl_writeEnable = ~clock && (is_rType || is_addi || is_jal || is_setx || is_lw);
	 
	 assign address_imem  = pc[11:0];
	 
	 assign jump          = is_jiType ? targetExtended : (is_jr ? data_readRegA : (jump_bne ? (signExtended + 1'b1) : (addressExtended + 1'b1)));
//    assign jump = is_j ? targetExtended : addressExtended + 1'b1;
	 
	 assign ctrl_readRegA = (is_bne || is_jr || is_sw)  ? rd : ((is_rType || is_addi || is_lw) ? rs : 5'h1E); // in case of bex its 1E
	 
	 assign ctrl_readRegB = (is_bne || is_blt) ? rs : (is_rType ? rt : 5'hzz);                  // rs in case of bne	 
	 
	 assign ctrl_writeReg = is_jal ? 5'h1F : (is_setx || overflow ? 5'h1E : (is_addi || is_rType || is_lw ? rd : 5'h00)); 
	 
	 assign data_operandA = data_readRegA;
	 
	 assign data_operandB = (is_addi || is_sw || is_lw) ? signExtended : data_readRegB;
	 
	 assign wren          = is_sw;
	 
	 assign data          = is_sw ? data_readRegA : 32'h00000000;
	 
	 assign data_writeReg = is_jal ? (addressExtended + 1'b1) : (is_setx ? targetExtended : (addOverflow ? 32'd1 : (subOverflow ? 32'd2 : (addiOverflow ? 32'd3 : (is_lw ? q_dmem : data_result)))));
	  
	 assign address_dmem  = (is_sw || is_lw) ? data_result[11:0] : 12'h000;	 
	 
	 //Instantiate the ALU module
	 alu alu1(data_operandA, data_operandB, ALU_op, shamt, data_result, isNotEqual, isLessThan, overflow);
endmodule
