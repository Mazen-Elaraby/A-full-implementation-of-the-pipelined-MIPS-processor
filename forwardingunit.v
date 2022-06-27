//An implementation of the Piplined MIPS' forwarding unit
//Deals with RAW hazard from previous and 2nd previous instructions as well as double hazards
module forwarding_unit
(
	input [4:0] Rs, Rt, ex_mem_Rd, mem_wb_Rd,
	input ex_mem_wb, mem_wb_wb, //writeback control units controlling Regwrite
	output reg [1:0] forwardA, forwardB
);
reg flagA = 0;
reg flagB = 0;
always@*begin
	if(ex_mem_wb && (ex_mem_Rd != 0) && (ex_mem_Rd == Rs))begin
		forwardA = 2'b10;
		flagA = 1;
	end
	if(ex_mem_wb && (ex_mem_Rd != 0) && (ex_mem_Rd == Rt))begin
		forwardB = 2'b10;
		flagB = 1;
	end
	if(mem_wb_wb && (mem_wb_Rd != 0) && (mem_wb_Rd == Rs) && !(ex_mem_wb && (ex_mem_Rd != 0) && (ex_mem_Rd == Rs)))begin
		forwardA = 2'b01;
		flagA = 1;
	end
	if(mem_wb_wb && (mem_wb_Rd != 0) && (mem_wb_Rd == Rt) && !(ex_mem_wb && (ex_mem_Rd != 0) && (ex_mem_Rd == Rt)))begin
		forwardB = 2'b01;
		flagB = 1;
	end
	if(flagA == 0)
		forwardA = 2'b00;
	if(flagB == 0)

		forwardB = 2'b00;
	flagA=0;
	flagB=0;
end
endmodule

module forwarding_unit_tb();

//inputs
reg [4:0] Rs, Rt, ex_mem_Rd, mem_wb_Rd;
reg ex_mem_wb, mem_wb_wb;

// outputs
wire [1:0] forwardA, forwardB;
forwarding_unit tb(Rs, Rt, ex_mem_Rd, mem_wb_Rd,ex_mem_wb, mem_wb_wb,forwardA, forwardB);

initial
begin
// test values for input
Rs = 10000; Rt =10000;
ex_mem_Rd = 10000; mem_wb_Rd = 10000;
ex_mem_wb = 1'b1; mem_wb_wb = 1'b1; 
end
endmodule
