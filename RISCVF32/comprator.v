module comprator(
input         wire     			       [31:0]       OP_A,
input         wire            		   [31:0]       OP_B,
input         wire                     [3:0]        FPU_Control,
output        wire                     [31:0]       R      
);



wire              [31:0]                   R_L;
wire              [31:0]                   R_E;
wire              [31:0]                   R_LE;
wire              [1:0]                    sel_f;



encoder encoder(
.FUNC_SEL(FPU_Control),
.sel_f(sel_f)
);


less_than_equal less_than_equal(
.OP_A(OP_A),
.OP_B(OP_B),
.R(R_LE)
);   


less_than less_than(
.OP_A(OP_A),
.OP_B(OP_B),
.R(R_L)      
);

equal equal(
.OP_A(OP_A),
.OP_B(OP_B),
.R(R_E)      
);




MUX_3X1 #(32) MUX_3X1(
.A(R_E),
.B(R_L),
.C(R_LE),
.sel(sel_f),
.OUT(R)
);


endmodule