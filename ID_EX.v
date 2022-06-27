module ID_EX (clk,
RegWrite_1,MemtoReg_1,           //WB icontrols
Branch_1,MemRead_1,MemWrite_1,   //M controls
RegDst_1,ALUOp_1,ALUSrc_1,        //EX controls
IF_ID_1,                          //instruction fetch decode input
R1_1,R2_1,                        //registers input
SignEx_1,                         //sign extender input
Itwentyfive_1,                      //instruction 25 to 21
Itwenty_1,                        //intruction 20 to 16
Ififteen_1,                       //intruction 15 to 11

RegWrite_2,MemtoReg_2,
Branch_2,MemRead_2,MemWrite_2,
RegDst_2,ALUOp_2,ALUSrc_2,
IF_ID_2,
R1_2,R2_2,
SignEx_2,
Itwentyfive_2,
Itwenty_2,
Ififteen_2);

input clk,RegWrite_1,MemtoReg_1,           
Branch_1,MemRead_1,MemWrite_1,  
RegDst_1,ALUSrc_1 ;
input [1:0] ALUOp_1;
input [31:0] IF_ID_1,                          
R1_1,R2_1,                        
SignEx_1 ;

input [4:0] Itwentyfive_1,Itwenty_1,Ififteen_1;

output reg RegWrite_2,MemtoReg_2,           
Branch_2,MemRead_2,MemWrite_2,  
RegDst_2,ALUSrc_2 ;

output reg [1:0] ALUOp_2;

output reg [31:0] IF_ID_2,                          
R1_2,R2_2,                        
SignEx_2 ;

output reg [4:0] Itwentyfive_2,Itwenty_2,Ififteen_2;

//initial begin
//OP_PCadder<=0;
//OP_InsMem<=0;
//end

initial begin
Branch_2=0;
end

always @ (posedge clk) begin
RegWrite_2<=RegWrite_1;
MemtoReg_2<=MemtoReg_1;           
Branch_2<=Branch_1;
MemRead_2<=MemRead_1;
MemWrite_2<=MemWrite_1;  
RegDst_2<=RegDst_1;
ALUOp_2<=ALUOp_1;
ALUSrc_2<=ALUSrc_1;

IF_ID_2<=IF_ID_1;
R1_2<=R1_1;
R2_2<=R2_1;
SignEx_2<=SignEx_1;
Itwentyfive_2<= Itwentyfive_1;
Itwenty_2<=Itwenty_1;
Ififteen_2<=Ififteen_1;

end
endmodule


