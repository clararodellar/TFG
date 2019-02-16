# CIRCUITO DE CONEXION DEL MOTOR


Este modelo est� probado. El modelo est� hecho con Fritzing

![imagen](https://github.com/clararodellar/TFG/blob/master/Motor/Conexion_probada/esquema_motor.png)

## Elementos:
* Octoacoplador 4N35
* Transistor irlb8721
* Motor reciclado de impresora hp dekjet 845
* Placa de arduino UNO
* Diodo IN4001
* Fuente de tensi�n de corriente continua de 12V
* Resistencias (220 ohmios,10000 ohmios)

Consta de un motor reciclado de una impresora. A este se le conecta un diodo con el c�todo en el borne positivo para que durante el funcionamiento no le pase corriente y cuando se desconecte el motor podr� descargarse con el diodo. El uso del octoacoplador es para aislar el�ctricamente el circuito de mando y el de potencia externa. El uso del transistor es para alcanzar la potencia necesaria que Arduino no es capaz de suministrar.
