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
    }
  }

  if(key=='d') {
    println(r.asDebugString());
  }

  if(key=='t') {
    r.trimEvents();
    println("Trimming");
  }

  if(key=='p') {
    if(isPlaying > 0) {
      isPlaying = 0;
    } else {
      isRecording = 0;
      isPlaying = 1;
    }
  }

  if(key=='c') {
    println("Clearing recording");
    r = new Recording();
  }

  if(key=='[') {
    println("Saving to file");
    r.saveToFile();
  }

  if(key==']') {
    println("Load file");
    r.loadFromFile();
  }
}