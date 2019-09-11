//El programa cambia la velocidad de giro del motor en función de lo que marque el potenciómetro

int potenciometro=A0; //Asignamos el poteciómetro al pin analógico A0
int boton=10;
int opto1=5;
int opto2=6;
int lectura_potenciometro=0;
int lectura_boton=0;
int lecturaprevia=0;
int velocidad=0;
int i=0;

const int derecha=0;
const int izquierda=1;
int sentido=derecha;

void setup()
{
  pinMode(potenciometro,INPUT);
  pinMode(boton,INPUT);
  pinMode(opto1,OUTPUT);
  pinMode(opto2,OUTPUT);
  Serial.begin(9600);
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop()
{
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
  

  for (i=0;i<100;i++){  // Para evitar los rebotes del botón
  //Leemos potenciometro
  lectura_potenciometro=analogRead(potenciometro);//Guardamos valor de potenciometro
  
  //Si está a 0 el potenciometro apaga el motor
  if (lectura_potenciometro==0){
    analogWrite(opto1,0);
    analogWrite(opto2,0);
  }
  //Si el potenciometro no está a 0, el motor tendrá la velocidad leída en el potenciómetro 
  //y el sentido leído en el botón
  else{
    velocidad=map(lectura_potenciometro,0,1023,0,255); // Es así porque los valores qe lee 
                                                       // analogRead son de 0 a 1023 pero 
                                                       // analogWrite escribe de 0 a 255, por
                                                       //  eso es necesario el cambio de rango
    if (sentido==derecha){
      analogWrite(opto1,velocidad);
      analogWrite(opto2,0);
    }
    else{
      analogWrite(opto1,0);
      analogWrite(opto2,velocidad);
    }
  }
  analogWrite(LED_BUILTIN, velocidad);
 }
}
