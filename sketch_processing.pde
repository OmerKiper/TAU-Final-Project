// GUI siftware for Multichannel Controller project 22-1-2-2564 at Tel Aviv University

// importing relevant libraries
import controlP5.*;
import processing.serial.*;

Serial port;
ControlP5 cp5;
PFont font;
// initializing values
String val1 = "0.0";
String val2 = "0.0";
String val3 = "0.0";
String val4 = "0.0";
String val5 = "0.0";
String val6 = "0.0";

int counter = 0;

// creating buttons, labels and text fields
void setup() {
  size(800,500);
  port = new Serial(this, "COM9", 9600);
  cp5 = new ControlP5(this);
  font = createFont("calibri", 16);
  
  cp5.addButton("Apply_1")
    .setPosition(50,230)
    .setSize(100,100)
    .setFont(font)
  ;
  
  cp5.addButton("Apply_2")
    .setPosition(200,230)
    .setSize(100,100)
    .setFont(font)
  ;
  
  cp5.addButton("Apply_3")
    .setPosition(350,230)
    .setSize(100,100)
    .setFont(font)
  ;
  
  cp5.addLabel("V_1:")
    .setPosition(50,30)
    .setFont(font)
  ;
  
  cp5.addTextfield("V_1")
    .setPosition(50,50)
    .setSize(100,30)
    .setFont(font)
    .setCaptionLabel("")
  ;
  
  cp5.addLabel("V_2:")
    .setPosition(200,30)
    .setFont(font)
  ;
  
  cp5.addTextfield("V_2")
    .setPosition(200,50)
    .setSize(100,30)
    .setFont(font)
    .setCaptionLabel("")
  ;
  
  cp5.addLabel("V_3:")
    .setPosition(350,30)
    .setFont(font)
  ;
  
  cp5.addTextfield("V_3")
    .setPosition(350,50)
    .setSize(100,30)
    .setFont(font)
    .setCaptionLabel("")
  ;
  
  cp5.addLabel("V_MAX_1:")
    .setPosition(50,90)
    .setFont(font)
  ;
  
  cp5.addTextfield("V_MAX_1")
    .setPosition(50,110)
    .setSize(100,30)
    .setFont(font)
    .setCaptionLabel("")
  ;
  
  cp5.addLabel("V_MAX_2:")
    .setPosition(200,90)
    .setFont(font)
  ;
  
  cp5.addTextfield("V_MAX_2")
    .setPosition(200,110)
    .setSize(100,30)
    .setFont(font)
    .setCaptionLabel("")
  ;
  
  cp5.addLabel("V_MAX_3:")
    .setPosition(350,90)
    .setFont(font)
  ;
  
  cp5.addTextfield("V_MAX_3")
    .setPosition(350,110)
    .setSize(100,30)
    .setFont(font)
    .setCaptionLabel("")
  ;
  
  cp5.addLabel("P_MAX_1:")
    .setPosition(50,150)
    .setFont(font)
  ;
  
  cp5.addTextfield("P_MAX_1")
    .setPosition(50,170)
    .setSize(100,30)
    .setFont(font)
    .setCaptionLabel("")
  ;
  
  cp5.addLabel("P_MAX_2:")
    .setPosition(200,150)
    .setFont(font)
  ;
  cp5.addTextfield("P_MAX_2")
    .setPosition(200,170)
    .setSize(100,30)
    .setFont(font)
    .setCaptionLabel("")
  ;
  
  cp5.addLabel("P_MAX_3:")
    .setPosition(350,150)
    .setFont(font)
  ;
  
  cp5.addTextfield("P_MAX_3")
    .setPosition(350,170)
    .setSize(100,30)
    .setFont(font)
    .setCaptionLabel("")

  ;
  cp5.addButton("Off_1")
    .setPosition(50,350)
    .setSize(100,100)
    .setFont(font)
  ;
  
  cp5.addButton("Off_2")
    .setPosition(200,350)
    .setSize(100,100)
    .setFont(font)
  ;
  
  cp5.addButton("Off_3")
    .setPosition(350,350)
    .setSize(100,100)
    .setFont(font)
  ;

  cp5.addButton("Read_V1")
    .setPosition(500,50)
    .setSize(80,50)
    .setFont(font)
  ;
  
  cp5.addButton("Read_I1")
    .setPosition(500,110)
    .setSize(80,50)
    .setFont(font)
  ;
  
    cp5.addButton("Read_V2")
    .setPosition(500,200)
    .setSize(80,50)
    .setFont(font)
  ;
  
    cp5.addButton("Read_I2")
    .setPosition(500,260)
    .setSize(80,50)
    .setFont(font)
  ;
  
    cp5.addButton("Read_V3")
    .setPosition(500,350)
    .setSize(80,50)
    .setFont(font)
  ;
  
    cp5.addButton("Read_I3")
    .setPosition(500,410)
    .setSize(80,50)
    .setFont(font)
  ; 
}

