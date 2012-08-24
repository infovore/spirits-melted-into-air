void keyPressed() {
  if(key=='r') {
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
  }

  if(key=='d') {
    println(r.asDebugString());
  }
}