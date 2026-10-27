
`timescale 1ns/1ps//Unidad de tiempo por precisión 

module Ejercicio_2;

    reg clock;// declaración de clock

    initial begin//inicio
        clock = 1'b0;// inicia la señal en cero y con un bit de ancho
        #300 $finish; //La simulación se detiene a los 300 ns
    end

    always begin//Se ejecuta para siempre mientras la simulación continue activa
        #10 clock = ~clock;// cada 10 unidades de tiempo cambia el valor de la señal invirtiendola
    end

endmodule
