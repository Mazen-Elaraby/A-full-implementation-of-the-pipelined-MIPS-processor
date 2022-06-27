
module clk_gen(clk);
output reg clk;
initial clk =0;
always #10 clk=~clk;
endmodule





module Extender_32b_2 (
	input [15:0] immediate,	// 16 bits immediate input
	input extd, // enable
	output [31:0] extendedno // extended 32 bits
);
	
	assign extendedno = (extd==1) ?
	((immediate[15] == 1) ? {16'hFFFF,immediate}: {16'h0000,immediate}):{16'h0000,immediate};

endmodule









module Adder32bits (                            
	
	input [31:0] A,	
	input [31:0] B,
	input stall,	
	
	
	output [31:0] added,
	output Carry
);

	reg [32:0] sumandcarry;

	always@(*) begin

	if (stall == 0)
	assign sumandcarry = {1'b0,B} + {1'b0,A};

	else assign sumandcarry = {1'b0,A} + 0;
	end

	assign added = sumandcarry[31:0];
	assign Carry = sumandcarry[32];
	
endmodule




module Mux_2_to_1_32bits (
		
	input   [31:0]  passzero,
	input   [31:0]  passone,
	input   selection,   
	output  [31:0]  selectedout
					);
assign  selectedout = (selection)? passone : passzero;
endmodule




module Mux_2_to_1_5bits (
		
	input   [4:0]  passzero,
	input   [4:0]  passone,
	input   selection,   
	output  [4:0]  selectedout
					);
assign  selectedout = (selection)? passone : passzero;
endmodule




module Mux_3_to_1_32bits (
		
	input   [31:0]  passzero_zero, passzero_one, passone_zero, 
	input   [1:0]   selection,   
	output reg  [31:0]  selectedout
					);
	always@(*)begin
		case(selection)
		2'b00: selectedout <= passzero_zero;
		2'b01: selectedout <= passzero_one;
		2'b10: selectedout <= passone_zero;
		endcase
	end
endmodule



module Mux_16_to_8 (
		
	input RegWrite,MemtoReg,Branch,MemRead,MemWrite,RegDst,
	input [1:0] ALUOp,
	input ALUSrc,
	input selection,   
	output reg RegWrite_f,MemtoReg_f,Branch_f,MemRead_f,MemWrite_f,RegDst_f,
	output reg [1:0] ALUOp_f,
	output reg ALUSrc_f	

			);
always @(*) begin
if (selection == 0) begin

RegWrite_f <= RegWrite; MemtoReg_f <= MemtoReg; Branch_f <= Branch; MemRead_f <= MemRead;
MemWrite_f <= MemWrite; RegDst_f <= RegDst; ALUOp_f <= ALUOp; ALUSrc_f <= ALUSrc;

end

else begin

RegWrite_f <= 0; MemtoReg_f <= 0; Branch_f <= 0; MemRead_f <= 0;
MemWrite_f <= 0; RegDst_f <= 0;  ALUOp_f <= 0; ALUSrc_f <= 0;

end
end

endmodule





module And(input A,B, output c);
assign c = A & B;
endmodule

module shift2_32bits(input [31:0] A, output [31:0] c);
assign c = A << 2;
endmodule

module shift2_Jump(input [25:0] A, output [27:0] c);
assign c = {A ,2'b0};
endmodule













