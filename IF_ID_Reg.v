module IF_ID (clk,PCadder_1,InsMem_1,branch_1,stall,PCadder_2,InsMem_2,branch_2,stall_2);

input clk;
input [31:0] PCadder_1;
input [31:0] InsMem_1;
input stall;
input branch_1;
output reg [31:0] PCadder_2;
output reg [31:0] InsMem_2;
output reg stall_2;
output reg branch_2;


initial begin
PCadder_2=0;
InsMem_2=0;
stall_2=0;
branch_2=0;
end


always @ (posedge clk) begin
PCadder_2<=PCadder_1;
InsMem_2<=InsMem_1;
stall_2<=stall;
branch_2<=branch_1;
end



endmodule


module IF_ID_tb();
wire clk;
reg [31:0] PCadder_1,InsMem_1;
wire [31:0] PCadder_2,InsMem_2;

clk_gen MyC (clk);
IF_ID AA (clk,PCadder_1,InsMem_1,PCadder_2,InsMem_2);

integer i;
initial begin
PCadder_1=0;

for(i=1;i<6;i=i+1) begin

#10 PCadder_1=PCadder_1+1;

end
end
endmodule