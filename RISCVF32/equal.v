module equal(
input         wire           [31:0]       OP_A,
input         wire           [31:0]       OP_B,
output        reg            [31:0]       R      
);

/////////////////////////////// internal signals ////////////////////////////////////////////////
wire         [31:0]     R_i;
////////////////////////////////////////////////////////////////////////////////////////////////


assign R_i = (OP_A == OP_B) ? 32'd1 : 32'd0;


always@(*)
begin
	if(OP_A == 32'b01111111111111111111111111111111 || OP_B == 32'b01111111111111111111111111111111)
		begin
			R = 32'd0;
		end
	else
		begin
			R = R_i;
		end
end





endmodule