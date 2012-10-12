import processing.video.*;
import codeanticode.gsvideo.*;

int numCameras = 2;
GSCapture[] cam = new GSCapture[numCameras];
String[] cameraList;
PFont font;
int fontSize = 12;
boolean showcameraList = false;
String nameDV = "DV Video";
String nameFW = "IIDC FireWire Video";
String namePS3 = "Sony HD Eye for PS3 (SLEH 00201)";
String nameUSB = "USB Video Class Video";


void setup() {
  size(1280, 480);
  cameraList = Capture.list();
  if (cameraList.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    println("Available cameras:");
    for (int i = 0; i < cameraList.length; i++) {
      println(i+".  " + cameraList[i]);
    }
  }
  //you can call either a specific device, or specify width, height, fps.
  cam[0] = new GSCapture(this, 640, 480, namePS3, 30);
  cam[1] = new GSCapture(this, 640, 480, nameUSB, 30);
  //cam[0] = new Capture(this, 640, 480, 30);
  
  for (int i=0;i<cam.length;i++) {
    cam[i].start();
  }
  
  font = createFont("Arial", fontSize);
}

void draw() {
  background(127);
  for (int i=0;i<cam.length;i++) {
    if (cam[i].available()) {
      cam[i].read();
    }
  }
  image(cam[0], 0, 0, 640, 480);
  image(cam[1], 640, 0, 640, 480);
  if (showcameraList) {
    textFont(font, fontSize);
    noStroke();
    for (int i=0;i<cameraList.length;i++) {
      String sayText = i+".  " + cameraList[i];
      fill(255, 50);
      text(sayText, 1+fontSize, 1+(1.5 * fontSize)+(i*fontSize));
      fill(0);
      text(sayText, fontSize, (1.5 * fontSize)+(i*fontSize));
    }
  }
}

void keyPressed() {
  if (key=='c'||key=='C') {
    showcameraList = !showcameraList;
  }
}

