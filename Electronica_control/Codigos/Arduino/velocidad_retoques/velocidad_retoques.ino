int sensor1=2;
int sensor2= 3;
int potenciometro=A0; //Asignamos el poteciómetro al pin analógico A0
int boton=10;

int opto1=5;
int opto2=6;

int valor_sensor1; // Lectura del sensor 1
int valor_sensor2; // Lectura del sensor 2
int valor_sensor1_anterior = LOW; // Valor anterior de la lectura del sensor 1
int lectura_potenciometro;
int lectura_boton=0;
int lecturaprevia=0;

const int derecha=0;
const int izquierda=1;
int sentido=derecha;

int posicion=0;

int posicion_actual=0;
int posicion_anterior=0;


int moviendo= HIGH;
int velocidad_deseada;
int velocidad_real;
int velocidad_real_tension;
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
  pinMode(potenciometro,INPUT);
  pinMode(boton,INPUT);
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
  //Serial.println(posicion, DEC); // Muestro la posición en la que estoy por pantalla
  
  return posicion;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void loop(){

  //Si pulsas botón cambias sentido
  lectura_boton=digitalRead(boton);
  
  if (lectura_boton==1 && lecturaprevia==0){
    if (sentido==derecha){
      sentido=izquierda;
      //digitalWrite(LED_BUILTIN, HIGH);
    }
    else{
      sentido=derecha;
      //digitalWrite(LED_BUILTIN, LOW);
    }
  }
  lecturaprevia=lectura_boton; // Para evitar varias lecturas del 1 del botón. Detecta sólo la 
                               // transición de subida, no el nivel.


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  // Calculamos el error y la velocidad
  
  // Cálculo de la velocidad del motor dependiendo del control PD

  tiempo = millis(); // Tomamos el momento en el que se hace
  posicion_actual = calcular_posicion();

  if (tiempo - tiempo_anterior == 10){
    velocidad_real = (posicion_actual - posicion_anterior); // Cálculamos la velocidad que hay midiendo los palitos que cuenta en 10 ms
    tiempo_anterior = tiempo;
    posicion_anterior = posicion_actual;
    velocidad_real_tension = 255*velocidad_real/36; // 36 es el máximo de palitos que se puede leer. Redondea a la baja
    lectura_potenciometro=analogRead(potenciometro);
    //Serial.println(lectura_potenciometro, DEC);
    velocidad_deseada=map(lectura_potenciometro,0,1023,0,255); //Se necesita conversión
     
    error = velocidad_deseada - velocidad_real_tension; // Se calcula el error
    //Serial.println(error);

    delta = (tiempo - tiempo_anterior); // Se calcula la variación de tiempo entre una posición y otra
    //Serial.println(delta);
    control_pd = Kp*error + Kd*(error-ultimo_error)/delta; 
    ultimo_error = error;

    if (control_pd>-255 && control_pd<255){ // Si el valor obtenido está entre -255 y 255
      velocidad = abs(control_pd); // La velocidad de motor es el valor del control en valor absoluto
    }
    else{ // No está entre -255 y 255
      if(control_pd>255 || control_pd<-255){ // Si el valor es mayor a 255
        velocidad = 255; // La velocidad del motor es 255, que es la máxima que se puede pasar a un analogWrite
      }
    }
  }

  

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Controlamos el movimiento del motor y su sentido

  if (lectura_potenciometro == 0){ // Paramos el motor
    analogWrite(opto1, 0);
    analogWrite(opto2, 0);
  }
  else{ // El motor está en funcionamiento
    if (sentido==derecha){
      analogWrite(opto1,velocidad);
      analogWrite(opto2,0);
    }
    else{
      analogWrite(opto1,0);
      analogWrite(opto2,velocidad);
    }
  }
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

}


