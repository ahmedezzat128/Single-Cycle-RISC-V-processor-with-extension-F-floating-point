module MUX_3X1 #(parameter N = 32)(
input       wire       [N-1:0]       A,
input       wire       [N-1:0]       B,
input       wire       [N-1:0]       C,
input       wire	   [1:0]         sel,
output      reg        [N-1:0]       OUT
);



always@(*)
begin
	case(sel)
		2'b00:begin
			OUT = A;
		end
		
		2'b01:begin
			OUT = B;
		end
		
		2'b10:begin
			OUT = C;
		end
		
		default:begin
			OUT = 32'd0;
		end
	endcase
	
end






endmodule