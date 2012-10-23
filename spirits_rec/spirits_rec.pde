import controlP5.*;
import processing.opengl.*;
import codeanticode.glgraphics.*;
import deadpixel.keystone.*;
import codeanticode.gsvideo.*;

GSMovie movie;
int newFrame = 0;

// this object is key! you can use it to render fully accelerated
// OpenGL scenes directly to a texture
GLGraphicsOffScreen offscreen;
Keystone ks;
CornerPinSurface surface;

ControlP5 cp5;
Textlabel modeLabel;
Textlabel dataLabel;
Slider timeline;

GLTexture tex;

int circleSize = 50;
int playbackIndex = 0;

int mode = 0; // 0 = IDLE
              // 1 = RECORDING
              // 2 = PLAYBACK
              // 3 = STEP


// theatre stage ratio;
// SWAN:
//int stageWidth = 2200;
//int stageHeight = 2800;

// RST:
int stageWidth = 2600;
int stageHeight = 3700;

Recording r;

void setup() {
  size(1280, 720, GLConstants.GLGRAPHICS);

  offscreen = new GLGraphicsOffScreen(this, stageWidth, stageHeight);

  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(stageWidth, stageHeight, 20);

  r = new Recording();
  cp5 = new ControlP5(this);
  setupUI();

  movie = new GSMovie(this, "comedy.mov");
  tex = new GLTexture(this);
  movie.setPixelDest(tex);

  movie.play();
  movie.goToBeginning();
  movie.pause();
  movie.frameRate(30);
  frameRate(30);

}

void draw() {
  // convert 
  PVector mouse = surface.getTransformedMouse();
  background(0);

  // draw the background
  switch(mode) {
    case 0: // idle
      movie.read();
      if (tex.putPixelsIntoTexture()) {
        image(tex, 0, 0, width, height);
      }
      break;
    case 1: // recording
      if (tex.putPixelsIntoTexture()) {
        image(tex, 0, 0, width, height);
      }
      break;
    case 2: // playback
      if (tex.putPixelsIntoTexture()) {
        image(tex, 0, 0, width, height);
      }
      break;
    case 3: // step
      movie.play();
      movie.jump(playbackIndex);
      movie.pause();
      movie.read();
      if (tex.putPixelsIntoTexture()) {
        image(tex, 0, 0, width, height);
      }
      break;
  }

  // first draw the sketch offscreen
  offscreen.beginDraw();
  offscreen.fill(255);
  noStroke();

  if(r.eventsLength() > 0) {
    dataLabel.setText(str(r.eventsLength()) + " events");
  } else {
    dataLabel.setText("");
  }

  switch(mode) {
    case 0: // idle
      timeline.hide();
      modeLabel.setText("");
    break;
    case 1: // recording
      if(mousePressed) {
        offscreen.fill(0,128,0);
      } else {
        offscreen.fill(128,0,0);
      }

      offscreen.clear(0,0);
      offscreen.ellipse(int(mouse.x),int(mouse.y),circleSize,circleSize);

      modeLabel.setText("Recording");

      if(mousePressed) {
        int[] coords = { int(mouse.x), int(mouse.y) };
        if((mouse.x >= 0) && (mouse.x < stageWidth) && (mouse.y >= 0) && (mouse.y < stageHeight)) {
          r.addEvent(coords);
          println("Adding " + coords[0] + ", " + coords[1]);
        } else {
          println("Out of bounds; not adding " + coords[0] + ", " + coords[1]);
        }
      } else {
        //println("Adding null");
        int[] coords = {99999,99999};
        r.addEvent(coords);
      }
    break;
    case 2: // playback
      timeline.show();
      if(playbackIndex == 0) {
        timeline.setRange(0, r.eventsLength()-1);
      }

      offscreen.fill(255);
      modeLabel.setText("Playback");

      offscreen.fill(0,0,128);

      timeline.setValue(playbackIndex);

      if(movie.isPlaying() && r.eventsLength() > 0 && playbackIndex < r.eventsLength()) {
        int[] event = r.getEvent(playbackIndex);
        offscreen.clear(0,0);
        offscreen.ellipse(event[0], event[1], circleSize, circleSize);
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
        offscreen.clear(0,0);
        offscreen.ellipse(event[0], event[1], circleSize, circleSize);
      } else {
        playbackIndex = 0;
      }
    break;
  }
  offscreen.endDraw();
  surface.render(offscreen.getTexture());

  if(mode==1 && !movie.isPlaying() && movie.frame() > 0) {
    println("Stop recording");
    mode = 0;
    if(r.eventsLength() > 0) {
      r.trimEvents();
      println("Trimming");
    }
  }
}

void movieEvent(GSMovie movie) {
  movie.read();
}
