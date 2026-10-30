// Registro de 4 bits armado con 4 etapas iguales (cada una equivale a un  multiplexor 4x1 + flip-flop D)
// Selector: 00 = no cambia | 01 = corre a la derecha | 10 = corre a la izquierda | 11 = carga paralela

module Ejercicio_14 (iI,iselect,ilfin,irtin,oA,iCLK,iClr); 
	input [3:0] iI;			//Entrada paralela 
							// 4 bits que se cargan cuando el selector es 11
	input [1:0] iselect;		
							
	input ilfin,irtin,iCLK,iClr; 
							// ilfin entra por la derecha (al correr a la izquierda)
							// irtin entra por la izquierda (al correr a la derecha)
							// iClr borra todo cuando vale 0
	output [3:0] oA;
							// Los 4 bits guardados: oA[3] (izquierda) ... oA[0] (derecha)

	// Orden de conexión de cada etapa: (i0, i1, i2, i3, Q, select, CLK, Clr)
	//   i0 = su propio valor (sin cambio)   | i1 = vecino izquierdo (derecha)
	//   i2 = vecino derecho (izquierda)     | i3 = bit de entrada paralela (carga)
	stage ST0 (oA[0],oA[1],ilfin,iI[0],oA[0],iselect,iCLK,iClr); 	// Bit 0: por la derecha entra ilfin
	stage ST1 (oA[1],oA[2],oA[0],iI[1],oA[1],iselect,iCLK,iClr); 	// Bit 1: vecinos oA[2] y oA[0]
	stage ST2 (oA[2],oA[3],oA[1],iI[2],oA[2],iselect,iCLK,iClr); 	// Bit 2: vecinos oA[3] y oA[1]
	stage ST3 (oA[3],irtin,oA[2],iI[3],oA[3],iselect,iCLK,iClr); 	// Bit 3: por la izquierda entra irtin
endmodule 					
 
// Cada etapa maneja UN bit: el multiplexor escoge el próximo valor y el flip-flop lo guarda.
module stage(i0,i1,i2,i3,Q,select,CLK,Clr); 	// Circuito "stage": 4 opciones, salida, selector, reloj y clear
	input i0,i1,i2,i3,CLK,Clr; 		// Las 4 opciones del multiplexor, reloj y clear
	input [1:0] select; 			// Selector de 2 bits: escoge cuál de las 4 opciones pasa
	output reg Q; 					// Salida de la etapa (el bit guardado)
	
	reg D; 						
				

	//Multiplexor 4x1 
	// Lógica combinacional (sin reloj): recalcula cada vez que cambia una opción o el selector
	always @ (i0 or i1 or i2 or i3 or select) 
		case (select) 				// Según el selector, deja pasar una sola opción hacia D:
			2'b00: D = i0; 			// 00: pasa i0 (sin cambio)
			2'b01: D = i1; 			// 01: pasa i1 (desplazamiento a la derecha)
			2'b10: D = i2; 			// 10: pasa i2 (desplazamiento a la izquierda)
			2'b11: D = i3; 			// 11: pasa i3 (carga paralela)
		endcase 

	//Flip-flop D 
	// Guarda en Q lo que eligió el multiplexor, en el flanco de subida del reloj
	always @ (posedge CLK or negedge Clr) 	// Se activa cuando el reloj sube o cuando el clear baja
		if (~Clr) Q = 1'b0; 		// Si clear vale 0 borra el bit 
		else Q = D; 				// Sino en el flanco Q copia lo que eligió el multiplexor
	
endmodule							