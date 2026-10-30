// Máquina de estados tipo Mealy: la salida depende del estado actual Y de la entrada.

module Ejercicio_10 (ix,oy,iCLK,iRST); 
	input ix,iCLK,iRST; 				// Entradas: ix = dato, iCLK = RELOJ, iRST = RESET (activo en 0)
	output reg oy; 						// Salida y (reg porque se asigna dentro de un always)
	reg [1:0] Prstate, Nxtstate; 		// Prstate = estado actual, Nxtstate = estado siguiente (2 bits cada uno)
	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11; 	// Nombres para los 4 estados

	// BLOQUE 1 - MEMORIA: son los dos flip-flops - Restablece el circuito a S0=00 y especifica la operación sincrónica con reloj 
	always @ (posedge iCLK or negedge iRST) 	// Se activa cuando el reloj sube o cuando el reset baja
		if (~iRST) Prstate = S0;		//Iniciar en reset 
		else Prstate = Nxtstate;		//Operaciones de reloj (actualizar estado) 
										// En cada flanco, el estado actual pasa a ser el siguiente
 
	// BLOQUE 2 - SIGUIENTE ESTADO: compuertas que llegan a las entradas D (sin reloj)
	always @ (Prstate or ix) 			// Recalcula cada vez que cambia el estado o la entrada
		case (Prstate) 					
			S0:	if (ix) Nxtstate = S1; else Nxtstate = S0; 	// S0: con 1 va a S1, con 0 se queda en S0
			S1:	if (ix) Nxtstate = S3; else Nxtstate = S0; 	// S1: con 1 va a S3, con 0 a S0
			S2:	if (~ix)Nxtstate = S0; else Nxtstate = S2; 	// S2: con 0 va a S0, con 1 se queda en S2
			S3:	if (ix) Nxtstate = S2; else Nxtstate = S0; 	// S3: con 1 va a S2, con 0 a S0
		endcase 

	// BLOQUE 3 - SALIDA: OR y AND (sin reloj)
	always @ (Prstate or ix) 			// Recalcula cada vez que cambia el estado o la entrada
		case (Prstate) 				
			S0: oy = 0;		 // S0: la salida siempre es 0
			S1:	if (ix) oy = 1'b0; else oy = 1'b1; 		// S1, S2 y S3: si x = 0, y = 1 (detectó el 0)
			S2:	if (ix) oy = 1'b0; else oy = 1'b1; 		//              si x = 1, y = 0
			S3:	if (ix) oy = 1'b0; else oy = 1'b1; 
		endcase 
endmodule								






