module encoder(
input                 wire     [3:0]          FUNC_SEL,
output                reg      [1:0]          sel_f
);




always@(*)
begin
	case(FUNC_SEL)
		4'b0110:begin
			sel_f = 2'b00;
		end
		
		4'b0100:begin
			sel_f = 2'b01;		
		end
		
		4'b0101:begin
			sel_f = 2'b10;
		end
		
		default:begin
			sel_f = 2'b11;
		end

	endcase
end


endmodule