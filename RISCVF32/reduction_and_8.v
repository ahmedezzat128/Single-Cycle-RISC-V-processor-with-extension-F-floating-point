module reduction_and_8(
input     wire    [7:0]   a,
output    wire            SEL_MUX_2X1_NLZ
);

assign SEL_MUX_2X1_NLZ = & a;




endmodule