module LZCE_8(
input       wire       [7:0]        a,
output      reg        [2:0]        q
);


always@(*)
begin
	casex(a)
		8'b0xxxxxxx:begin
			q = 3'b000;
		end
		
		8'b10xxxxxx:begin
			q = 3'b001;
		end
		
		8'b110xxxxx:begin
			q = 3'b010;
		end
		
		8'b1110xxxx:begin
			q = 3'b011 ;
		end
		
		8'b11110xxx:begin
			q = 3'b100;
		end
		
		8'b111110xx:begin
			q = 3'b101;
		end
		
		8'b1111110x:begin
			q = 3'b110;
		end
		
		8'b11111110:begin
			q = 3'b111;
		end
		
		default:begin
			q = 3'b000;	
		end	
		
	endcase

end

















endmodule