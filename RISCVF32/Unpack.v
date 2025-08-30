module Unpack(
    input  wire [31:0] Op1,
    input  wire [31:0] Op2,
    output wire        Sign1,
    output wire        Sign2,
    output wire [7:0]  Exponent1,
    output wire [7:0]  Exponent2,
    output wire [23:0] Mantissa1,
    output wire [23:0] Mantissa2,
    output wire        ZeroFlag
);

assign Sign1     = Op1[31];
assign Sign2     = Op2[31];
assign Exponent1 = Op1[30:23];
assign Exponent2 = Op2[30:23];
assign Mantissa1 = {1'b1, Op1[22:0]};
assign Mantissa2 = {1'b1, Op2[22:0]};
assign ZeroFlag  = (Op1[30:23] == 'b0 || Op2[30:23]== 'b0) ? 1'b1 : 1'b0;

endmodule