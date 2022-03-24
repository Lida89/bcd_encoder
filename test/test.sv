`timescale 1ns/1ns
//Описание работы тестовой программы
module test

	(
		output	logic   clk,	
		output	logic		rst,
		output	logic		[8:0] bin_v,
		
		input	logic		[8:0] bin_val_led,
		input	logic		[3:0][6:0]	sev_seg,
		
		input	logic				clk_led,
		input logic		[3:0][3:0] data
	
	);
  
  //Процедурный блок. Все операции процедурного блока между begin и end выполняются последовательно,
  //т.е. как в обычном языке программирования (например С++)
  initial begin
    //Инициализация без затраты модельного времени
    //Инициализация начальных значений выходных линий
    clk = 0;
    rst = 1;
	 bin_v = 9'b000000000;
    
    //Процедурный блок fork ... join состоит из несккольких последовательных блоков, которые в свою очередь,
    //выполняются параллельно относительно друг друга.
    fork 
      //Первый последовательный блок
      //Определение бесконечного цикла генерации сигнала синхрочастоты
      forever #5 clk = ~clk;        //#5 - означет задержку в модельном времени перед изменением сигнала
                                    //относительно времени от предыдущего оператора. Единица измерения задержки
                                    //первое значение в команде директиве timescale
      //Второй последовательный блок
      //Описание сигнала сброса
      begin
      #7  rst = ~rst;               //описание генерации сигнала сброса
      #20 rst = ~rst;               //в соответствии с описанием модуля, устройство работает при значении "1"
      end
		
      //Третий последовательный блок
      //Вывод информации о значении выходных портов устройства в консоль и условие окончания симуляции
      forever begin
        @(posedge clk_led, negedge rst);
		  $display ("---------------------------------------------------------------");
        $display ("Clk_led or reset impulse detect. Model time:%t\n",$time());
		  #1 if (bin_v == bin_val_led) begin
				$display("Leds are correct. Binary value: %b = '%b' %d\n", bin_val_led, bin_val_led[8], bin_val_led[7:0]);			
				end			
        $display("7-segment displays: ");
		  for (int i = 3; i >= 0; i--) begin
				case (sev_seg[i])
				
				7'b1000000: $display ("0");
				7'b1111001: $display ("1");
				7'b0100100: $display ("2");
				7'b0110000: $display ("3");
				7'b0011001: $display ("4");
				7'b0010010: $display ("5");
				7'b0000010: $display ("6");
				7'b1111000: $display ("7");
				7'b0000000: $display ("8");
				7'b0010000: $display ("9");
				7'b0111111: $display ("-");
				7'b1111111: $display ("___");
				default: $display("error");
				endcase
				end

		  if (bin_v == 9'b000011100) $finish();
		  else bin_v = bin_v + 9'b000100100;
		  $display("New binary value: %b = '%b' %d\n", bin_v, bin_v[8], bin_v[7:0]);
		  $display ("---------------------------------------------------------------");
		  end

      //Четвёртый последовательный блок 
      begin
        $display ("------------------------ATTENTION------------------------------");
        $display ("Please add additional wave to waveform and run simulation");
        $display ("Menu Simulate/Run/Run -all or write command run -all to console");
        $display ("------------------------ATTENTION------------------------------");
        //$stop();
      end
      
    join    // Окончание параллельного блока
  
  end
  
  
endmodule
