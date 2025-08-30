module Control_Unit(
input       wire         		     Zero,
input       wire      [6:0]          OP,
input       wire      [2:0]          funct3,
input       wire        			 funct75,
input       wire      [4:0]          funct5,
input       wire      [4:0]          rs2,
output      wire                     PCsrc,
output      wire      [1:0]          IMMSRC,
output      wire      [2:0]          ResultSrc,
output      wire                     MemWrite,
output      wire                     ALUSRC,
output      wire                     REGWRITE,
output      wire      [2:0]          ALU_CONTROL,
output      wire                     REGWRITE_F,
output      wire                     DATA_MEM_SRC,
output      wire       [3:0]         FPU_CONTROL,
output      wire                     fsrc
);

//internal wires
 wire      [1:0]          ALU_OP;
 wire                     Branch;
 wire                     Jump;  
 wire                     FPU_OP;


MAIN_DECODER MAIN_DECODER(
.OP(OP),
.funct5(funct5),
.IMMSRC(IMMSRC),
.ALU_OP(ALU_OP),
.ResultSrc(ResultSrc),
.MemWrite(MemWrite),
.ALUSRC(ALUSRC),
.REGWRITE(REGWRITE),
.Branch(Branch),
.Jump(Jump),
.REGWRITE_F(REGWRITE_F),
.FPU_OP(FPU_OP),
.DATA_MEM_SRC(DATA_MEM_SRC),
.fsrc(fsrc)      
);

assign PCsrc = (Zero & Branch) | Jump ;


ALU_DECODER ALU_DECODER(
.ALUOP(ALU_OP),
.funct3(funct3),
.op5(OP[5]),
.funct75(funct75),
.ALU_CONTROL(ALU_CONTROL)
);

FPU_DECODER FPU_DECODER(
.FPU_OP(FPU_OP),
.funct5(funct5),
.rs2(rs2),
.funct3(funct3),
.FPU_CONTROL(FPU_CONTROL)
);








endmodule