# ARDUINO

En esta carpeta están los códigos usados de Arduino para controlar el montaje.

* **motor_boton**: controla el motor con un puente en H, de manera que es capaz de cambiar el sentido, que se hace a través de un botón, y varía la velocidad con un potenciómetro en LAZO ABIERTO.

Para comprobar si arduino es capaz de contar las líneas del encoder, hacemos un código de prueba en el que cuando haya contado 1800 líneas, que son una vuelta del encoder, se pare el motor. Si da más de una vuelta, no es capaz de contar todas las líneas por lo que el control con Arduino y el encoder no se podría hacer.

* **prb_ard_oscila_sin_control**: es la prueba de si Arduino es capaz de contarlo. Como tiene inercia cuando se para el motor se pasaría de una vuelta así que se hace que vuelva y se quede exacto en el 1800. Se ve que oscila.

* **prb_ard_oscila_sin_control_tiempo**: queremos comprobar cuánto tiempo tarda Arduino en leer las líneas del encoder. 

* **prb_ard_oscila_con_control**: para solucionar la oscilación del anterior, se incluye un sistema de control PD para que no oscile tanto ya que puede quemar el motor.


* **senal_analogica_a_digital**: transforma una señal analógica de entrada a una señal digital. Está pensado para el encoder que se encontró en la impresora. Se hizo en un principio porque al ser un encoder reciclado no sabíamos si la señal sería analógica o digital y a nosotros nos interesaba digital. Finalmente no es necesario este código porque comprobando con un osciloscopio la forma de la señal del encoder vemos que es lineal.

* **velocidad_retoques**: es una prueba que no funciona de controlar la velocidad de la cinta transportadora con lazo cerrado.


