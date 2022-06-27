
module Control_unit (
	
	input [5:0] Opcode,	
	
	output reg RegDst,ALUSrc,MemtoReg,RegWrite,
	       MemRead,MemWrite,Branch,extd,jump,
	output reg [1:0] ALUOp

	);

	 reg [10:0] controls;

	always @(*) begin
		case(Opcode) 
			 
			6'h23: controls = 11'b011_1100_0010; // lw
			6'h2b: controls = 11'bx1x_0010_0010; // sw
			6'h04: controls = 11'bx0x00010100; // beq
			6'h08: controls = 11'b010_1000_1110; // addi
			6'h00: controls = 11'b100_1000_10x0; // R-type
			6'h02: controls = 11'b000_0000_0001; //demo j
			default: controls = 11'bxxx_xxxx_xxxx;		
		endcase
	end

assign RegDst = controls[10];   assign ALUSrc = controls[9];
assign MemtoReg = controls[8];  assign RegWrite = controls[7];
assign MemRead = controls[6];   assign MemWrite = controls[5];
assign Branch = controls[4];    assign extd = controls[1];
assign jump = controls[0];      assign ALUOp = controls[3:2];
//assign jump = 0; 

initial begin
jump=0;
Branch=0;
end

endmodule