module ALU2 (A,B, OpSel,zero, Res);
	
input [31:0] A;
input [31:0] B;
 input [3:0] OpSel;
output zero;
output reg [31:0] Res;
	//Codification for ALU Operation

always @(*) 
begin
case(OpSel)
	4'h1: Res = A | B;            // or
	4'h2: Res = A + B;            // add
	4'h0: Res = A & B;            // and
	4'h6: Res = A - B;            // subtract
	4'h7: Res = (A < B)?  32'b1 : 32'b0;  // slt
	default: Res = 32'b0;
endcase
end

						
assign zero = (Res==32'b0)? 1'b1 : 1'b0;

endmodule