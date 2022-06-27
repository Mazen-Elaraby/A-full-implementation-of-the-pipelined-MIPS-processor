

module Major_tb();

wire [31:0] outPC;
wire [31:0] pcin,outAdder4;      //input PC
wire [31:0] outInstruction;      //output of instruction memory
wire clk;
wire addercarr1,addercarr2;

//piplining wires:
//1
wire [31:0] outInstruction_2;
wire [31:0] outAdder4_2;

//2
wire RegWrite_2,MemtoReg_2,           
Branch_2,MemRead_2,MemWrite_2,  
RegDst_2,ALUSrc_2 ;
wire [1:0] ALUOp_2;
wire [31:0] outAdder4_3,                          
ReadData1_2,ReadData2_2,                        
OutExtender_2;
wire [14:0] outInstruction_3;

//3
wire RegWrite_3,MemtoReg_3,           
Branch_3,MemRead_3,MemWrite_3;
wire ALUzero_2;
wire [31:0] outAdderb_2,aluresult_2,ReadData2_3,writeRegister_2;

//4
wire RegWrite_4,MemtoReg_4;
wire [31:0] memorydataout_2,aluresult_3,writeRegister_3;
wire stall_pc,stall_control,stall_control_2;


clk_gen Clock (clk);
PC PC (clk,pcin,1'b0,outPC); //replaced pcin by outAdder4
instructionmemory Ins_Mem (outPC,outInstruction);
Adder32bits MyAdder (outPC,32'h4,stall_pc,outAdder4,addercarr);  //pc adder

wire RegWrite;
wire [31:0] W1Data;
wire [31:0] ReadData1;
wire [31:0] ReadData2;

wire [4:0] writeRegister;  //wire connecting register mux that chooses write register 
registerfile Register_File(clk,RegWrite_4,outInstruction_2 [25:21],outInstruction_2 [20:16],writeRegister_3,W1Data,ReadData1,ReadData2);


wire [3:0] OpSel;
wire [1:0] ALUOp,ALUOp_f;
wire RegDst,ALUSrc,MemtoReg,MemRead,MemWrite,Branch,extd,jump;
wire RegWrite_f,MemtoReg_f,Branch_f,Branch_b,MemRead_f,MemWrite_f,RegDst_f,ALUSrc_f;
wire ALUzero;

wire [31:0] aluresult; //alu mux output to be entered to alu
wire [31:0] mux_forward1_output, mux_forward2_output, mux_sec_stage_output;
wire [1:0] forwardA, forwardB;

ALU2 ALU (mux_forward1_output,mux_sec_stage_output,OpSel,ALUzero,aluresult);
	/*
	ReadData1,		//R[rs]
	ReadData2,		//R[rt]
	OpSel,	//Operation Selector
	
	ALUzero, 			//Zero for BEQ and BNE
	W1data 	//R[rd]
);*/

Hazard my_hazard(outInstruction_2 [20:16],outInstruction [25:21],outInstruction [20:16],MemRead,Branch,Branch_b,jump,stall_pc,stall_control);

forwarding_unit my_fw(outInstruction_3[14:10], outInstruction_3[9:5], writeRegister_2, writeRegister_3,RegWrite_3, RegWrite_4,forwardA, forwardB);

Mux_3_to_1_32bits mux_forward1(ReadData1_2,W1Data, aluresult_2, forwardA,mux_forward1_output); 

Mux_3_to_1_32bits mux_forward2(ReadData2_2,W1Data,aluresult_2,forwardB,mux_forward2_output);

Mux_2_to_1_32bits mux_sec_stage(mux_forward2_output,OutExtender_2,ALUSrc_2,mux_sec_stage_output);


Control_unit CU (
	
	outInstruction_2 [31:26],
	RegDst,ALUSrc,MemtoReg,RegWrite,
	       MemRead,MemWrite,Branch,extd,jump
	,ALUOp);



ALUControl2 CU_ALU (
	
	ALUOp_2,
OutExtender_2	[5:0],
	//outInstruction_2 [5:0],
	
	OpSel
	);


wire [31:0] OutExtender;  //output wire of bits extender

Extender_32b_2 MyExt (
	outInstruction_2 [15:0],	// 16 bits immediate input
	extd, // enable
	 OutExtender // extended 32 bits
);

Mux_2_to_1_5bits  MuxRegister(      
		
	outInstruction_3 [9:5],
	outInstruction_3 [4:0],
	RegDst_2,   
	writeRegister
					);
wire [31:0] memorydataout,shiftout,outAdderb;
wire andgate;
DataMemory Data_Memory(clk,MemRead_3,MemWrite_3,ReadData2_3,aluresult_2,memorydataout);

Mux_2_to_1_32bits MUXdatamemory(aluresult_3,memorydataout_2,MemtoReg_4,W1Data);

Adder32bits MyAdder2 (outAdder4_3,shiftout,1'b0,outAdderb,addercarr2);

wire [31:0] BranchToJumpMuxs;

//Mux_2_to_1_32bits MUXbranch(outAdder4,outAdderb_2,andgate,BranchToJumpMuxs); branch in mem stage

Mux_2_to_1_32bits MUXbranch(outAdder4,outAdderb,andgate,BranchToJumpMuxs);

//And andbranch(Branch_3,ALUzero_2,andgate); as written on schematic

And andbranch(Branch_2,ALUzero,andgate);

shift2_32bits branchshift(OutExtender_2,shiftout);

wire [27:0] OutputJumpShifter;

//shift2_Jump JumpShifter(outInstruction [25:0], OutputJumpShifter); jump is in IF stage

shift2_Jump JumpShifter(outInstruction_2 [25:0], OutputJumpShifter);

//wire [31:0] JumpAddress= { outAdder4_2 [31:28] ,OutputJumpShifter}; jump is in IF stage

wire [31:0] JumpAddress= { outAdder4_2 [31:28] ,OutputJumpShifter};

Mux_2_to_1_32bits MUXjump (
		
	BranchToJumpMuxs,
	JumpAddress,
	jump,   
	pcin
					);

IF_ID My_IF_ID (clk,outAdder4,outInstruction,Branch,stall_control,
//o
outAdder4_2,outInstruction_2,Branch_b,stall_control_2);

Mux_16_to_8 control_mux(RegWrite,MemtoReg,Branch,MemRead,MemWrite,RegDst,ALUOp,ALUSrc,stall_control_2,
RegWrite_f,MemtoReg_f,Branch_f,MemRead_f,MemWrite_f,RegDst_f,ALUOp_f,ALUSrc_f);

ID_EX My_ID_EX (clk,
RegWrite_f,MemtoReg_f,Branch_f,MemRead_f,MemWrite_f,RegDst_f,ALUOp_f,ALUSrc_f,
outAdder4_2,ReadData1,ReadData2,OutExtender,outInstruction_2[25:21],outInstruction_2 [20:16],outInstruction_2 [15:11],
//o
RegWrite_2,MemtoReg_2,Branch_2,MemRead_2,MemWrite_2,RegDst_2,ALUOp_2,ALUSrc_2,
outAdder4_3,ReadData1_2,ReadData2_2,OutExtender_2,outInstruction_3[14:10],outInstruction_3 [9:5],outInstruction_3 [4:0]);

EX_MEM My_EX_MEM (clk,RegWrite_2,MemtoReg_2,Branch_2,MemRead_2,MemWrite_2,outAdderb,ALUzero,aluresult,mux_forward2_output,writeRegister,
//o
RegWrite_3,MemtoReg_3,Branch_3,MemRead_3,MemWrite_3,outAdderb_2,ALUzero_2,aluresult_2,ReadData2_3,writeRegister_2);


MEM_WB My_MEM_WB (clk,RegWrite_3,MemtoReg_3,memorydataout,aluresult_2,writeRegister_2,
//o
RegWrite_4,MemtoReg_4,memorydataout_2,aluresult_3,writeRegister_3);
endmodule

