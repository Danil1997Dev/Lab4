`timescale 1 ns/1 ns

module gen#(
	 parameter PHACC_WIDTH = 14
)
(
	input clk,clr_n, 
	input [31:0] wr_data,//сигнал writedata интерфейса Avalon Slave-MM;
	input wr_n,//сигнал write_n интерфейса Avalon Slave-MM; 
   output fout // выход модулятора;
); 
  
  reg  [7:0] phinc;
  wire [7:0] phase;
  wire [7:0] sin; 

  phacc #(.WIDTH(PHACC_WIDTH))  phacc_inst (.clk(clk),.clr_n(clr_n),.phinc(phinc),.phase(phase));
  sine_rom   				sine_rom_inst (.clock(clk),.address(phase),.q(sin));
  sdmodb     				sdmodb_inst (.clk(clk),.clr_n(clr_n),.val(sin),.daco(fout));

  always @(posedge clk or negedge clr_n or posedge wr_n)
    begin
      if (!clr_n)
		  begin
		    phinc = 8'b0;
		  end
		else
		  begin
			  if (wr_n)
				  begin
					phinc = phinc;
				  end
				else
				  begin
					phinc = wr_data[7:0];
				  end
		  end
    end
  
endmodule 