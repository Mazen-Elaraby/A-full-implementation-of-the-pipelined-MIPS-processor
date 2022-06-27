module ALUControl2 (
	
	input [1:0] ALUOp,	
	input [5:0] funct,
	
	output reg [3:0] OpSel
	);
	
	localparam 
			AND = 4'h0, 
			OR = 4'h1, 
			ADD = 4'h2, 
			SUB = 4'h6,
			SLT = 4'h7;
	
	always @(*) begin
		case(ALUOp) 
			2'b00: OpSel = ADD; // for sw and lw do add
			2'b01: OpSel = SUB; // for beq do sub
			2'b11: OpSel = ADD; // for addi do add
			2'b10: case(funct)  // for R-type instructions
				6'h24: OpSel = AND;
				6'h25: OpSel = OR;
				6'h20: OpSel = ADD;
				6'h22: OpSel = SUB;
				6'h2a: OpSel = SLT;
				default: OpSel = 4'hx;
			endcase
		endcase
	end
	
endmodule