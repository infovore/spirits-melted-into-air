int isRecording = 0;
int isPlaying = 0;
int circleSize = 50;
int playbackIndex = 0;

Recording r;

void setup() {
  size(640,480);
  // frameRate(24);

  r = new Recording();
}

void draw() {
  background(0);
  noStroke();
  if(mousePressed) {
    fill(0,128,0);
  } else {
    fill(128,0,0);
  }

  if(isPlaying < 1) {
    ellipse(mouseX,mouseY,circleSize,circleSize);
  }

  if(isRecording > 0) {
    fill(255);
    text("Recording", 0, height-2);

    if(mousePressed) {
      int[] coords = { mouseX, mouseY };
      r.addEvent(coords);
      println("Adding " + coords[0] + ", " + coords[1]);
    } else {
      println("Adding null");
      int[] coords = {99999,99999};
      r.addEvent(coords);
    }
  }

  if(isPlaying > 0) {
    fill(255);
    text("Playback", 0, height-2);
    fill(0,0,128);

    if(playbackIndex < r.eventsLength()) {
      int[] event = r.getEvent(playbackIndex);
      ellipse(event[0], event[1], circleSize, circleSize);
      playbackIndex++;
    } else {
      playbackIndex = 0;
      isPlaying = 0;
    }
  }
}

void keyPressed() {
  if(key=='r') {
    if(isRecording > 0) {
      println("Stop recording");
      isRecording = 0;
    } else {
      println("Start recording");
      isRecording = 1;
      isPlaying = 0;
    }
  }

  if(key=='s') {
    println(r.asString());
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
}