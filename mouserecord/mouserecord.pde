int isRecording = 0;
int circleSize = 50;

void setup() {
  size(640,480);
  frameRate(24);
}

void draw() {
  background(0);
  noStroke();
  if(mousePressed) {
    fill(0,128,0);
  } else {
    fill(128,0,0);
  }

  ellipse(mouseX,mouseY,circleSize,circleSize);
}

void keyPressed() {
  if(key=='r') {
    if(isRecording > 0) {
      println("Stop recording");
      isRecording = 0;
    } else {
      println("Start recording");
      isRecording = 1;
    }
  }
}