module SubtractingExponents (
    input  wire [7:0] Exponent1,
    input  wire [7:0] Exponent2,
    input  wire       Sign1,
    input  wire       Sign2,
    output reg  [9:0] ResultantExponent,
    output wire       EffectiveSign
);

always @(*) begin
    ResultantExponent = Exponent1 - Exponent2 + 7'd127;
end
assign EffectiveSign = Sign1 ^ Sign2;

endmodule