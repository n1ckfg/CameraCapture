//for Processing 1.5

import processing.video.*;
import codeanticode.gsvideo.*;

int numCameras = 1;
int cW = 640;
int cH = 480;
int fps = 30;
int sW, sH;
int rowCount = 2;

GSCapture[] cam;
String[] camNames;
String[] captureList;

PFont font;
int fontSize = 12;
boolean firstRun = true;
boolean showGSCaptureList = false;
String defaultName = "USB Video Class Video";
// some common camera names: 
// USB Video Class Video
// DV Video
// IIDC FireWire Video
// Sony HD Eye for PS3 (SLEH 00201)

void initSettings() {
  cam = new GSCapture[numCameras];
  camNames = new String[numCameras];
  Settings settings = new Settings("settings.txt");
  //width
  if (numCameras>rowCount) {
    sW = cW * rowCount;
  } else {
    sW = cW * numCameras;
  }
  //height
  if (numCameras>rowCount) {
    sH = int(cH * rounder(float(numCameras)/float(rowCount), 0));
  } else {
    sH = cH;
  }
}

void setup() {
  initSettings();
  size(sW, sH);
  frameRate(fps);
  captureList = Capture.list();
  for (int i=0;i<cam.length;i++) {
    try {
      cam[i] = new GSCapture(this, cW, cH, camNames[i], fps);
      cam[i].start();
    }
    catch(Exception e) {
    }
  }

  font = createFont("Arial", fontSize);
}

void draw() {
  background(127);
  int counter=0;
  for (int i=0;i<cam.length;i++) {
    try{
    if (cam[i].available()) {
      cam[i].read();
    }
    if(rowCount>1){
      image(cam[i], i*cW, i*counter*cH, cW, cH);
    }else{
      image(cam[i], 0, i*cH, cW, cH);
    }
    }catch(Exception e){ }
    if(i>rowCount-1) counter++;
  }

  if (showGSCaptureList) {
    textFont(font, fontSize);
    noStroke();
    for (int i=0;i<captureList.length;i++) {
      String sayText = i+".  " + captureList[i];
      fill(0, 150);
      text(sayText, 1+fontSize, 1+(1.5 * fontSize)+(i*fontSize));
      fill(255);
      text(sayText, fontSize, (1.5 * fontSize)+(i*fontSize));
    }
  }
}

void keyPressed() {
  if (key=='c'||key=='C') {
    showGSCaptureList = !showGSCaptureList;
  }
}

float rounder(float _val, float _places) {
  _val *= pow(10, _places);
  _val = round(_val);
  _val /= pow(10, _places);
  return _val;
}

