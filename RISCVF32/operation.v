module operation (
input           wire      [3:0]       FUNC,
output          reg                   OP
);





always@(*)
begin
	if(FUNC == 4'd1)
		begin
			OP = 1'b1;
		end
	else
		begin
			OP = 1'b0;
		end

end












endmodule