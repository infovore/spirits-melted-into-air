import controlP5.*;

ControlP5 cp5;
Textlabel modeLabel;
Textfield filenameInput;
Slider timeline;

int circleSize = 50;
int playbackIndex = 0;

int mode = 0; // 0 = IDLE
              // 1 = RECORDING
              // 2 = PLAYBACK
              // 3 = STEP

Recording r;

void setup() {
  size(800,600);
  // frameRate(24);

  r = new Recording();

  cp5 = new ControlP5(this);

  setupUI();
}

void draw() {
  background(0);
  noStroke();


  switch(mode) {
    case 0: // idle
      timeline.hide();
      modeLabel.setText("");
    break;
    case 1: // recording
      if(mousePressed) {
        fill(0,128,0);
      } else {
        fill(128,0,0);
      }

      ellipse(mouseX,mouseY,circleSize,circleSize);

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
    break;
    case 2: // playback
      timeline.show();
      println("Playbackindex is " + str(playbackIndex));
      println("Eventslength is " + str(r.eventsLength()));
      if(playbackIndex == 0) {
        timeline.setRange(0, r.eventsLength()-1);
      }

      fill(255);
      modeLabel.setText("Playback");

      fill(0,0,128);

      timeline.setValue(playbackIndex);

      if(playbackIndex < r.eventsLength()) {
        int[] event = r.getEvent(playbackIndex);
        ellipse(event[0], event[1], circleSize, circleSize);
        playbackIndex++;
        println("Playback index has changed to " + playbackIndex);
      } else {
        playbackIndex = 0;
        mode = 0;
      }
    break;
    case 3: // step playback
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
      }
    break;
  }
}