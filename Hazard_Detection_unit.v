module Hazard (rt_ex,rs_id,rt_id,memread,branch,branch_b,jump,stall_pc,stall_control);

input [4:0] rt_ex,rs_id,rt_id; //rt in execution stage(of lw instruction) , rs and rt in ID stage(of instruction after lw) 
input memread,branch,branch_b,jump; // memread which indicates lw instruction
output reg stall_pc,stall_control; // 2 wires to stall pc or controls
	

always @(*)

begin


if ((memread==1 && (rt_ex==rs_id || rt_ex==rt_id)) || branch==1 || branch_b==1 || jump==1) /* checking lw then if rd of first instruction 
(in ex stage) equal to either rs or rt (in decode stage) or if there is branch or jump*/
stall_control <= 1; // stalling controls in case of jump , branch (2 stalls for branch) or lw with dependency 
       
else 
stall_control <= 0; 

if((memread==1 && (rt_ex==rs_id || rt_ex==rt_id)) || branch==1 || branch_b==1)
stall_pc <= 1; // stalling pc in case of branch (2 stalls for branch) or lw with dependency

else
stall_pc <=0; 

end	
					
endmodule


module Hazard_tb();

//inputs
reg [4:0] rt_ex,rs_id,rt_id;  
reg memread,branch,branch_b,jump;

// outputs
wire stall_pc,stall_control;

Hazard tb(rt_ex,rs_id,rt_id,memread,branch,branch_b,jump,stall_pc,stall_control);
 
initial
begin
// test values for input
memread=1'b1; branch=1'b0; branch_b=1'b0; jump=1'b0; rt_ex=5'h4; rs_id=5'h4; rt_id=5'h6;
end
endmodule