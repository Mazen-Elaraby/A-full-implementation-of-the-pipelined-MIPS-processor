module EX_MEM (input clk,
input RegWrite_1,input MemtoReg_1,           //WB icontrols
input Branch_1,input MemRead_1,input MemWrite_1,   //M controls
input [31:0] Add_1,
input Zero_1,                          
input [31:0] AluRes_1,                        
input [31:0] ID_EX_1,
input [4:0] Mux_1,

output reg RegWrite_2,output reg MemtoReg_2,           //WB icontrols
output reg Branch_2,output reg MemRead_2,output reg MemWrite_2,   //M controls
output reg [31:0] Add_2,
output reg Zero_2,                          
output reg [31:0] AluRes_2,                        
output reg [31:0] ID_EX_2,
output reg [4:0] Mux_2);

initial begin
Branch_2=0;
end

always @ (posedge clk) begin
RegWrite_2<=RegWrite_1;
MemtoReg_2<=MemtoReg_1;           
Branch_2<=Branch_1;
MemRead_2<=MemRead_1;
MemWrite_2<=MemWrite_1;  

Add_2<=Add_1;
Zero_2<=Zero_1;
AluRes_2<=AluRes_1;

ID_EX_2<=ID_EX_1;

Mux_2<=Mux_1;

end

endmodule


