# FPGA

En esta carpeta est�n los c�digos usados de FPGA para controlar el montaje.

* **prueba_FPGA**: al igual que suced�a en Arduino, hay que comprobar que la FPGA es capaz de leer todas las l�neas del encoder. El c�digo para el motor cuando ha contado las 1800 l�neas. Lo muestra por el display las l�neas que cuenta. En este caso no hacemos que vuelva al pasarse por la inercia.

* **motor_lazo_abierto**: controla el motor con un puente en H, de manera que es capaz de cambiar el sentido, que se hace con un interruptor, y var�a la velocidad con un bot�n que la aumenta y otro que la disminuye, pudiendo aumentar las unidades, decenas o centenas en LAZO ABIERTO.

* **prueba_vueltas**: este c�digo se realiza para medir el tiempo que tarda en dar una vuelta para poder hacer los c�lculos para el lazo cerrado.


* **PWM_prueba_lazocerrado_v3**: se controla la cinta transportadora con un LAZO CERRADO usando un control proporcional

