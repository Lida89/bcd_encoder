//Объявление модуля делителя частоты
module ClkDivider
#(
	parameter p_start_value = 0,			   //Параметр отвечающий за начальное значение счета (нижнюю границу)
	parameter p_finish_value = 255	   	//Параметр отвечающий за конечное значение счета (верхнюю границу)
)
(
	input		logic		i_clk,					//порт сигнала синхро частоты
	input		logic		i_reset,				   //порт сброса
	
	output	logic		[25:0] o_data,
	output	logic		o_impulse				//Порт выходного импульса по достижении крайнего значения

);
	
	always_ff @(posedge i_clk, negedge i_reset) begin
		if (~i_reset) begin                          //асинхронного сброс
			o_impulse	<= 0;
			o_data <= '0;
			end
		else begin
		
			if (o_data == p_finish_value) begin		   //При достижении верхнего граничного значения
						o_data <= p_start_value;		   //счетчик сбрасывается в начальное значение
						o_impulse <= 1;						//и устанваливается выходной импульс
						end
			else begin 
						o_data <= o_data + 1;			   //В противном случае продолжается счет,
						o_impulse <= 0;						//а импульс или сбрасывается (чтобы он держался не дольше
						end 										//одного такта), или находится в неактивном состоянии
			end
		end

endmodule
