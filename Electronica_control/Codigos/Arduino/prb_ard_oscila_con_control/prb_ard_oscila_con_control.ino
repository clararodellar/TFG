int sensor1=2;
int sensor2= 3;

int opto1=5;
int opto2=6;

int valor_sensor1; // Lectura del sensor 1
int valor_sensor2; // Lectura del sensor 2
int valor_sensor1_anterior = LOW; // Valor anterior de la lectura del sensor 1

const int derecha=0;
const int izquierda=1;
int sentido=derecha;

int posicion=0;
int posicion_deseada=1800; // Posición en la que queremos que se pare al pulsar.
int posicion_actual;

int moviendo= HIGH;
int velocidad;

// Control PD
int error;
int control_pd;
int ultimo_error=0;
int suma_error=0;
int Kp = 150;
int Kd = 30;
//int Ki = 2;

int tiempo;
int tiempo_anterior;
int delta;

void setup() {
  pinMode (opto1,OUTPUT);
  pinMode (opto2,OUTPUT);
  Serial.begin(115200);
  pinMode (sensor1, INPUT);
  pinMode (sensor2, INPUT);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Función para calcular la posición del encoder

  int calcular_posicion(){

  valor_sensor1 = digitalRead (sensor1); // Actualizamos el valor del sensor1
  
  if ((valor_sensor1_anterior == HIGH) && (valor_sensor1 == LOW)) { // Si el valor anterior del mismo sensor antes era negro y ahora es blanco significa que se ha movido
    valor_sensor2 = digitalRead (sensor2);
    if(valor_sensor2 == LOW){ // Si el valor del otro sensor es blanco significa que estoy retrocediendo
      posicion--;
    }
    else{ // Si el valor del otro sensor es negro, significa que me muevo en sentido contrario
      posicion++; //Sumo una posición.
    }
  }
  valor_sensor1_anterior = valor_sensor1;
  Serial.println(posicion, DEC); // Muestro la posición en la que estoy por pantalla
  
  return posicion;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void loop(){

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Calculamos el error y la velocidad
  
  // Cálculo de la velocidad del motor dependiendo del control PD

  tiempo = millis(); // Tomamos el momento en el que se hace
  posicion_actual = calcular_posicion(); // Cálculamos la posición en la que estamos
  error = posicion_deseada - posicion_actual; // Se calcula el error
  //Serial.println(error);

  delta = (tiempo - tiempo_anterior); // Se calcula la variación de tiempo entre una posición y otra
  //Serial.println(delta);
  control_pd = Kp*error + Kd*(error-ultimo_error)/delta; 
  ultimo_error = error;

  tiempo_anterior = tiempo;
  if (control_pd>70 && control_pd<100 ){ // Si el valor obtenido está entre -255 y 255
    velocidad = abs(control_pd); // La velocidad de motor es el valor del control en valor absoluto
  }
  else{ // No está entre -255 y 255
    if(control_pd <70){ // Si el valor es mayor a 255
      velocidad = 70; // La velocidad del motor es 255, que es la máxima que se puede pasar a un analogWrite
    }
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Controlamos si el motor debe estar en marcha o no en función del error

  if (error != 0 && moviendo == LOW){ // Si el error es distinto de 0 y no está moviéndose
    moviendo = HIGH; // Hacemos que vuelva a moverse
  }
  else if (error == 0){ // Si el error es 0
    moviendo = LOW; // La bandeja deja de moverse
  }

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Controlamos el movimiento del motor y su sentido

  if (moviendo == LOW){ // Paramos el motor porque hemos llegado a la posición deseada
    analogWrite(opto1, 0);
    analogWrite(opto2, 0);
  }
  else{ // El motor está en funcionamiento
    if (error>0){ // Aún no ha llegado a la posición deseada
      analogWrite(opto1, velocidad); // El sentido del motor es el de abrir
      analogWrite(opto2, 0);
    }
    else{ // Me he pasado de la posición deseada
      analogWrite(opto1, 0); // El motor va en el sentido de cerrar.
      analogWrite(opto2, velocidad);
    }
  }
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}

