// модуль преобразования из двоичного кода в двоично-десятичный
module encoder (

	input logic iReset,
	input logic [8:0] i_b_val,
	output logic [3:0][3:0] o_data
	
);
				
		logic [7:0] bcd_bin_v;
		
		always_comb begin
				o_data = '0;
				bcd_bin_v[7:0] = i_b_val[7:0];
				if (i_b_val[8] == 1'b1) begin                    // знак
					o_data[3] = 4'b1101;
					end
				else begin
					o_data[3] = 4'b1100;
					end	
					
				for (int i = 0; i < 8; i++) begin                // перевод
					
					for (int j = 0; j <= 2; j++) begin
						if (o_data[j] >= 4'b0101)
							o_data[j] += 2'b11;                     // +3
						end
					o_data[2] = {o_data[2][2:0], o_data[1][3]};   // сдвиг
					o_data[1] = {o_data[1][2:0], o_data[0][3]};
					o_data[0] = {o_data[0][2:0], bcd_bin_v[7]};
					bcd_bin_v <<= 1;
					end
				end
				
endmodule
				