module Ejercicio_1_FPGA (
    input      clk,   // reloj de 50 MHz de la tarjeta
    output reg led    // LED
);

    reg [31:0] contador = 0;   // cuenta pulsos del reloj
    reg [4:0]  cambios  = 0;   // cuenta cuantas veces cambio el LED

    initial led = 0;           // el LED arranca apagado (como clock = 1'b0)

    always @(posedge clk) begin
        if (cambios < 30) begin                // repeat (30)
            if (contador == 49999999) begin    // cuando pasan los 0,5 s (el #10)
                contador <= 0;
                led      <= ~led;              // clock = ~clock
                cambios  <= cambios + 1;
            end
            else begin
                contador <= contador + 1;      // sigue contando
            end
        end
    end

endmodule