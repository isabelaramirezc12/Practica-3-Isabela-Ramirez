// Contador de 2 bits (A B) hecho con dos flip-flops T.
// Si x = 1, en cada flanco de subida cuenta 00 -> 01 -> 10 -> 11 -> 00.
// Si x = 0, la cuenta se detiene. La salida y vale 1 solo en el estado 11.

module Ejercicio_12 (x,y,A,B,CLK,RST); 
	input x,CLK,RST; 				// Entradas: x = permiso para contar, CLK = RELOJ, RST = RESET (activo en 0)
	output y,A,B; 					// Salidas: A y B = la cuenta (estado), y = aviso de "llegó a 11"
 
	wire TA,TB; 					
	 
	assign	TB = x,		// B se invierte en cada flanco mientras x = 1			
								
		TA = x & B; 		//A se invierte solo si x = 1 y además B = 1
									
	assign y = A & B;		//vale 1 solo en el estado 11	
									
									//flip-flops T 
	T_FF BF (B,TB,CLK,RST);	// Flip-flop BF: Q con B, T con TB, CLK con CLK, RST con RST		
									
	T_FF AF (A,TA,CLK,RST); // Flip-flop AF: Q con A, T con TA, CLK con CLK, RST con RST
endmodule 							
 
// Flip-flop T con reset asíncrono
module T_FF (Q,T,CLK,RST); 		
	output reg Q; 					// Q es salida y guarda su valor (reg)
	input T,CLK,RST; 				// Entradas: T = invertir o no, CLK = reloj, RST = reset
 
	always @ (posedge CLK or negedge RST) 	// Se activa cuando el reloj sube o cuando el reset baja
		if (~RST) Q = 1'b0; 		// Si el reset vale 0 la salida se borra, Si no, en el flanco: Q = Q XOR T (T=0 se mantiene, T=1 se invierte)
		else Q = Q ^ T; 			
endmodule 						
 
//Estímulo para probar el circuito secuencial para ModelSim

module testTcircuit; 			
	reg x,CLK,RST;		// entradas "reg" porque el testbench les va dando valores		
								
	wire y,A,B;			// salidas "wire" porque solo se observan	
								
 
	Ejercicio_12 TC (x,y,A,B,CLK,RST);		//se crea un ejemplar del circuito que Conecta el circuito a probar con las señales de prueba
										
 // bloque que genera el reset y el reloj
	initial 						
		begin 
		RST = 0; 					// t = 0: reset activo (A y B arrancan en 0)
		CLK = 0; 					// t = 0: el reloj arranca en 0
		#5 RST = 1; 				// t = 5 ns: se suelta el reset
		repeat (16) 				
		#5 CLK = ~CLK; 				// el reloj se invierte cada 5 ns
		end 						
 
 // bloque que genera la entrada x
	initial 						
		begin 
		x = 0; 						// t = 0: x empieza en 0
		#15 x = 1; 					// t = 15 ns: x pasa a 1
		repeat (8) 				
		#10 x = ~ x; 				// x se invierte cada 10 ns (justo en los flancos de bajada del reloj)
		end 
endmodule 							// Fin del testbench