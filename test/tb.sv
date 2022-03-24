//Директива определения точности моделирования 
`timescale 1ns/1ns
//Объявление модуля testbench - являющегося модулем сборки
//тестируемого устройства и программы, которая его тестирует,
//т.е. модуль организует интерфейс между ними
module tb ();

//Объявление самого интерфейса (проводов) между программой и модулем
wire tb_clk, tb_rst;
wire [8:0] tb_bin_v;

wire [3:0][6:0] tb_sev_seg;
wire [8:0] tb_bin_val_led;
wire tb_clk_led;

//Объявление экземпляра тестовой программы
test TEST 
  (
    .clk    (tb_clk),
    .rst    (tb_rst),
    .bin_v  (tb_bin_v),
    .bin_val_led (tb_bin_val_led),
    .sev_seg       (tb_sev_seg),
    .clk_led       (tb_clk_led)
  
  );

//Объявление экземпляра устройства  
dut #(.p_gen_period(100000000))
DUT
(
  .i_clock_50mhz  (tb_clk),
  .i_reset        (tb_rst),
  .bin_val (tb_bin_v),
  .o_clk (tb_clk_led),
  .o_bin_led   (tb_bin_val_led),
  .o_seven_sigm   (tb_sev_seg)

);

endmodule
