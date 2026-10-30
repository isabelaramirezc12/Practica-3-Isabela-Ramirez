// Máquina de estados tipo Moore - la salida depende solo del estado actual.

module Ejercicio_11 (ix,oAB,iCLK,iRST); 
	input ix,iCLK,iRST; 				// Entradas: ix = dato, iCLK = RELOJ, iRST = RESET (activo en 0)
	output [1:0]oAB; 					// Salida de 2 bits: oAB[1] = A, oAB[0] = B
	reg [1:0] state; 					// state = estado actual 
	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11; 	// Nombres para los 4 estados
	always @ (posedge iCLK or negedge iRST) 	// Se activa cuando el reloj sube o cuando el reset baja
		if (~iRST) 
			state = S0;			//Iniciar en reset y sino  en cada flanco del reloj
		else 							
			case (state) 				// según el estado actual y la entrada, pasa al siguiente estado
				S0: if (~ix) state = S1; else state = S0; 	// S0: con 0 va a S1, con 1 se queda en S0
				S1: if (ix) state = S2; else state = S3; 	// S1: con 1 va a S2, con 0 va a S3
				S2: if (~ix) state = S3; else state = S2; 	// S2: con 0 va a S3, con 1 se queda en S2
				S3: if (~ix) state = S0; else state = S3; 	// S3: con 0 va a S0, con 1 se queda en S3
			endcase 
		assign oAB = state;			
endmodule								