void draw() {
  // designing the GUI optics
  background(0,180,180);
  noFill();
  rect(590,60,100,30);
  rect(590,120,100,30);
  rect(590,210,100,30);
  rect(590,270,100,30);
  rect(590,360,100,30);
  rect(590,420,100,30);
  text("Read Ch1:", 560, 40);
  text("Read Ch2:", 560, 190);
  text("Read Ch3:", 560, 340);
  textFont(font);
  
  // recieving information from the controller and updating the relevant value which is presented for the user in the text field
  while (port.available() > 0){
    if (counter == 1){
      val1 = port.readStringUntil('\n');
    }
    if (counter == 2){
      val2 = port.readStringUntil('\n');
    }
    if (counter == 3){
      val3 = port.readStringUntil('\n');
    }
    if (counter == 4){
      val4 = port.readStringUntil('\n');
    }
    if (counter == 5){
      val5 = port.readStringUntil('\n');
    }
    if (counter == 6){
      val6 = port.readStringUntil('\n');
    }
    else{
      break;
    }
  }

    textFont(font);
    text(val1, 610, 80);   
    text(val2, 610, 140);   
    text(val3, 610, 230);   
    text(val4, 610, 290);  
    text(val5, 610, 380);   
    text(val6, 610, 440);   
  
}

// defining the operation of the button (how they send the relevant data / command and in what order so that our controller will recieve the information correctly

void Apply_1() {
  java.lang.String v1 = cp5.get(Textfield.class, "V_1").getText();
  java.lang.String vm1 = cp5.get(Textfield.class, "V_MAX_1").getText();
  java.lang.String pm1 = cp5.get(Textfield.class, "P_MAX_1").getText();
  port.write("a\n");
  port.write(v1+"\n");
  port.write(vm1+"\n");
  port.write(pm1+"\n");
}

void Apply_2() {
  java.lang.String v2 = cp5.get(Textfield.class, "V_2").getText();
  java.lang.String vm2 = cp5.get(Textfield.class, "V_MAX_2").getText();
  java.lang.String pm2 = cp5.get(Textfield.class, "P_MAX_2").getText();
  port.write("b\n");
  port.write(v2+"\n");
  port.write(vm2+"\n");
  port.write(pm2+"\n");
}

void Apply_3() {
  java.lang.String v3 = cp5.get(Textfield.class, "V_3").getText();
  java.lang.String vm3 = cp5.get(Textfield.class, "V_MAX_3").getText();
  java.lang.String pm3 = cp5.get(Textfield.class, "P_MAX_3").getText();
  port.write("c\n");
  port.write(v3+"\n");
  port.write(vm3+"\n");
  port.write(pm3+"\n");
}

void Off_1() {
  port.write("f");
}

void Off_2() {
  port.write("e");
}

void Off_3() {
  port.write("h");
}

void Read_V1() {
  port.write("r");
  counter = 1;
}

void Read_I1() {
  port.write("k");
  counter = 2;
}

void Read_V2() {
  port.write("m");
  counter = 3;
}

void Read_I2() {
  port.write("n");
  counter = 4;
}

void Read_V3() {
  port.write("p");
  counter = 5;
}

void Read_I3() {
  port.write("t");
  counter = 6;
}
