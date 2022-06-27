
// EASY INSTRUCTION MEMORY
module instructionmemory (

	input [31:0] address,	//Address to Register for Read/Write
	
	output reg [31:0] data_out 	//   Data read from the memory
);

	reg [31:0] Memory [0:20];
	wire [31:0] real_address;
assign real_address = address >> 2;
	
	always @(*) begin
		if(real_address < 16)
        data_out <= Memory[real_address];
		else
		  data_out <= 32'hx;
end 

// ENTER INSTRUCTIONS MANUALLY
initial begin
Memory[0]=32'h01897020;     //add t6 t4 t1  output: 10
Memory[1]=32'h01C96020;     //add t4 t6 t1  output: 14  RAW (previous)
Memory[2]=32'h01CE5820;     //add t3 t6 t6  output: 20  RAW (2nd-to-previous)
Memory[3]=32'h012A7822;     //sub t7 t1 t2  output: -1
Memory[4]=32'h03197822;     //sub t7 t8 t9  output: 1
Memory[5]=32'h01F8C820;     //add t9 t7 t8  output: 10   Double Hazard
end

/*
//STOP SIMULATION AT WHEN THIS ADDRESS IS ENTERED:
always@(address)begin
if(address/4==32'd5)begin    //enter instruction number directly
$stop;
end

end
*/

endmodule