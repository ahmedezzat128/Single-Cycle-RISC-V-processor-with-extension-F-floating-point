module DATA_MEM(
input    wire                   CLK,
input    wire      [4:0]        A,
input    wire                   WE,
input    wire      [31:0]       WD,
output   wire      [31:0]       RD
 );
 
 // Internal Memory
 reg   [31:0]  internal_memory  [31:0];
 
 
initial
	begin
		$readmemb("DATA.txt",internal_memory);
	end

 
 
always@(posedge CLK)
	begin
if(WE) 
			begin
				internal_memory [A] <= WD;
			end
	end


assign RD = internal_memory [A];




 endmodule
