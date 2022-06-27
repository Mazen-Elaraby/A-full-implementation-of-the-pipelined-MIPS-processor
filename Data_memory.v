//EASY DATA MEMORY
module DataMemory (clk,MemRead,MemWrite,DataIn,RWAddress,DataOut);
input clk;
input [31:0] DataIn,RWAddress;
input MemRead,MemWrite;
output reg [31:0] DataOut;

parameter Words=14;

reg [31:0] Memory [0:Words-1];

reg [31:0] InnerAddress;
assign InnerAddress=RWAddress>>2;

always @ (MemRead,MemWrite,RWAddress) begin

if((MemRead==1) & (MemWrite==0)) begin

DataOut<= {Memory[InnerAddress]};


end

end

always @(posedge clk) begin  //posedge clk
if ((MemRead==0) & (MemWrite==1)) begin

Memory[InnerAddress]<=DataIn;

end 
end

initial begin
Memory[1]=32'hf0f0f;
end
endmodule
