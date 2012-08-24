void keyPressed() {
  if(key=='r') {
    if(isRecording > 0) {
      println("Stop recording");
      isRecording = 0;
      if(r.eventsLength() > 0) {
        r.trimEvents();
        println("Trimming");
      }
    } else {
      println("Start recording");
      isRecording = 1;
      isPlaying = 0;
      isStepPlayback = 0;
    }
  }

  if(key=='d') {
    println(r.asDebugString());
  }

  if(key=='p') {
    if(isPlaying > 0) {
      isPlaying = 0;
    } else {
      isRecording = 0;
      isStepPlayback = 0;
      isPlaying = 1;
    }
  }

  if(key=='s') {
    if(isStepPlayback > 0) {
      isStepPlayback = 0;
    } else {
      isRecording = 0;
      isPlaying = 0;
      isStepPlayback = 1;
    }
  }

  if(key=='c') {
    modeLabel.setText("CLEARING");
    r = new Recording();
  }

  if(key=='[') {
    modeLabel.setText("SAVING");
    r.saveToFile();
  }

  if(key==']') {
    modeLabel.setText("LOADING");
    String loadPath = selectInput();  // Opens file chooser
    if (loadPath == null) {
      // If a file was not selected
      println("No file was selected...");
    } else {
      // If a file was selected, print path to file
      r.loadFromFile(loadPath);
      modeLabel.setText("LOADED");
    }
  }
}