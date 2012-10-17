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

Recording r;

void setup() {
  size(1280, 720, GLConstants.GLGRAPHICS);

  offscreen = new GLGraphicsOffScreen(this, width, height);

  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(width, height, 20);

  r = new Recording();
  cp5 = new ControlP5(this);
  setupUI();

  movie = new GSMovie(this, "richout.mpg");
  tex = new GLTexture(this);
  movie.setPixelDest(tex);

  movie.play();
  movie.goToBeginning();
  movie.pause();
  movie.frameRate(25);
  frameRate(25);

}

void draw() {
  // convert 
  PVector mouse = surface.getTransformedMouse();
  background(0);

  // draw the background
  switch(mode) {
    case 0: // idle
      // image(tex,0,0);
      if (tex.putPixelsIntoTexture()) {
        image(tex, 0, 0, width, height);
      }
      break;
    case 1: // recording
      // if(indexToShow != prevIndexToShow && indexToShow < videoFilenames.length) {
      //   tex.loadTexture(dataPath("img/" + videoFilenames[indexToShow]));
      // }
      // image(tex,0,0);
      // indexToShow++;
      if (tex.putPixelsIntoTexture()) {
        image(tex, 0, 0, width, height);
      }
      break;
    case 2: // playback
      // if(indexToShow != prevIndexToShow && indexToShow < videoFilenames.length) {
      //   tex.loadTexture(dataPath("img/" + videoFilenames[indexToShow]));  
      // }
      // image(tex,0,0);
      // indexToShow++;
      if (tex.putPixelsIntoTexture()) {
        image(tex, 0, 0, width, height);
      }
      break;
    case 3: // step
      // tex.loadTexture(dataPath("img/" + videoFilenames[playbackIndex]));  
      // image(tex,0,0);
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
      // println("Playbackindex is " + str(playbackIndex));
      // println("Eventslength is " + str(r.eventsLength()));
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
      } else if(movie.isPlaying()) {
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