module ALU_F(
input          wire                    eop,
input          wire       [23:0]       large_m,
input          wire       [23:0]       small_m,
output         reg        [23:0]       result,
output         reg                     carry
);

always@(*)
begin

	case(eop)
		1'b0 : begin
			{carry,result} = {1'b0,large_m} + {1'b0,small_m};
		end
		1'b1 : begin
			{carry,result} = {1'b0,large_m} - {1'b0,small_m};
		end
	endcase
	
end






endmodule