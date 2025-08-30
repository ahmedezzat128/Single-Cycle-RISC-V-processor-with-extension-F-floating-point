module MAIN_DECODER(
input     wire     [6:0]     OP,
input     wire     [4:0]     funct5,
output    reg      [1:0]     IMMSRC,
output    reg      [1:0]     ALU_OP,
output    reg      [2:0]     ResultSrc,
output    reg                MemWrite,
output    reg                ALUSRC,
output    reg                REGWRITE,
output    reg                Branch,
output    reg                Jump,
output    reg                REGWRITE_F,
output    reg                DATA_MEM_SRC,       
output    reg                FPU_OP,
output    reg                fsrc      
);
////////////////////////////////////////// internal signals ///////////////////////////////////////////// 
wire                    FLTIN;
wire                    CMP;
wire                    MOV;
wire                    MINTF;
wire                    MFTIN;
wire                    INTFL;
////////////////////////////////////////////////////////////////////////////////////////////////////////
localparam        lw = 7'b0000011,
			      sw = 7'b0100011,
			      beq = 7'b1100011,
			      r_type = 7'b0110011,
			      i_type_alu = 7'b0010011,
			      jal = 7'b1101111,
				  flw = 7'b0000111,
				  fsw = 7'b0100111,
				  fcomp = 7'b1010011;
			 
/////////////////////////////////////////////////////////////////////////////////////////////////////////


assign FLTIN = (funct5 == 5'b11000) ? 1'b1 : 1'b0 ;
assign CMP = (funct5 == 5'b10100) ? 1'b1 : 1'b0; 
assign MFTIN = (funct5 == 5'b11100) ? 1'b1:1'b0;
assign MINTF = (funct5 == 5'b11110) ? 1'b1:1'b0;
assign INTFL = (funct5 == 5'b11010) ? 1'b1:1'b0;


always@(*)
begin
	if(INTFL)
		begin
			fsrc = 1'b1;
		end
	else
		begin
			fsrc = 1'b0; 
		end


end



always@(*)
	begin
		IMMSRC = 2'b00;
		ALU_OP = 2'b00;
		ResultSrc = 3'b000;
		MemWrite = 1'b0;
		ALUSRC = 1'b0;
		REGWRITE = 1'b0;
		Branch = 1'b0;
		Jump = 1'b0;  
		REGWRITE_F = 1'b0;
		DATA_MEM_SRC = 1'b0;
		FPU_OP = 1'b0;
		
		case(OP)
			lw : begin
				IMMSRC = 2'b00;
				ALU_OP = 2'b00;
				ResultSrc = 3'b001;
				MemWrite = 1'b0;
				ALUSRC = 1'b1;
				REGWRITE = 1'b1;
				Branch = 1'b0;
				Jump = 1'b0; 
				DATA_MEM_SRC= 1'b0;
				REGWRITE_F = 1'b0;
				FPU_OP = 1'b0;
			end
			
			flw : begin
				IMMSRC = 2'b00;
				ALU_OP = 2'b00;
				ResultSrc = 3'b001;
				MemWrite = 1'b0;
				ALUSRC = 1'b1;
				REGWRITE = 1'b0;
				REGWRITE_F = 1'b1;
				Branch = 1'b0;
				Jump = 1'b0; 
				DATA_MEM_SRC = 1'b0;
				FPU_OP = 1'b0;
			end
			
			sw:begin
				IMMSRC = 2'b01;
				ALU_OP = 2'b00;
				MemWrite = 1'b1;
				ALUSRC = 1'b1;
				REGWRITE = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0; 
				REGWRITE_F =1'b0;
				DATA_MEM_SRC =1'b1;
				FPU_OP = 1'b0;
			end
			
			fsw:begin
				IMMSRC = 2'b01;
				ALU_OP = 2'b00;
				MemWrite = 1'b1;
				ALUSRC = 1'b1;
				REGWRITE = 1'b0;
				REGWRITE_F = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0; 
				DATA_MEM_SRC =1'b0;
				FPU_OP = 1'b0;
			end
			
			r_type:begin
				ALU_OP = 2'b10;
				ResultSrc = 3'b000;
				MemWrite = 1'b0;
				ALUSRC = 1'b0;
				REGWRITE = 1'b1;
				REGWRITE_F = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0; 
				DATA_MEM_SRC =1'b0;
				FPU_OP = 1'b0;
			end
			
			beq:begin
				IMMSRC = 2'b10;
				ALU_OP = 2'b01;
				MemWrite = 1'b0;
				ALUSRC = 1'b0;
				REGWRITE = 1'b0;
				REGWRITE_F = 1'b0;
				Branch = 1'b1;
				Jump = 1'b0; 
				DATA_MEM_SRC =1'b0;
				FPU_OP = 1'b0;
			end
			
			i_type_alu:begin
				IMMSRC = 2'b00;
				ALU_OP = 2'b10;
				ResultSrc = 3'b000;
				MemWrite = 1'b0;
				ALUSRC = 1'b1;
				REGWRITE = 1'b1;
				Branch = 1'b0;
				Jump = 1'b0; 
				DATA_MEM_SRC =1'b0;
				REGWRITE_F = 1'b0;
				FPU_OP = 1'b0;
			end
			
			jal:begin
				IMMSRC = 2'b11;  
				ResultSrc = 3'b010;
				MemWrite = 1'b0;
				REGWRITE = 1'b1; 
				Branch = 1'b0;
				Jump = 1'b1; 
				DATA_MEM_SRC = 1'b0;
				REGWRITE_F = 1'b0;
				FPU_OP = 1'b0;
			end
			
			fcomp:begin
				IMMSRC = 2'b00;
				ALU_OP = 2'b00;
				MemWrite = 1'b0;
				ALUSRC = 1'b0;
				if(FLTIN || CMP || MFTIN)
					begin
						REGWRITE = 1'b1;
						REGWRITE_F = 1'b0;
					end
				else
					begin
						REGWRITE = 1'b0;
						REGWRITE_F = 1'b1;
					end
				Branch = 1'b0;
				Jump = 1'b0; 
				DATA_MEM_SRC =1'b0;
				if(MFTIN)
					begin
						FPU_OP = 1'b0;
						ResultSrc = 3'b101;
					end
				else if(MINTF)
					begin
						FPU_OP = 1'b0;
						ResultSrc = 3'b100;
					end
				else
					begin
						FPU_OP = 1'b1;
						ResultSrc = 3'b011;
					end
			end
			
			default:begin
				IMMSRC = 2'b00;
				ALU_OP = 2'b00;
				ResultSrc = 3'b000;
				MemWrite = 1'b0;
				ALUSRC = 1'b0;
				REGWRITE = 1'b0;
				Branch = 1'b0;
				Jump = 1'b0;
				REGWRITE_F =1'b0;
				DATA_MEM_SRC =1'b0;
				FPU_OP = 1'b0;
			end
		endcase
	end
endmodule