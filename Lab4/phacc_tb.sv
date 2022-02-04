`timescale 1 ns/1 ns

module phacc_tb();

	// Parameters
	localparam CLK_PRD = 20;
	localparam SAMPLES_PRD = 256;
	localparam OVERSAMPLING = 4;
	localparam PHACC_WIDTH = 14;
	localparam W_PHASE = 8;
	localparam N = 5; 
	
	// Wires and variables to connect to UUT (unit under test)
	logic clk, clr_n, wr_n;
	logic [W_PHASE-1:0] wr_data;
	logic [31:0] phinc_val;
	logic [7:0] phase;
	int n=0;
		
	// Instantiate UUT and connect used ports
	phacc dut(.clk(clk), .clr_n(clr_n), .phinc(wr_data), .phase(phase));
	defparam dut.WIDTH = PHACC_WIDTH;
	defparam dut.W_PHASE = W_PHASE;

	// Clock definition
	initial begin
		clk = 0;
		forever #(CLK_PRD/2) clk = ~clk;
	end

	// Reset and initial values definition
	initial begin
		clr_n = 0; 
		wr_data = 0;
		#(CLK_PRD*5) clr_n = 1;
	end
	
	// Bus write transaction simulation
	initial begin
		// Wait until system is out of reset
		@(posedge clr_n);
		// Check if phase increment for required accumulator width 
		// and oversamlpling ratio will fit in 8 bits
		n=1;
		phinc_val=(n*2**(PHACC_WIDTH-8))/OVERSAMPLING;
		if ((phinc_val <= (2**W_PHASE)-1) && (phinc_val != 0))
		begin
			// Write phase increment several clock cycles after reset
			#(CLK_PRD*3) write_transaction(phinc_val);
			// Wait for one sine period (for 14-bit phase accumulator case)
			wait (phase == (2**W_PHASE)-1) ; #1;
		end
		else
		begin
			//Output simulation error
			$display("Error: value of phase increment is out of range! Stopped simulation.");
			//Stop simulation (small delay needed for $display to work)
			//#1 $stop;
		end 
		n=2;
		phinc_val=(n*2**(PHACC_WIDTH-8))/OVERSAMPLING;
		if ((phinc_val <= (2**W_PHASE)-1) && (phinc_val != 0))
		begin
			// Write phase increment several clock cycles after reset
			#(CLK_PRD*3) write_transaction(phinc_val);
			// Wait for one sine period (for 14-bit phase accumulator case)
			wait (phase == (2**W_PHASE)-1) ; #1;
		end
		else
		begin
			//Output simulation error
			$display("Error: value of phase increment is out of range! Stopped simulation.");
			//Stop simulation (small delay needed for $display to work)
			//#1 $stop;
		end 
		n=4;
		phinc_val=(n*2**(PHACC_WIDTH-8))/OVERSAMPLING;
		if ((phinc_val <= (2**W_PHASE)-1) && (phinc_val != 0))
		begin
			// Write phase increment several clock cycles after reset
			#(CLK_PRD*3) write_transaction(phinc_val);
			// Wait for one sine period (for 14-bit phase accumulator case)
			wait (phase == (2**W_PHASE)-1) ; #1;
		end
		else
		begin
			//Output simulation error
			$display("Error: value of phase increment is out of range! Stopped simulation.");
			//Stop simulation (small delay needed for $display to work)
			//#1 $stop;
		end 
		n=8;
		phinc_val=(n*2**(PHACC_WIDTH-8))/OVERSAMPLING;
		if ((phinc_val <= (2**W_PHASE)-1) && (phinc_val != 0))
		begin
			// Write phase increment several clock cycles after reset
			#(CLK_PRD*3) write_transaction(phinc_val);
			// Wait for one sine period (for 14-bit phase accumulator case)
			wait (phase == (2**W_PHASE)-1) ;  #1;
		end
		else
		begin
			//Output simulation error
			$display("Error: value of phase increment is out of range! Stopped simulation.");
			//Stop simulation (small delay needed for $display to work)
			//#1 $stop;
		end 
		n=16;
		phinc_val=(n*2**(PHACC_WIDTH-8))/OVERSAMPLING;
		if ((phinc_val <= (2**W_PHASE)-1) && (phinc_val != 0))
		begin
			// Write phase increment several clock cycles after reset
			#(CLK_PRD*3) write_transaction(phinc_val);
			// Wait for one sine period (for 14-bit phase accumulator case)
			wait (phase == (2**W_PHASE)-1) ;  #1;
		end
		else
		begin
			//Output simulation error
			$display("Error: value of phase increment is out of range! Stopped simulation.");
			//Stop simulation (small delay needed for $display to work)
			//#1 $stop;
		end 
		n=32;
		phinc_val=(n*2**(PHACC_WIDTH-8))/OVERSAMPLING;
		if ((phinc_val <= (2**W_PHASE)-1) && (phinc_val != 0))
		begin
			// Write phase increment several clock cycles after reset
			#(CLK_PRD*3) write_transaction(phinc_val);
			// Wait for one sine period (for 14-bit phase accumulator case)
			wait (phase == (2**W_PHASE)-1) ; #1;
		end
		else
		begin
			//Output simulation error
			$display("Error: value of phase increment is out of range! Stopped simulation.");
			//Stop simulation (small delay needed for $display to work)
			//#1 $stop;
		end
		 $stop;
	end

	//Single write transaction task
	task write_transaction;
		//input signals
		input [31:0] val;
		//transaction implementation
		begin
			@(posedge clk);
			//assert signals for one clock cycle 
			wr_data = val[W_PHASE-1:0];
			@(posedge clk);
			//deassert signals 
			wr_data = wr_data;
		end
	endtask

endmodule

