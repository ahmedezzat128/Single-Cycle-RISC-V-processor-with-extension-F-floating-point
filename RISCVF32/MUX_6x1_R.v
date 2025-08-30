module MUX_6x1_R(
input   wire    [31:0]      A,
input   wire    [31:0]      B,
input   wire    [31:0]      D,
input   wire    [31:0]      E,
input   wire    [31:0]      F,
input   wire    [31:0]      G,
input   wire    [2:0]       sel,
output  reg     [31:0]      C
);


always@(*)
	begin
		case(sel)
			3'b000: begin
				C = A ;
			end
			
			3'b001: begin
				C = B ;
			end
			
			3'b010: begin
				C = D ;
			end
			
			3'b011: begin
				C = E ;
			end
			
			3'b100: begin
				C = F ;
			end
			
			3'b101: begin
				C = G ;
			end
			
			
			default:begin
				C = 32'd0 ;
			end
		endcase
	end
endmodule