//Flip-flop D con restablecimiento asincrónico. 
// Tiene una entrada extra de RESET que vuelve la salida en 0 instantaneamente sin tener en cuenta el clk
//Es activo en bajo: se activa cuando iRST = 0.

module Ejercicio_5 (oQ, iD, iCLK, iRST);
	output reg oQ; 					// oQ = LED
	input iD,iCLK,iRST; 			// iD = DATO, iCLK = RELOJ, iRST = RESET

	always @(posedge iCLK or negedge iRST)	
											//  1) cuando iCLK sube de 0 a 1 (flanco de subida del reloj)
											//  2) cuando iRST baja de 1 a 0 (se activa el reset)
			if (~iRST) oQ = 1'b0;			//Igual a: if (RST == 0) 
										
										
			else oQ = iD; 					//El reset tiene prioridad y si no está activo (iRST = 1), oQ copia a iD.
											
endmodule									



