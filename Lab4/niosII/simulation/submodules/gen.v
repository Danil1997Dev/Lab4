 

module gen#
(
	 parameter PHACC_WIDTH = 14
)
(
	input clk,clr_n, 
	input [31:0] wr_data, 
	input wr_n,  
   output fout 
); 
  
  reg  [7:0] phinc;
  wire [7:0] phase;
  wire [7:0] sin_mem; //поменял название сигнала синуса

  phacc                         			  pa (.clk(clk),
														  .clr_n(clr_n),
														  .phinc(phinc),
														  .phase(phase));
  defparam pa.WIDTH = PHACC_WIDTH;//добавил дефпараметр
														  
														  
														  
  sine_rom   					        sr (.clock(clk),
													.address(phase),
													.q(sin));
													
  sdmodb     					     sdm (.clk(clk),
												 .clr_n(clr_n),
												 .val(sin),
												 .daco(fout));
  
//триггер разрешения записи

  always @(posedge clk or negedge clr_n or posedge wr_n)//поставил бегины в одну строку с выполняемыми фенкциями
    begin
      if (!clr_n) begin
		    phinc = 8'b0; end
		else begin
			  if (wr_n) begin
					phinc = phinc; end
				else begin
					phinc = wr_data[7:0]; end end
    end
  
endmodule 