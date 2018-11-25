//El programa cambia la velocidad de giro del motor en función de lo que marque el potenciómetro

int potenciometro=A0; //Asignamos el poteciómetro al pin analógico A0
int boton=10;
int octo1=5;
int octo2=6;
int lectura_potenciometro=0;
int lectura_boton=0;
int velocidad=0;

const int derecha=0;
const int izquierda=1;
int sentido=derecha;

void setup()
{
  pinMode(potenciometro,INPUT);
  pinMode(boton,INPUT);
  pinMode(octo1,OUTPUT);
  pinMode(octo2,OUTPUT);
  Serial.begin(9600);
}

void loop()
{
  //Si pulsas botón cambias sentido
  lectura_boton=digitalRead(boton);
  if (lectura_boton==1){
    if (sentido==derecha){
      sentido=izquierda;
    }
    else{
      sentido=derecha;
    }
  }
  
  //Leemos potenciometro
  lectura_potenciometro=analogRead(potenciometro);//Guardamos valor de potenciometro
  //Si está a 0 el potenciometro apaga el motor
  if (lectura_potenciometro=0){
    analogWrite(octo1,0);
    analogWrite(octo2,0);
  }
  //Si el potenciomtro no está a 0, el motor tendrá la velocidad leída en el potenciómetro y el sentido leído en el botón
  else{
    velocidad=map(lectura_potenciometro,0,1023,0,255); //Es así porque los valores qe lee analogRead son de 0 a 1023 pero 
                                                       //analogWrite escribe de 0 a 255, por eso es necesario el cambio de rango
    if (sentido==derecha){
      analogWrite(octo1,velocidad);
      analogWrite(octo2,0);
    }
    else{
      analogWrite(octo1,0);
      analogWrite(octo2,velocidad);
    }
  }
}
