 

module sdmodb 
(
    input clk,clr_n,
	 input signed [7:0] val,// входные данные модулятора; 
	 output daco //однобитная выходная последовательность.
); 
  
  reg signed [7:0] daco_reg = 0;
  reg signed [7:0] val_delay = 0;
  reg signed [7:0] val_def = 0;
  reg signed [7:0] val_delay_compar = 0;

  always @(posedge clk or negedge clr_n)
    begin
      if (!clr_n) begin
			  daco_reg  = 1'b0;
			  val_delay = 1'b0; end
      else begin
			val_def = val - daco_reg;//вычитание из вх сигнала значение компаратора на предыущем шаге
			val_delay <= val_def + val_delay;//сложение результата вычитания и предыдущего значения данной суммы
			val_delay_compar <= val_delay;//передача в компаратор текущего результата суммы для сравнения 
													//на следущем шаге(текущее значение вычислений сравнивается с предудущим)
													//(оператор <= не локирующее присваивание,
													//присваивает операнду слева значение операнда справа на следующем такте)
			if (val_delay >= val_delay_compar) begin//сравнение компаратором текущего и предыдущего значений
			  daco_reg =  127;  end//условная единица
			else begin
			  daco_reg = -127;  end end//условный ноль
    end 
	
  assign daco = daco_reg[7];//запись в выходной порт значения знака выхода компаратора
  
endmodule

