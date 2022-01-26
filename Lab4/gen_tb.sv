`timescale 1 ns/1 ns

module gen_tb();

	// Parameters
	localparam CLK_PRD = 20;
	localparam SAMPLES_PRD = 256;
	localparam OVERSAMPLING = 4;
	localparam PHACC_WIDTH = 14;
	
	// Wires and variables to connect to UUT (unit under test)
	logic clk, clr_n, wr_n;
	logic [31:0] wr_data;
	logic [31:0] phinc_val;
	logic fout;
	logic [7:0]  n; 
		
	// Instantiate UUT and connect used ports
	gen dut(.clk(clk), .clr_n(clr_n), .wr_n(wr_n), .wr_data(wr_data), .fout(fout));
	defparam dut.PHACC_WIDTH = PHACC_WIDTH;

	// Clock definition
	initial begin
		clk = 0;
		forever #(CLK_PRD/2) clk = ~clk;
	end

	// Reset and initial values definition
	initial begin
		clr_n = 0;
		wr_n = 1;
		wr_data = 'bx;
		#(CLK_PRD*5) clr_n = 1;
	end
	
	// Bus write transaction simulation
	initial begin
		// Wait until system is out of reset
		@(posedge clr_n);
		// Check if phase increment for required accumulator width 
		// and oversamlpling ratio will fit in 8 bits
		n = 1;
		phinc_val=(2**(PHACC_WIDTH-8))*n/(OVERSAMPLING);
		if ((phinc_val <= 255) && (phinc_val != 0))
		begin
			// Write phase increment several clock cycles after reset
			#(CLK_PRD*3) write_transaction(phinc_val);
			// Wait for one sine period (for 14-bit phase accumulator case)
			#(CLK_PRD*SAMPLES_PRD*OVERSAMPLING) ;
		end
		else
		begin
			//Output simulation error
			$display("Error: value of phase increment is out of range! Stopped simulation.");
			//Stop simulation (small delay needed for $display to work)
			#1 $stop;
		end

		n = 2;
		phinc_val=(2**(PHACC_WIDTH-8))*n/(OVERSAMPLING);
		if ((phinc_val <= 255) && (phinc_val != 0))
		begin
			// Write phase increment several clock cycles after reset
			#(CLK_PRD*3) write_transaction(phinc_val);
			// Wait for one sine period (for 14-bit phase accumulator case)
			#(CLK_PRD*SAMPLES_PRD*OVERSAMPLING) ;
		end
		else
		begin
			//Output simulation error
			$display("Error: value of phase increment is out of range! Stopped simulation.");
			//Stop simulation (small delay needed for $display to work)
			#1 $stop;
		end

		n = 4;
		phinc_val=(2**(PHACC_WIDTH-8))*n/(OVERSAMPLING);
		if ((phinc_val <= 255) && (phinc_val != 0))
		begin
			// Write phase increment several clock cycles after reset
			#(CLK_PRD*3) write_transaction(phinc_val);
			// Wait for one sine period (for 14-bit phase accumulator case)
			#(CLK_PRD*SAMPLES_PRD*OVERSAMPLING) $stop;
		end
		else
		begin
			//Output simulation error
			$display("Error: value of phase increment is out of range! Stopped simulation.");
			//Stop simulation (small delay needed for $display to work)
			#1 $stop;
		end
	end

	//Single write transaction task
	task write_transaction;
		//input signals
		input [31:0] val;
		//transaction implementation
		begin
			@(posedge clk);
			//assert signals for one clock cycle
			wr_n = 0;
			wr_data = val;
			@(posedge clk);
			//deassert signals
			wr_n = 1;
			wr_data = 'bx;
		end
	endtask

endmodule

