module LZC_8(
input          wire        [31:0]      result,
output         wire        [4:0]       NUM_LEAD_ZERO           
);

//internal wires
wire        [7:0]        a;
wire        [2:0]        q;
wire        [1:0]        z0;
wire        [1:0]        z1;
wire        [1:0]        z2;
wire        [1:0]        z3;
wire        [1:0]        z4;
wire   	    [1:0]        z5;
wire   	    [1:0]        z6;
wire   	    [1:0]        z7;
wire        [1:0]        z;                    // output from MUX_8X1;        
wire                     SEL_MUX_2X1_NLZ;


reduction_and_8 reduction_and_8(
.a(a),
.SEL_MUX_2X1_NLZ(SEL_MUX_2X1_NLZ)
);


LZCE_8 LZCE_8(
.a(a),
.q(q)
);


MUX_2X1_C #(5) MUX_2X1_C_NLZ(
.A({q,z}),
.B(5'd0),
.sel(SEL_MUX_2X1_NLZ),
.OUT(NUM_LEAD_ZERO)
);


MUX_8X1 MUX_8X1(
.z0(z0),
.z1(z1),
.z2(z2),
.z3(z3),
.z4(z4),
.z5(z5),
.z6(z6),
.z7(z7),
.sel(q),
.out(z)
);


SLZC SLZC_6(
.b0(result[28]),
.b1(result[29]),
.b2(result[30]),
.b3(result[31]),
.a(a[7]),
.q0(z0[0]),
.q1(z0[1])
);


SLZC SLZC_7(
.b0(result[24]),
.b1(result[25]),
.b2(result[26]),
.b3(result[27]),
.a(a[6]),
.q0(z1[0]),
.q1(z1[1])
);



SLZC SLZC_8(
.b0(result[20]),
.b1(result[21]),
.b2(result[22]),
.b3(result[23]),
.a(a[5]),
.q0(z2[0]),
.q1(z2[1])
);



SLZC SLZC_9(
.b0(result[16]),
.b1(result[17]),
.b2(result[18]),
.b3(result[19]),
.a(a[4]),
.q0(z3[0]),
.q1(z3[1])
);


SLZC SLZC_10(
.b0(result[12]),
.b1(result[13]),
.b2(result[14]),
.b3(result[15]),
.a(a[3]),
.q0(z4[0]),
.q1(z4[1])
);


SLZC SLZC_11(
.b0(result[8]),
.b1(result[9]),
.b2(result[10]),
.b3(result[11]),
.a(a[2]),
.q0(z5[0]),
.q1(z5[1])
);




SLZC SLZC_12(
.b0(result[4]),
.b1(result[5]),
.b2(result[6]),
.b3(result[7]),
.a(a[1]),
.q0(z6[0]),
.q1(z6[1])
);


SLZC SLZC_13(
.b0(result[0]),
.b1(result[1]),
.b2(result[2]),
.b3(result[3]),
.a(a[0]),
.q0(z7[0]),
.q1(z7[1])
);




endmodule