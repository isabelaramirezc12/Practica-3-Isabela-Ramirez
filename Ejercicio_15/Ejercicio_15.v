module Ejercicio_15(
	input CLK,
	input RST,
	output E,
	output reg RS,
	output RW,
	output reg INIlisto,
	output reg [7:0] DATOS
	);

	parameter Espera_20ms = 4'b0000;
	parameter Enviar_SetFunction = 4'b0001;
	parameter Envia_EntryModeSet = 4'b0010;
	parameter Enviar_DisplayControl = 4'b0011;
	parameter Envia_DisplayClear = 4'b0100;
	parameter Envia_Direccion = 4'b0101;
	parameter Envia_Caracter = 4'b0110;
	parameter Caracter1 = 4'b0111;
	parameter Caracter2 = 4'b1000;
	parameter Caracter3 = 4'b1001;
	parameter Caracter4 = 4'b1010;
	parameter Termina_Aqui = 4'b1011;

	reg [3:0] estado;
	reg [16:0] contador;
	reg [4:0] cuentas;
	reg en_fsm;
	wire clk_e;
	wire nrst = ~RST;

	assign RW = 1'b0;

	always @ (posedge CLK or posedge nrst) begin
		if(nrst)
			contador <= 0;
		else if(contador == 100000)
			contador <= 0;
		else
			contador <= contador + 1;
	end

	assign clk_e = (contador >= 0 && contador < 50000);
	assign E = en_fsm ? (clk_e & en_fsm) : en_fsm;

	always @ (posedge clk_e or posedge nrst)
	begin
		if(nrst)
			begin
			INIlisto = 1'b0;
			RS = 1'b0;
			en_fsm <= 1'b1;
			DATOS = 8'b00000000;
			estado <= Espera_20ms;
			end
		else
			begin
			case(estado)
				Espera_20ms :
				begin
					INIlisto = 1'b0;
					RS = 1'b0;
					en_fsm <= 1'b1;
					DATOS = 8'b00000000;
					if(cuentas < 31)
						begin
						cuentas <= cuentas+1;
						estado <= Espera_20ms;
						end
					else
						begin
						cuentas <= 0;
						estado <= Enviar_SetFunction;
						end
				end
				Enviar_SetFunction :
				begin
					INIlisto = 1'b0;
					RS = 1'b0;
					en_fsm <= 1'b1;
					DATOS = 8'b0011_1000;
					estado <= Envia_EntryModeSet;
				end
				Envia_EntryModeSet :
				begin
					INIlisto = 1'b0;
					RS = 1'b0;
					en_fsm <= 1'b1;
					DATOS = 8'b0000_0110;
					estado <= Enviar_DisplayControl;
				end
				Enviar_DisplayControl :
				begin
					INIlisto = 1'b0;
					RS = 1'b0;
					en_fsm <= 1'b1;
					DATOS = 8'b0000_1110;
					estado <= Envia_DisplayClear;
				end
				Envia_DisplayClear :
				begin
					INIlisto = 1'b0;
					RS = 1'b0;
					en_fsm <= 1'b1;
					DATOS = 8'b00000001;
					estado <= Envia_Direccion;
				end
				Envia_Direccion :
				begin
					INIlisto = 1'b0;
					RS = 1'b0;
					en_fsm <= 1'b1;
					DATOS = 8'b10000000;
					estado <= Envia_Caracter;
				end
				Envia_Caracter :
				begin
					INIlisto = 1'b1;
					RS = 1'b1;
					en_fsm <= 1'b1;
					DATOS = 8'b0010_0000;
					estado <= Caracter1;
				end
				Caracter1 :
				begin
					INIlisto = 1'b1;
					RS = 1'b1;
					en_fsm <= 1'b1;
					DATOS = 8'b0100_1000;
					estado <= Caracter2;
				end
				Caracter2 :
				begin
					INIlisto = 1'b1;
					RS = 1'b1;
					en_fsm <= 1'b1;
					DATOS = 8'b0100_1111;
					estado <= Caracter3;
				end
				Caracter3 :
				begin
					INIlisto = 1'b1;
					RS = 1'b1;
					en_fsm <= 1'b1;
					DATOS = 8'b0100_1100;
					estado <= Caracter4;
				end
				Caracter4 :
				begin
					INIlisto = 1'b1;
					RS = 1'b1;
					en_fsm <= 1'b1;
					DATOS = 8'b0100_0001;
					estado <= Termina_Aqui;
				end
				Termina_Aqui :
				begin
					INIlisto = 1'b1;
					RS = 1'b0;
					en_fsm <= 1'b0;
					DATOS = 8'b00000000;
					estado <= Termina_Aqui;
				end
				default:
					estado <= Espera_20ms;
			endcase
		end
	end
endmodule
