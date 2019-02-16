int chA=3; //El canal A del encoder está conectado al pin3
int chB=4; //El canal B del encoder está conectado al pin4
int lecturaA=0; //Inicializamos una variable en la que guardaremos
                //el valor de lo que se lee en el canal A del encoder
int lecturaB=0; //Inicializamos una variable en la que guardaremos
                //el valor de lo que se lee en el canal B del encoder
int digitalA=0; //Variable en la que guardaremos el valor de la señal
                //A del encoder en forma digital
int digitalB=0; //Variable en la que guardaremos el valor de la señal
                //B del encoder en forma digital

void setup() {
  Serial.println(9600);
  pinMode(chA,INPUT);
  pinMode(chB,INPUT);

}

void loop() {
  lecturaA=analogRead(chA);
  lecturaB=analogRead(chB);

  //Dado que el analogRead nos da valores entre 0 y 1023 y nos interesa
  //que la señal de entrada que es analógica pase a ser digital, fijamos
  //que por encima de 512 el valor que devuelva ser 1 y por debajo 0

  if (lecturaA<512){
    digitalA=0;
  }
  else{
    digitalA=1;
  }
  if (lecturaB<512){
    digitalB=0;
  }
  else{
    digitalB=1;
  }

}
