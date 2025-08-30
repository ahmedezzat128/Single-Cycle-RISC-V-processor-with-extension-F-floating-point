module sign_inj(
input        wire         [31:0]          OP_A,
input        wire         [31:0]          OP_B,
input        wire         [3:0]           FUNC,
output       reg          [31:0]          result
);

/*
states
2'b00  =====>   FSGNJ.S                   // the result's sign bit is rs2's sign bit.  
2'b01  =====>   FSGNJN.S				 // the result's sign bit is the opposite of rs2's sign bit.
2'b10  =====>   FSGNJX.S                // the sign bit is the XOR of the sign bits of rs1 and rs2
*/
////////////////////////////////////////// internal signals /////////////////////////////////////
reg         [1:0]           state;
////////////////////////////////////////////////////////////////////////////////////////////////

//encoder
always@(*)
begin
	case(FUNC)
	4'd11 :begin
		state = 2'b00;
	end
	
	4'd12 :begin
		state = 2'b01;
	end
	
	
	4'd13 :begin
		state = 2'b10;
	end
	
	default:begin
		state = 2'b00;
	end
	endcase
end






always@(*)
begin
	case(state)
		2'b00 : begin
			result[30:0] = OP_A;
			result[31] = OP_B[31];
		end
		
		2'b01 : begin
			result[30:0] = OP_A;
			result[31] = ~ OP_B[31];
		end
		
		2'b10 : begin
			result[30:0] = OP_A;
			result[31] = OP_A[31] ^ OP_B[31];
		end
		
		default:begin
			result[30:0] = 31'd0 ;
			result[31] = 1'b0;
		end
	endcase


end







endmodule