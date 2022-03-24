//Модуль работы с семисегментным дисплеем и светодиодами
module hex_disp (
	input	 logic clk, rstN, 
	input  logic [3:0][3:0] in_reg,
	input  logic [8:0] i_b_val,
	
	output logic [8:0] o_b_val,
	output logic [3:0][6:0] out_seg
);

	always_ff @(posedge clk, negedge rstN)
		if (~rstN) begin                                      //сброс
			out_seg <= '1;
			end
		else begin
			out_seg <= '1;
			for (int i = 2, k = 0; i >= 0; i--) begin
				if (k == 0 && in_reg[i] == 4'b0 && i > 0) begin
					continue;
					end
				else begin
					k++;
					if (k == 1) begin                            // вывод знака на дисплей
						case (in_reg[3])
						
						4'b1101: out_seg[i + 1] <= 7'b0111111;
						4'b1100: out_seg[i + 1] <= '1;
						default: out_seg[i + 1] <= 7'b0001000;
						endcase
						end				
					case (in_reg[i])                             // вывод числа на дисплей
					
					4'b0000: out_seg[i] <= 7'b1000000;
					4'b0001: out_seg[i] <= 7'b1111001;
					4'b0010: out_seg[i] <= 7'b0100100;
					4'b0011: out_seg[i] <= 7'b0110000;
					4'b0100: out_seg[i] <= 7'b0011001;
					4'b0101: out_seg[i] <= 7'b0010010;
					4'b0110: out_seg[i] <= 7'b0000010;
					4'b0111: out_seg[i] <= 7'b1111000;
					4'b1000: out_seg[i] <= 7'b0000000;
					4'b1001: out_seg[i] <= 7'b0010000;
					default: out_seg[i] <= '1;
					
					endcase
					end
				end

			end
		
		always_ff @(posedge clk, negedge rstN)             // вывод двоичного значения на светодиоды
			if (~rstN)                                      // сброс
				o_b_val <= '0;
			else
				o_b_val <= i_b_val;

endmodule
