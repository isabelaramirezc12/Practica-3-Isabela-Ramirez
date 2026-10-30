//Descripción funcional de flip-flop JK a partir de su tabla característica usando preguntas "if / else if" en vez de "case"
module Ejercicio_9 (iJ, iK, iCLK, oQ, oQnot); 
	output oQ, oQnot; 					//Salidas: oQ (el valor guardado) y oQnot (lo contrario)
	input iJ, iK, iCLK; 				// Entradas: iJ = "prende", iK = "apaga", iCLK = RELOJ (no tiene reset)
	reg rQ; 							// rQ guarda el valor entre flancos del reloj
	assign oQnot = ~rQ;  				
	assign oQ = rQ; 					
	always @(posedge iCLK) 				// El bloque se activa solo en el flanco de subida del reloj
	begin 								
				if ((iJ == 0) && (iK == 0)) 		// ¿J vale 0 Y K vale 0? ("==" compara, "&&" = "y además")
				begin 
						rQ = rQ; 					// Sí se mantiene = se asigna el mismo valor
				end 
				else if ((iJ == 1) && (iK == 0)) 	// Sino ¿J vale 1 Y K vale 0?
				begin 
						rQ = 1'b1; 					// Sí sí, se pone en 1 (set)
				end 
				else if ((iJ == 0) && (iK == 1)) 	// Sino, ¿J vale 0 Y K vale 1?
				begin 
						rQ = 1'b0; 					// Sí sí se pone en 0 (reset)
				end 
				else if ((iJ == 1) && (iK == 1)) 	// Sino, ¿J vale 1 Y K vale 1?
				begin 
						rQ = ~rQ; 					// Sí sí se invierte (toggle)
				end 
		end 							
endmodule							