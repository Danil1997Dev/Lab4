 

module sdmodb 
(
    input clk,clr_n,
	 input signed [7:0] val,// входные данные модулятора; 
	 output daco //однобитная выходная последовательность.
); 
  
  reg signed [7:0] daco_reg = 0;
  reg signed [9:0] val_delay = 0; //увеличенная разрядность для корректного сложения

  always @(posedge clk or negedge clr_n)
    begin
      if (!clr_n) begin
			  daco_reg  = 1'b0;
			  val_delay = 1'b0; end
      else begin 
			val_delay <= val - daco_reg + val_delay;//сложение результата вычитания и предыдущего значения данной суммы 
													//на следущем шаге(текущее значение вычислений сравнивается с предудущим)
													//(оператор <= не локирующее присваивание,
													//присваивает операнду слева значение операнда справа на следующем такте)
			if (val_delay >= 0) 
			  begin//сравнение компаратором текущего значения и нуля
			    daco_reg <= 127;  
			  end//условный плюс один +1
			else 
			  begin
			    daco_reg <= -127;  
			  end 
			end//условный минус один -1
    end 
	
  assign daco = daco_reg[7];//запись в выходной порт значения знака выхода компаратора
  
endmodule

