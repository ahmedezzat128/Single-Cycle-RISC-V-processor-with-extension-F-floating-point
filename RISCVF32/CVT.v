module CVT(
input          wire       [31:0]       A,
input          wire       [3:0]        FUNC,
output         reg        [31:0]       result
);


////////////////////////////////////////////////////////////////////////////////////////////////////
/*
00  ====>  (FCVT.S.W)  signed integer to floating number        
01  ====>  (FCVT.S.WU) unsigned integer to floating number
10  ====>  (FCVT.W.S)  floating number to signed integer 
11  ====>  (FCVT.WU.S) floating number to unsigned integer  
*/
///////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////// internal signals //////////////////////////////////////////
reg       [1:0]         state;
reg       [31:0]        OP_A;
reg       [31:0]        tws_complemnt;
reg                     sign;
reg       [7:0]         exponent;
reg       [22:0]        mantissa;
reg       [7:0]         tmp;
wire      [4:0]         NUM_ZEROS;
reg       [31:0]        d;
reg       [31:0]        fraction;
reg       [31:0]        tmp_2;
wire              [31:0]         result_i;
wire   signed     [31:0]         OP_A_signed;
//////////////////////////////////////////////////////////////////////////////////////////////////

//encoder
always@(*)
begin
	case(FUNC)
	4'd7:begin
		state = 2'b00;
	end
	
	4'd8:begin
		state = 2'b10;
	end
	
	
	4'd9:begin
		state = 2'b01;
	end
	
	4'd10:begin
		state = 2'b11;
	end
	
	default :begin
		state = 2'b00;
	end
	endcase
end



always@(*)
begin
	tws_complemnt = 'd0;
	sign = 'd0;
	OP_A = 'd0;
	tmp = 'd0;
	exponent = 'd0;
	mantissa = 'd0;
	tmp_2 = 'd0;
	fraction = 'd0;
	d = 'd0;
	case(state)
	      // signed integer to floating number
		2'b00:begin
			if(A[31])
				begin
					tws_complemnt = ~A + 1'b1 ;
				end
			else
				begin
					tws_complemnt = A;
				end

			sign = A[31];

			OP_A = tws_complemnt << NUM_ZEROS;

			tmp = {3'b000, 5'd31 - NUM_ZEROS};  
			
			exponent = tmp + 127;
			
			mantissa = OP_A[30:8] ;
			
		end
			// unsigned integer to floating number
		2'b01:begin
			if(A[31])
				begin
					tws_complemnt = ~A + 1'b1 ;
				end
			else
				begin
					tws_complemnt = A;
				end
			
			sign = 1'b0;

			OP_A = tws_complemnt << NUM_ZEROS;

			tmp = {3'b000, 5'd31 - NUM_ZEROS};  
			
			exponent = tmp + 127;
			
			mantissa = OP_A[30:8] ;
		end
			// floating number to signed integer
		2'b10:begin
			exponent = 158 - A[30:23];
			fraction = {1'b1,A[22:0],8'd0};
			tmp_2 = fraction >> exponent;
			if(A[31])
				begin
					d = ~tmp_2 +1'b1;
				end
			else
				begin
					d = tmp_2;
				end
		end
		  // floating number to unsigned integer
		2'b11:begin
			exponent = 158 - A[30:23];
			fraction = {1'b1,A[22:0],8'd0};
			tmp_2 = fraction >> exponent;
			d = tmp_2;
		end
		
	endcase

end

assign OP_A_signed = A;
assign result_i = (state[1]) ?  d : {sign,exponent,mantissa};       


//check out of range
always@(*)
begin
if(state == 2'b10)
begin
	if(OP_A_signed == 32'b11111111100000000000000000000000)
		begin
			result = 32'b10000000000000000000000000000000;
		end
	else if (OP_A_signed < 32'b11001111000000000000000000000000)
		begin
			result = 32'b10000000000000000000000000000000;
		end
	else if (OP_A_signed == 32'b01111111100000000000000000000000 || OP_A_signed == 32'b01111111111111111111111111111111)
		begin
			result = 32'b01111111111111111111111111111111;
		end
	else if (OP_A_signed > 32'b01001111000000000000000000000000)
		begin
			result = 32'b01111111111111111111111111111111;
		end
	else
		begin
			result = result_i;
		end
end  

else if(state == 2'b11)
begin
	if(OP_A_signed == 32'b11111111100000000000000000000000)
		begin
			result = 32'd0;
		end
	else if (OP_A_signed < 32'd0)
		begin
			result = 32'd0;
		end
	else if (OP_A_signed == 32'b01111111100000000000000000000000 || OP_A_signed == 32'b01111111111111111111111111111111)
		begin
			result = 32'b11111111111111111111111111111111;
		end
	else if (OP_A_signed > 32'b01001111100000000000000000000000)
		begin
			result = 32'b11111111111111111111111111111111;
		end
	else
		begin
			result = result_i;
		end
end

else
begin
	result = result_i;
end

end
			

			



///////////////////////////////////////////// Leading Zero Counter ////////////////////////////////////////////
LZC_8 LZC_8(
.result(tws_complemnt),
.NUM_LEAD_ZERO(NUM_ZEROS)           
);
/////////////////////////////////////////////////////////////////////////////////////////////////////////////


endmodule