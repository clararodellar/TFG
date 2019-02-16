//El programa cambia la velocidad de giro del motor en función de lo que marque el potenciómetro

int potenciometro=A0; //Asignamos el poteciómetro al pin analógico A0
int motor=3; //Conectamos el motor al pin digital 3
int lectura=0;
int velocidad=0;

void setup()
{
  pinMode(potenciometro,INPUT);
  pinMode(motor,OUTPUT);
  Serial.begin(9600);
}

void loop()
{
  lectura=analogRead(potenciometro);//Guardamos valor de potenciometro
  velocidad=map(lectura,0,1023,0,255); //Es así porque los valores qe lee analogRead son de 0 a 1023 pero analogWrite escribe de 0 a 255, por eso es necesario el cambio de rango
  analogWrite(motor,velocidad);
}
