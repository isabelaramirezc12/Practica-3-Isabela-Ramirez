//Flip-flop JK hecho con flip-flop D y compuertas
// 	flip-flop JK 
//   J=0, K=0: se mantiene  |  J=0, K=1: se pone en 0
//   J=1, K=0: se pone en 1 |  J=1, K=1: se invierte

module Ejercicio_7 (oQ, iJ, iK, iCLK, iRST);	
output oQ;								// oQ =LED
input iJ,iK,iCLK,iRST;					// Entradas: iJ = "prende", iK = "apaga", iCLK = RELOJ, iRST = RESET
wire JK;							
assign JK = (iJ & ~oQ) | (~iK & oQ);	// JK: D = (J AND NOT Q) OR (NOT K AND Q)
D_FF JK1 (oQ,JK,iCLK,iRST);				//Crea flip-flop D
										//flip-flop D llamado JK1 conectado:
										// Q con oQ, D con JK, CLK con iCLK, RST con iRST
endmodule	

//Flip-flop D
//flip-flop D con reset asíncrono(El mismo del ejercicio 5)
module D_FF (Q, D, CLK, RST);		
output reg Q;							// Q es la salida y guarda su valor (
input D,CLK,RST;						// Entradas: dato, reloj y reset
always @ (posedge CLK or negedge RST)	// Se activa cuando el reloj sube o cuando el reset baja
if (~RST) Q = 1'b0;						// reset = 0: la salida se borra (0) al instante, sino el flanco del reloj, Q copia a D 
else Q = D;								
endmodule	




							