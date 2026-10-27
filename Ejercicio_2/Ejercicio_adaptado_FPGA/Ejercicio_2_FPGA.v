module Ejercicio_2_FPGA (
    input      clk,      // reloj de 50 MHz de la tarjeta
    input      SW0,  // switch SW0: abajo = para a los 15 s, arriba = se repite para siempre
    output reg led       // LED
);
    reg [31:0] contador = 0;   // mide 0,5 s (el #10)
    reg [31:0] tiempo   = 0;   //  mide 15 s  (el #300)

    initial led = 0;           // el LED arranca apagado (como clock = 1'b0)

    always @(posedge clk) begin                          // se repite en cada pulso del reloj
        if (tiempo < 750000000 || SW0 == 1) begin    // sigue si no han pasado 15 s O si el switch esta arriba

            if (tiempo < 750000000)
                tiempo <= tiempo + 1;                    // el cronometro avanza hasta 15 s y ahi se queda

            if (contador == 24999999) begin              // ya pasaron 0,5 s
                contador <= 0;                           // borra la libreta 1
                led      <= ~led;                        // clock = ~clock
            end
            else begin
                contador <= contador + 1;                // sigue contando
            end
        end
        // si pasaron 15 s y el switch esta abajo no entra a nada, todo queda congelado (como $finish)
    end
endmodule
