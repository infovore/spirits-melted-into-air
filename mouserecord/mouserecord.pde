import controlP5.*;

ControlP5 cp5;
Textlabel modeLabel;
Slider timeline;

int isRecording = 0;
int isPlaying = 0;
int isStepPlayback = 0;
int circleSize = 50;
int playbackIndex = 0;

Recording r;

void setup() {
  size(800,600);
  // frameRate(24);

  r = new Recording();

  cp5 = new ControlP5(this);
  modeLabel = cp5.addTextlabel("label")
                 .setText("")
                 .setPosition(0, height-12)
                 .setColorValue(0xffffffff);

  timeline = cp5.addSlider("playbackIndex")
   .setPosition(width-270,height-30)
   .setSize(200,20)
   .setRange(0,9999)
   .setValue(0)
   .setLabel("Playhead");
}

void draw() {
  background(0);
  noStroke();

  if(mousePressed) {
    fill(0,128,0);
  } else {
    fill(128,0,0);
  }

  if(isPlaying < 1 && isStepPlayback < 1) {
    ellipse(mouseX,mouseY,circleSize,circleSize);
  }

  if(isRecording > 0) {
    fill(255);
    modeLabel.setText("Recording");

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
    modeLabel.setText("Playback");

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

  if(isStepPlayback > 0) {
    fill(255);
    modeLabel.setText("Step");

    timeline.show();

    fill(0,0,128);

    if(playbackIndex == 0) {
      timeline.setRange(0, r.eventsLength()-1);
    }

    if(playbackIndex < r.eventsLength()) {
      int[] event = r.getEvent(playbackIndex);
      ellipse(event[0], event[1], circleSize, circleSize);
    } else {
      playbackIndex = 0;
      isPlaying = 0;
    }
  } else {
    timeline.hide();
  }

  if(isPlaying < 1 && isRecording < 1 && isStepPlayback < 1) {
    modeLabel.setText("");
  }
}