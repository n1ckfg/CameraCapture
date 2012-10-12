class Settings {

  Data settings;

  Settings(String _s) {
    try {
      settings = new Data();
      settings.load(_s);
      for (int i=0;i<settings.data.length;i++) {
        if (settings.data[i].equals("Number of Cameras")){
          numCameras = setInt(settings.data[i+1]);
          cam = new GSCapture[numCameras];
          camNames = new String[numCameras];
        }
        if (settings.data[i].equals("Row Count")) rowCount = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Camera Width")) cW = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Camera Height")) cH = setInt(settings.data[i+1]);
        if (settings.data[i].equals("Camera Framerate")) fps = setInt(settings.data[i+1]);
        for (int k=0;k<numCameras;k++) {
          if (settings.data[i].equals("Camera "+(k+1)+" Name")) {
            try{
              camNames[k] = setString(settings.data[i+1]);
              println("Camera "+(k+1)+": " + camNames[k]);
            }catch(Exception e){ }
          }
        }
      }
    }
    catch(Exception e) {
      for (int i=0;i<numCameras;i++) {
          camNames[i]=defaultName;
      }
      println("Couldn't load settings file. Using defaults.");
    }
  }

  int setInt(String _s) {
    return int(_s);
  }

  float setFloat(String _s) {
    return float(_s);
  }

  boolean setBoolean(String _s) {
    return boolean(_s);
  }

  String setString(String _s) {
    return ""+(_s);
  }

  color setColor(String _s) {
    color endColor = color(0);
    int commaCounter=0;
    String sr = "";
    String sg = "";
    String sb = "";
    String sa = "";
    int r = 0;
    int g = 0;
    int b = 0;
    int a = 0;

    for (int i=0;i<_s.length();i++) {
      if (_s.charAt(i)!=char(' ') && _s.charAt(i)!=char('(') && _s.charAt(i)!=char(')')) {
        if (_s.charAt(i)==char(',')) {
          commaCounter++;
        }
        else {
          if (commaCounter==0) sr += _s.charAt(i);
          if (commaCounter==1) sg += _s.charAt(i);
          if (commaCounter==2) sb += _s.charAt(i); 
          if (commaCounter==3) sa += _s.charAt(i);
        }
      }
    }

    if (sr!="" && sg=="" && sb=="" && sa=="") {
      r = int(sr);
      endColor = color(r);
    }
    if (sr!="" && sg!="" && sb=="" && sa=="") {
      r = int(sr);
      g = int(sg);
      endColor = color(r, g);
    }
    if (sr!="" && sg!="" && sb!="" && sa=="") {
      r = int(sr);
      g = int(sg);
      b = int(sb);
      endColor = color(r, g, b);
    }
    if (sr!="" && sg!="" && sb!="" && sa!="") {
      r = int(sr);
      g = int(sg);
      b = int(sb);
      a = int(sa);
      endColor = color(r, g, b, a);
    }
    return endColor;
  }
}

