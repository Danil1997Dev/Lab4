`timescale 1 ns/1 ns

module sdmodb_tb();

	// Parameters
	localparam CLK_PRD = 20;
	localparam SAMPLES_PRD = 256;
	localparam OVERSAMPLING = 4;
	localparam PHACC_WIDTH = 14;
	
	// Wires and variables to connect to UUT (unit under test)
	logic clk, clr_n;
	logic [7:0] val; 
	logic daco;
		
	// Instantiate UUT and connect used ports
	sdmodb dut(.clk(clk), .clr_n(clr_n), .val(val), .daco(daco)); 

	// Clock definition
	initial begin
		clk = 0;
		forever #(CLK_PRD/2) clk = ~clk;
	end

	// Reset and initial values definition
	initial begin
		clr_n = 0; 
		val = 'bx;
		#(CLK_PRD*5) clr_n = 1;
	end
	
	// Bus write transaction simulation
	initial begin
		// Wait until system is out of reset
		@(posedge clr_n);  
			val=-127;  
			// Wait for one sine period (for 14-bit phase accumulator case)
			#(CLK_PRD*SAMPLES_PRD*OVERSAMPLING)  

			val=0;  
			// Wait for one sine period (for 14-bit phase accumulator case)
			#(CLK_PRD*SAMPLES_PRD*OVERSAMPLING) 

			val=127;  
			// Wait for one sine period (for 14-bit phase accumulator case)
			#(CLK_PRD*SAMPLES_PRD*OVERSAMPLING) $stop; 
	end
 
endmodule

