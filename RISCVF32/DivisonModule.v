module DivisionModule (
  input  wire [23:0] Mantissa1, //Div
  input  wire [23:0] Mantissa2, //Divisor
  input  wire        EffectiveSign,
  input  wire [7:0]  ResultantExponent,
  output reg         DZF,
  output wire [31:0] Result
);

  reg  [23:0] A;
  reg  [23:0] Q;
  reg  [47:0] ACC;
  reg  [47:0] C;

  integer i;

  always @(Mantissa1 or Mantissa2) begin
    if(Mantissa2[22:0] == 23'b0) begin
      DZF    = 1'b1;
      A      = 24'b0;
      Q      = 24'b0;
      ACC    = 48'b0;
      C      = 48'b0;
    end
    else begin
      A   = 24'b0;
      Q   = Mantissa1;
      ACC = {A, Q};
      C   = 24'b0;
      for(i=0; i<24; i = i + 1) begin
          ACC = ACC<<1;
          A   = ACC[47:24];
          Q   = ACC[23:0];
          A   = A - Mantissa2;
        if(A[23]) begin
            Q[0]     = 1'b0; //Updating the LSB in Q
            A        = ACC[47:24]; //Restoring A
            ACC[23:0] = {Q[23:1], 1'b0};
            C = ACC;
        end
        else begin
            Q[0]     = 1'b1; //Updating the LSB in Q 
            ACC[47:24] = A;
            ACC[23:0] = {Q[23:1], 1'b1};
            C = ACC;
        end
    end
      DZF    = 1'b0;
    end
    
  end
assign Result = (DZF)?  {EffectiveSign, 8'b1111_1111, 23'b0} : {EffectiveSign, ResultantExponent, C[22:0]};
  

endmodule
