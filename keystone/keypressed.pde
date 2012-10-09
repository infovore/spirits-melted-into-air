void keyPressed() {
  switch(key) {
  case 'c':
    // enter/leave calibration mode, where surfaces can be warped 
    // & moved
    ks.toggleCalibration();
    break;
  case 'd':
    println(r.asDebugString());
    break;   
  case 'r':
    if(mode == 1) {
      println("Stop recording");
      mode = 0;
      if(r.eventsLength() > 0) {
        r.trimEvents();
        println("Trimming");
      }
    } else {
      println("Start recording");
      mode = 1;
    }
    break;
  case 'b':
    drawSwan = 1 - drawSwan;
    break;

  case '[':
    // loads the saved layout
    File f = new File(dataPath("keystone.xml"));
    if (f.exists()) {
      ks.load();
    } 
    break;

  case ']':
    // saves the layout
    ks.save();
    break;
  }
}