module DivisionUnit (
    input  wire [31:0] Op1,
    input  wire [31:0] Op2,
    output wire [31:0] Result,
    output wire        DZF,
    output wire        ZeroFlag
);


wire [7:0]  Exponent1;
wire [7:0]  Exponent2;
wire [9:0]  ResultantExponent;
wire [23:0] Mantissa1;
wire [23:0] Mantissa2;
wire        EffectiveSign;
wire        Sign1;
wire        Sign2;

Unpack                 UnpackTop
(.Op1                  (Op1),
 .Op2                  (Op2),
 .Sign1                (Sign1),
 .Sign2                (Sign2),
 .Exponent1            (Exponent1),
 .Exponent2            (Exponent2),
 .Mantissa1            (Mantissa1),
 .Mantissa2            (Mantissa2),
 .ZeroFlag             (ZeroFlag)
);

SubtractingExponents   SubtractingExponentsTop
(.Exponent1            (Exponent1),
 .Exponent2            (Exponent2),
 .Sign1                (Sign1),
 .Sign2                (Sign2),
 .ResultantExponent    (ResultantExponent),
 .EffectiveSign        (EffectiveSign)
);

DivisionModule         DivisionModuleTop
(.Mantissa1            (Mantissa1),
 .Mantissa2            (Mantissa2),
 .ResultantExponent    (ResultantExponent[7:0]),
 .EffectiveSign        (EffectiveSign),
 .DZF                  (DZF),
 .Result               (Result)
);

endmodule