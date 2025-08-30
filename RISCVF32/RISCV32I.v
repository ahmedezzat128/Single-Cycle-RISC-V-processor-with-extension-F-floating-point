module RISCV32I(
input       wire              CLK,
input       wire              RST
);






////////////////////////////////////////////// internal wires ////////////////////////////////////////
wire         		     Zero;
wire        [6:0]        OP;
wire        [2:0]        funct3;
wire        			 funct75;
wire                     PCsrc;
wire        [1:0]        IMMSRC;
wire        [2:0]        ResultSrc;
wire                     MemWrite;
wire                     ALUSRC;
wire                     REGWRITE;
wire      [2:0]          ALU_CONTROL;
wire      [31:0]         ALU_RESULT;
wire      [31:0]         PC;
wire      [31:0]         INSTR;
wire      [31:0]         PCNEXT;
wire      [31:0]         RESULT;
wire      [31:0]         SRCA;
wire      [31:0]         SRCB_BM;
wire      [31:0]         SRCB;
wire      [31:0]         IMMEXT;
wire      [31:0]         ReadData;
wire      [31:0]         PC_PLUS4;
wire      [31:0]         PC_Target;
wire      [31:0]         FPU_RESULT;
wire      [31:0]         SRCA_F;
wire      [31:0]         SRCB_F;
wire      [3:0]          FPU_CONTROL;
wire                     REGWRITE_F;
wire                     DATA_MEM_SRC;
wire      [31:0]         WD_DATAMEM;
wire                     fsrc;
wire      [31:0]         FOPA;
////////////////////////////////////////////////////////////////////////////////////////////////////


IM IM(
.A1(PC),
.RD(INSTR)   
);

Reg_File Reg_File(
.CLK(CLK),
.RST(RST),
.A1(INSTR[19:15]),
.A2(INSTR[24:20]),
.A3(INSTR[11:7]),
.WD3(RESULT),
.WE3(REGWRITE),
.RD1(SRCA),
.RD2(SRCB_BM)
);

MUX_2x1_R MUX_2x1_R_ua(
.A(SRCB_BM),
.B(IMMEXT),
.sel(ALUSRC),
.C(SRCB)
);



Control_Unit Control_Unit(
.Zero(Zero),
.OP(INSTR[6:0]),
.funct3(INSTR[14:12]),
.funct75(INSTR[30]),
.PCsrc(PCsrc),
.IMMSRC(IMMSRC),
.rs2(INSTR[24:20]),
.funct5(INSTR[31:27]),
.ResultSrc(ResultSrc),
.MemWrite(MemWrite),
.ALUSRC(ALUSRC),
.REGWRITE(REGWRITE),
.ALU_CONTROL(ALU_CONTROL),
.FPU_CONTROL(FPU_CONTROL),
.REGWRITE_F(REGWRITE_F),
.DATA_MEM_SRC(DATA_MEM_SRC),
.fsrc(fsrc)
);

PC PC_U(
.CLK(CLK),
.RST(RST),
.PCNEXT(PCNEXT),
.PC(PC)
);

///////////////////////////////////// MUX Before Pc ///////////////////////////////////
MUX_2x1_R MUX_2x1_R(
.A(PC_PLUS4),
.B(PC_Target),
.sel(PCsrc),
.C(PCNEXT)
);

//////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////// Mux Before Data Memory ////////////////////////
MUX_2x1_R MUX_2x1_R_1(
.A(SRCB_F),
.B(SRCB_BM),
.sel(DATA_MEM_SRC),
.C(WD_DATAMEM)
);
//////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////// Mux After Data Memory ////////////////////////
MUX_6x1_R MUX_6x1_R(
.A(ALU_RESULT),
.B(ReadData),
.D(PC_PLUS4),
.E(FPU_RESULT),
.F(SRCA),
.G(SRCA_F),
.sel(ResultSrc),
.C(RESULT)
);
///////////////////////////////////////////////////////////////////////////////////////

MUX_2x1_R MUX_2x1_R_uf(
.A(SRCA_F),
.B(SRCA),
.sel(fsrc),
.C(FOPA)
);

Reg_File_FLEN Reg_File_FLEN(
.CLK(CLK),
.RST(RST),
.A1(INSTR[19:15]),
.A2(INSTR[24:20]),
.A3(INSTR[11:7]),
.WD3(RESULT),
.WE3(REGWRITE_F),
.RD1(SRCA_F),
.RD2(SRCB_F)
);



FPU FPU(
.OP_A(FOPA),
.OP_B(SRCB_F),
.FPU_Control(FPU_CONTROL),
.Result(FPU_RESULT)
);



DATA_MEM DATA_MEM(
.CLK(CLK),
.A(ALU_RESULT[4:0]),
.WE(MemWrite),
.WD(WD_DATAMEM),
.RD(ReadData)
 );
 
  
 EXTEND EXTEND(
.INSTR(INSTR[31:7]),
.IMMSRC(IMMSRC),
.IMMEXT(IMMEXT)
);

ADDER_4 ADDER_4(
.A(PC),
.B(32'd4),
.C(PC_PLUS4)    
);

ALU ALU(
.A(SRCA),
.B(SRCB),
.ALU_CONTROL(ALU_CONTROL),
.ALU_RESULT(ALU_RESULT),
.Zero(Zero)
);

ADDER ADDER(
.A(PC),
.B(IMMEXT),
.C(PC_Target)    
);


endmodule