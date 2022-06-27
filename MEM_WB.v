module MEM_WB (input clk,
input RegWrite_1,input MemtoReg_1,           //WB icontrols
input [31:0] Read_data_1,
input [31:0] Address_1,
input [4:0] EX_MEM_1,

output reg RegWrite_2,output reg MemtoReg_2,           //WB icontrols
output reg [31:0] Read_data_2,
output reg [31:0] Address_2,
output reg [4:0] EX_MEM_2
);

always @ (posedge clk) begin
RegWrite_2<=RegWrite_1;
MemtoReg_2<=MemtoReg_1;           

Read_data_2<=Read_data_1;
Address_2<=Address_1;
EX_MEM_2<=EX_MEM_1;

end

endmodule
