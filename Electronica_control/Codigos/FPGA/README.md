# FPGA

En esta carpeta están los códigos usados de FPGA para controlar el montaje.

* **prueba_FPGA**: al igual que sucedía en Arduino, hay que comprobar que la FPGA es capaz de leer todas las líneas del encoder. El código para el motor cuando ha contado las 1800 líneas. Lo muestra por el display las líneas que cuenta. En este caso no hacemos que vuelva al pasarse por la inercia.

* **motor_lazo_abierto**: controla el motor con un puente en H, de manera que es capaz de cambiar el sentido, que se hace con un interruptor, y varía la velocidad con un botón que la aumenta y otro que la disminuye, pudiendo aumentar las unidades, decenas o centenas en LAZO ABIERTO.

* **prueba_vueltas**: este código se realiza para medir el tiempo que tarda en dar una vuelta para poder hacer los cálculos para el lazo cerrado.


* **PWM_prueba_lazocerrado_v3**: se controla la cinta transportadora con un LAZO CERRADO usando un control proporcional

