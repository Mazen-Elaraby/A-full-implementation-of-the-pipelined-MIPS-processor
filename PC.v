module PC (clk,DataIn,reset,DataOut);

input clk,reset;
input [31:0] DataIn;
output reg [31:0] DataOut;


initial begin
DataOut<=0;
end


always @ (posedge clk) begin

DataOut<=DataIn;

end

always@ (reset) begin
if(reset==1)
DataOut<=0;
end

endmodule
