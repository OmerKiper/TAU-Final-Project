// Arduino UNO controller for Multichannel Controller project 22-1-2-2564 at Tel Aviv University

// giving meaningful names to the relevant pins which we use in the controller and creating global variables
int PWM_1 = 9;
int PWM_2 = 10;
int PWM_3 = 11;
char V_3 = 'A0';
char I_3 = 'A1';
char V_2 = 'A2';
char I_2 = 'A3';
char V_1 = 'A4';
char I_1 = 'A5';
char data = NULL;
int channel = 0;
int counter;
int wrd_cnt = 0;
char wrd[10] = "";
float input;
// creating an array which represents the state of each channel (voltage, current, duty cycle)
float converters[3][3] = {0};
float voltages[3] = {0};
float currents[3] = {0};
int DCs[3] = {0};

void setup() {
  // put your setup code here, to run once:
  pinMode(PWM_1,OUTPUT); // setting digital pin 9 to be the PWM signal for channel 1 converter
  TCCR1B = TCCR1B & B11111000 | B00000001;
  pinMode(PWM_2,OUTPUT); // setting digital pin 10 to be the PWM signal for channel 2 converter
  TCCR1B = TCCR1B & B11111000 | B00000001;
  pinMode(PWM_3,OUTPUT); // setting digital pin 11 to be the PWM signal for channel 3 converter
  TCCR2B = TCCR2B & B11111000 | B00000001;
  Serial.begin(9600);
  counter = -1;
  input = 0;
}

void control(){
// checking all channel periodically and disconnecting a channel in case of over voltage or over power  
  for(int i=0; i<3 ; i++){  

    if(converters[i][0] != 0){
      if((voltages[i] >= converters[i][1]) || (voltages[i]*currents[i] >= converters[i][2])){
        converters[i][0] = 0;
        converters[i][1] = 0;
        converters[i][2] = 0;
        DCs[i] = 0;
        analogWrite(i+9,LOW);
        TCCR2B = TCCR2B & B11111000 | B00000001;
      }
    }
  }  
}

void loop() {
  // put your main code here, to run repeatedly:

  // reading analog data and calculating the voltage and current values for each channel
  voltages[0] = analogRead(V_1)*(15.0/1023.0);
  voltages[1] = analogRead(V_2)*(15.0/1023.0);
  voltages[2] = analogRead(V_3)*(15.0/1023.0);
  currents[0] = (analogRead(I_1)*(5.0/1023.0)-2.5)/0.66;
  currents[1] = (analogRead(I_2)*(5.0/1023.0)-2.5)/0.66;
  currents[2] = (analogRead(I_3)*(5.0/1023.0)-2.5)/0.66;

  // updating the duty cycle in case the control algorithm changed anything
  analogWrite(PWM_1,DCs[0]);
  TCCR1B = TCCR1B & B11111000 | B00000001;
  analogWrite(PWM_2,DCs[1]);
  TCCR1B = TCCR1B & B11111000 | B00000001;
  analogWrite(PWM_3,DCs[2]);
  TCCR2B = TCCR2B & B11111000 | B00000001;
  if(counter == -1){
    control();
  }

  // reading the UART communication fron the user using the GUI and sending commands
  if(Serial.available()) {
    data = Serial.read();
    wrd[wrd_cnt] = data;
    wrd_cnt++; 
    if('\n' == data){
      if(counter != -1){
        input = atof(wrd);
        memset(wrd, 0, 10);
      }      
      wrd_cnt = 0;   
      counter++;
    }
    
    // responding according to which command was given (reading / writing / turning off)
    if(data == 'r') {
      Serial.println(voltages[0]);
    }
      
    if(data == 'k') {
      Serial.println(currents[0]);
    }
        
    if(data == 'm') {
      Serial.println(voltages[1]);
    }
        
    if(data == 'n') {
      Serial.println(currents[1]);
    }
        
    if(data == 'p') {
      Serial.println(voltages[2]);
    }
  
    if(data == 't') {
      Serial.println(currents[2]);
    }

    if(data == 'f') {
      converters[0][0] = 0;
      converters[0][1] = 0;
      converters[0][2] = 0;
      DCs[0] = 0;
    }
    if(data == 'e') {
      converters[1][0] = 0;
      converters[1][1] = 0;
      converters[1][2] = 0;
      DCs[1] = 0;
    }
    if(data == 'h') {
      converters[2][0] = 0;
      converters[2][1] = 0;
      converters[2][2] = 0;
      DCs[2] = 0;
    }
    
    // identifying which channel is relevant for the current command
    if(data == 'a'){
      channel = 0;
    }
    else if(data == 'b'){
      channel = 1;
    }
    else if(data == 'c'){
      channel = 2;
    }
    if(counter == 1){
      converters[channel][0] = input;
      if (channel == 0)
        DCs[channel] = (converters[channel][0]-1.283)*(255/15.82); // calculation based on calibration done on the buck converter
      else
        DCs[channel] = (converters[channel][0]-1.6081)*(255/14.91); // calculation based on calibration done on the buck converter       
    }

    else if(counter == 2){
      converters[channel][1] = input;
    }
    else if(counter == 3){
      converters[channel][2] = input;
      counter = -1;
    }
  }
}

