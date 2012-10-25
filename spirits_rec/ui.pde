void setupUI() {
  modeLabel = cp5.addTextlabel("label")
                 .setText("")
                 .setPosition(0, height-10)
                 .setColorValue(0xffffffff);

  dataLabel = cp5.addTextlabel("dataLabel")
                 .setText("")
                 .setPosition(width-80, height-10)
                 .setColorValue(0xffffffff);

  timeline = cp5.addSlider("playbackIndexController")
   .setPosition(width-270, 10)
   .setSize(200,20)
   .setRange(0,9999)
   .setValue(0)
   .setLabel("Playhead");

  cp5.addButton("playEvents")
     .setPosition(0+10, 10)
     .setSize(30,30)
     .setLabel("play");

   cp5.addButton("stepEvents")
     .setPosition(0+50, 10)
     .setSize(30,30)
     .setLabel("step");

  cp5.addButton("clearEvents")
   .setPosition(0+90, 10)
   .setSize(30,30)
   .setLabel("clear");

  cp5.addButton("saveEvents")
     .setPosition(0+130,10)
     .setSize(30,30)
     .setLabel("save");

  cp5.addButton("loadEvents")
     .setPosition(0+170,10)
     .setSize(30,30)
     .setLabel("load");
}

public void playEvents() {
  println("Mode is " + mode);
  if(mode == 2) {
    mode = 0;
    println("Mode is now " + mode);
    println("PAUSE MOVIE");
    movie.pause();
  } else {
    mode = 2;
    playbackIndex = 0;
    movie.goToBeginning();
    movie.play();
    println("PLAY MOVIE");
    println("Mode is now " + mode);
  }
}

public void stepEvents() {
  if(mode == 3) {
    mode = 0;
  } else {
    mode = 3;
  }
}

public void clearEvents() {
  modeLabel.setText("CLEARING");
  r = new Recording();
}

public void saveEvents() {
  modeLabel.setText("SAVING");
  String savePath = selectOutput();  // Opens file chooser
  if (savePath == null) {
    // If a file was not selected
    println("No file was selected...");
  } else {
    // If a file was selected, print path to file
    r.saveToFile(savePath);
    modeLabel.setText("SAVED");
  }
}

public void loadEvents() {
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


public void playbackIndexController(float val) {
  if(mode == 3) {
    playbackIndex = int(val);
  }
}
