/*Файл разрабатываемого устройства верхнего уровня,предназначен для определения внешних портов,
а также линий соединений модулей нижнего уровня*/

//Объявление описания модуля верхнего уровня устройства
module dut
	#(
		parameter p_gen_period = 2000					   // параметр задающий период генератора
	)
	//Блок объявления входных и выходных портов устройства
	(
		input		logic 	i_clock_50mhz,				   // вход от генератора частоты
		input		logic		i_reset,						   // внешний сброс
		input		logic		[8:0] bin_val,						   // двоичное число
		
		output	logic		o_clk,						   // импульс обновления значения
		output logic [8:0] o_bin_led,						// двоичное значение для отображения на диодах
		output	logic		[3:0][6:0]	o_seven_sigm   // вывод десятичного числа на HEX дисплей
	
	);
	
	//Объявление локальных параметров, которые не доступны для изменения из вне
	localparam int lp_div_cnt = 1000000000/(2*p_gen_period);	//Параметра определяющий значение,
																				//до которого должен считать счетчик
																				//делителя частоты
	
	                                   //Определение внутренних переменных и проводов
	logic clk_imp;
	logic [3:0][3:0] hex_code_wire;
	
	                                   //Комбинационное присвоение сигналов
	assign o_clk = clk_imp;
	
	//Объявление экзкмпляров модулей
	
	                                   //Экземпляр модуля делителя частоты
	ClkDivider 
	                                   //Начало блока переназначения параметров
	#(
		.p_start_value 	(0),
		.p_finish_value 	(lp_div_cnt)
	)
	CLOCK_DIVIDER
	(
		.i_clk				(i_clock_50mhz),		//к порту i_clk (так он называется в молуде ClkDivider)
																//подсоединен входной порт линия i_clock_50mhz
		.i_reset				(i_reset),
		.o_data				(),
		.o_impulse			(clk_imp)			   //к порту o_impulse (так он называется в молуде ClkDivider)
															   //подсоединена локальная линия clk_imp
	);
	
	
	encoder ENC
	(
		//.iClk					(clk_imp),
		.iReset				(i_reset),
		.i_b_val			(bin_val),
		.o_data				(hex_code_wire)
	);
	
	
	hex_disp SEV_SEG_DISP (
		.clk						(clk_imp),
		.rstN						(i_reset),
		.in_reg					(hex_code_wire),
		.i_b_val				(bin_val),
		.o_b_val				(o_bin_led),
		.out_seg				(o_seven_sigm)
	);
	


endmodule
