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
}