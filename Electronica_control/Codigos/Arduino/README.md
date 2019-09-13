# ARDUINO

En esta carpeta est�n los c�digos usados de Arduino para controlar el montaje.

* **motor_boton**: controla el motor con un puente en H, de manera que es capaz de cambiar el sentido, que se hace a trav�s de un bot�n, y var�a la velocidad con un potenci�metro en LAZO ABIERTO.

Para comprobar si arduino es capaz de contar las l�neas del encoder, hacemos un c�digo de prueba en el que cuando haya contado 1800 l�neas, que son una vuelta del encoder, se pare el motor. Si da m�s de una vuelta, no es capaz de contar todas las l�neas por lo que el control con Arduino y el encoder no se podr�a hacer.

* **prb_ard_oscila_sin_control**: es la prueba de si Arduino es capaz de contarlo. Como tiene inercia cuando se para el motor se pasar�a de una vuelta as� que se hace que vuelva y se quede exacto en el 1800. Se ve que oscila.

* **prb_ard_oscila_sin_control_tiempo**: queremos comprobar cu�nto tiempo tarda Arduino en leer las l�neas del encoder. 

* **prb_ard_oscila_con_control**: para solucionar la oscilaci�n del anterior, se incluye un sistema de control PD para que no oscile tanto ya que puede quemar el motor.


* **senal_analogica_a_digital**: transforma una se�al anal�gica de entrada a una se�al digital. Est� pensado para el encoder que se encontr� en la impresora. Se hizo en un principio porque al ser un encoder reciclado no sab�amos si la se�al ser�a anal�gica o digital y a nosotros nos interesaba digital. Finalmente no es necesario este c�digo porque comprobando con un osciloscopio la forma de la se�al del encoder vemos que es lineal.

* **velocidad_retoques**: es una prueba que no funciona de controlar la velocidad de la cinta transportadora con lazo cerrado.


