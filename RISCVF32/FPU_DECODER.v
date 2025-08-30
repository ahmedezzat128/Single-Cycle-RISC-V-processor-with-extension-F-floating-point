module FPU_DECODER(
input            wire        	          FPU_OP,
input            wire    [4:0]            funct5,
input            wire    [4:0]            rs2,
input            wire    [2:0]            funct3,
output           reg     [3:0]            FPU_CONTROL
);




always@(*)
begin
	casex({FPU_OP,funct5,rs2,funct3})
	14'b100000xxxxxxxx:begin                                        // add
		FPU_CONTROL = 4'd0;
	end
	
	14'b100001xxxxxxxx:begin                                        // subtract
		FPU_CONTROL = 4'd1;
	end
	
	
	14'b100010xxxxxxxx:begin                                       // multiply
		FPU_CONTROL = 4'd2;
	end
	
	14'b100011xxxxxxxx:begin                                      // division
		FPU_CONTROL = 4'd3;
	
	end
	
	
	14'b11100000000xxx:begin                                       // floating to signed integer
		FPU_CONTROL = 4'd8;
	
	end
	
	
	14'b11100000001xxx:begin                                       // floating to unsigned integer
		FPU_CONTROL = 4'd10;
	
	end
	
	
	14'b11101000000xxx:begin                                         // signed integer to floating 
		FPU_CONTROL = 4'd7;
	
	end
	
	14'b11101000001xxx:begin                                         // unsigned integer to floating 
		FPU_CONTROL = 4'd9;
	
	end
	
	14'b1_00100_xxxxx_000:begin                                      // sign injection ==> same sign of rs2
		FPU_CONTROL = 4'd11;
	
	end
	
	14'b1_00100_xxxxx_001:begin                                      // sign injection ==> not sign of rs2
		FPU_CONTROL = 4'd12;
	
	end
	
	
	14'b1_00100_xxxxx_010:begin                                      // sign injection ==> xor sign of rs1 and rs2
		FPU_CONTROL = 4'd13;
	
	end
	
	14'b1_10100_xxxxx_001:begin                                      // less_than
		FPU_CONTROL = 4'd4;
		
	end
	
	14'b1_10100_xxxxx_000:begin                                     // equal or less than
		FPU_CONTROL = 4'd5;
		
	end
	
	14'b1_10100_xxxxx_010:begin                                    // equal
		FPU_CONTROL = 4'd6;
		
	end
	
	default:begin 
		FPU_CONTROL = 4'd15;
	end
	
	endcase
end

endmodule