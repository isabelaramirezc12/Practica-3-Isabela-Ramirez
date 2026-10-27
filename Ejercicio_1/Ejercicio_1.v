`timescale 1ns/1ps //Unidad de tiempo por precisión 

module Ejercicio_1;

    reg clock; // declaración de clock

    initial begin// Indica que solo se ejecuta una vez el algoritmo
        clock = 1'b0;// inicia la señal en cero y con un bit de ancho

        repeat (30) begin// repetición de 30 veces
            #10 clock = ~clock;// cada 10 unidades de tiempo cambia el valor de la señal invirtiendola
        end
    end

endmodule

