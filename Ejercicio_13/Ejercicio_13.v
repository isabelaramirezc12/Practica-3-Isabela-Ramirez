// Registro de 4 bits que en cada flanco del reloj dependiendo del selector s1 s0:
//   00 = no cambia | 01 = corre a la derecha | 10 = corre a la izquierda | 11 = carga 4 bits nuevos

module Ejercicio_13 (is1,is0,iPin,ilfin,irtin,oA,iCLK,iClr); 
	input is1,is0;				// forman el selector que escoge la operación	
									
	input ilfin, irtin;		// ilfin: bit que entra por la DERECHA al correr a la izquierda
									// irtin: bit que entra por la IZQUIERDA al correr a la derecha		
									
	input iCLK,iClr;				//Reloj y Clear 
									// iClr borra todo cuando vale 0 (activo en bajo)
	input [3:0] iPin;			 
									// 4 bits que se cargan cuando el selector es 11
	output reg [3:0] oA;				
									// Los 4 bits guardados: oA[3] (izquierda) ... oA[0] (derecha)

	always @ (posedge iCLK or negedge iClr) 	// Se activa cuando el reloj sube o cuando el clear baja
		if (~iClr) oA = 4'b0000; 	// Si clear vale 0 borra los 4 bits al instante
		else 						// Sino en el flanco del reloj:
			case ({is1,is0}) 		// pega s1 y s0 en un número de 2 bits y escoge la operación Sin cambio 
				2'b00: oA = oA;		
				2'b01: oA = {irtin,oA[3:1]};	//Desplazamiento a la derecha 
												// irtin entra por la izquierda, los bits 3,2,1 se corren a 2,1,0 y el bit 0 se pierde
												
				2'b10: oA = {oA[2:0],ilfin};	//Desplazamiento a la izquierda 
												// los bits 2,1,0 se corren a 3,2,1, ilfin entra por la derecha y el bit 3 se pierde
												
				2'b11: oA = iPin;	
										
			endcase
endmodule							