// Register File
module registerfile(clk,RegWrite,R1,R2,W,WData,Out1,Out2);
//R1,R2,W1 (Register numbers)
//WD1 (data to be written)
input clk;
input RegWrite;
input [4:0] R1,R2;
input [4:0] W;
input [31:0] WData;

output reg [31:0] Out1,Out2;
reg [31:0] rf[0:31];

reg [31:0] t [0:9];

genvar  arrayregisterindex;
for( arrayregisterindex=0;arrayregisterindex<8;arrayregisterindex=arrayregisterindex+1)
assign t[arrayregisterindex]=rf[8+arrayregisterindex];
for(arrayregisterindex=8;arrayregisterindex<10;arrayregisterindex=arrayregisterindex+1)
assign t[arrayregisterindex]=rf[24+arrayregisterindex-8];

// FILL REGISTERS MANUALLY IF NEEDED
initial begin

rf[8]=32'd9; 			// $t0 

rf[9]=4; 			// $t1 

rf[10]=5; 			// $t2

rf[11]=32'bx; 			// $t3 

rf[12]=6; 			// $t4 

rf[13]=32'bx; 			// $t5 

rf[14]=32'bx; 			// $t6  

rf[15]=9; 			// $t7

rf[24]=9;			// $t8

rf[25]=8;         		// $t9



rf[0]=0;        //$zero is always zero
end


always@(R1,R2) begin

Out1<=rf[R1];


Out2<=rf[R2];

end

always@(posedge clk) 
if(RegWrite ==1)  //need to be edited to be posedge
	if(W!=0) begin
		rf[W]<=WData;

end



endmodule