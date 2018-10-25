//Este programa únicamente enciende  o apaga el motor con un botón.
//Podríamos poner 3 botones, uno que sube la velocidad, otro que 
//baja la velocidad, y otro que enciende y apaga.

int motor=3; //Conectamos el motor al pin digital 3
int motor2=5;
int boton=6;
int lectura=0;
int velocidad=0;
int c=0;

void setup() {
  pinMode(boton,INPUT);
  pinMode(motor,OUTPUT);
  pinMode(motor2,OUTPUT);
  Serial.begin(9600);

}

void loop() {

  /*lectura=digitalRead(boton);
  if (lectura==1){
    if (velocidad==1){
      velocidad=0;
    }
    else{
      velocidad=1;
    }
  }
  c=map(velocidad,0,2,0,255);*/
  analogWrite(motor,255);
  digitalWrite(motor2,HIGH);
}
