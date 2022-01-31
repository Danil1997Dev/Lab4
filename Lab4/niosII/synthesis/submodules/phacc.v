 

module phacc#(
	 parameter WIDTH = 14
)
(
	 input clk,clr_n,
	 input [7:0] phinc,
	 output reg [7:0] phase 
); 
  
  reg [WIDTH-1:0] adder;

  always @(posedge clk or negedge clr_n)
    begin
      if (!clr_n) begin
			adder = 0;
			phase = 0; end
      else begin
			adder <= adder + phinc;
			phase <= adder[WIDTH-1:WIDTH-1-7];  end
    end
endmodule

