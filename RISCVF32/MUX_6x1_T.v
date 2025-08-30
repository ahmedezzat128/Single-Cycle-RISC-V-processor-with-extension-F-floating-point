module MUX_6x1_T(
input           wire          [31:0]      IN1,
input           wire          [31:0]      IN2,
input           wire          [31:0]      IN3,
input           wire          [31:0]      IN4,
input           wire          [31:0]      IN5,
input           wire          [31:0]      IN6,
input           wire          [3:0]       FPU_Control,
output          reg           [31:0]      OUT
);


always@(*)
begin
	case(FPU_Control)
	4'd0:begin                                  //add
		OUT = IN1;
	end
	
	4'd1:begin                                 //sub 
		OUT = IN1;
	end
	
	4'd2:begin                                 //mul
		OUT = IN2;
	end
	
	
	4'd3:begin                                 //div
		OUT = IN3;
	end
	
	
	4'd4 :begin                 //comprator
		OUT = IN4;
	end
	
	4'd5 :begin                 //comprator
		OUT = IN4;
	end
	
	4'd6 :begin                 //comprator
		OUT = IN4;
	end
	
	
	4'd7 :begin                          //conversions 
		OUT = IN5;
	end
	
	4'd8 :begin                          //conversions 
		OUT = IN5;
	end
	
	4'd9 :begin                         //conversions 
		OUT = IN5;
	end
	
	4'd10 :begin                       //conversions 
		OUT = IN5;
	end
	
	4'd11:begin                       //sign_injection
		OUT = IN6;
	end
	
	4'd12 :begin            //sign_injection
		OUT = IN6;
	end

	
	4'd13 :begin            //sign_injection
		OUT = IN6;
	end
	
	
	default:begin
	   OUT = 32'd0;
	end
	
	endcase
end
endmodule