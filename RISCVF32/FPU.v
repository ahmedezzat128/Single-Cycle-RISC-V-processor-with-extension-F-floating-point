module FPU(
input           wire             [31:0]          OP_A,
input           wire             [31:0]          OP_B,
input           wire             [3:0]           FPU_Control,
output          wire             [31:0]          Result
);

////////////////////////////////////////////////////// internal signals ///////////////////////////////////////////////////////
wire                [31:0]               ADD_SUB_OUT;
wire                [31:0]               CMP_OUT;
wire                [31:0]               sign_inj_OUT;
wire                [31:0]               MUL_OUT;
wire                [31:0]               DIV_OUT;
wire                [31:0]               CVT_OUT;
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






comprator comprator(
.OP_A(OP_A),
.OP_B(OP_B),
.FPU_Control(FPU_Control),
.R(CMP_OUT)      
);



ADD_SUB ADD_SUB(
.OP_A(OP_A),  
.OP_B(OP_B),
.FUNC(FPU_Control),
.IEEE_FORMAT(ADD_SUB_OUT)
);




sign_inj sign_inj(
.OP_A(OP_A),
.OP_B(OP_B),
.FUNC(FPU_Control),
.result(sign_inj_OUT)
);




CVT CVT(
.A(OP_A),
.FUNC(FPU_Control),
.result(CVT_OUT)
);

DivisionUnit DivisionUnit(
.Op1(OP_A),
.Op2(OP_B),
.Result(DIV_OUT)
);



multiplier multiplier(
.a(OP_A), 
.b(OP_B), 
.out(MUL_OUT)
);


MUX_6x1_T MUX_6x1_T(
.IN1(ADD_SUB_OUT),
.IN2(MUL_OUT),
.IN3(DIV_OUT),
.IN4(CMP_OUT),
.IN5(CVT_OUT),
.IN6(sign_inj_OUT),
.FPU_Control(FPU_Control),
.OUT(Result)
);





endmodule