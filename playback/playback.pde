import org.philhosoft.processing.svg.PGraphicsSVG;

String[] lines;
int[][] coords;
int index = 0;
int skipValue = 20;

// set up stagewidth
// SWAN
//int stageWidth = 2200;
//int stageHeight = 2800;

// RST:
int stageWidth = 2600;
int stageHeight = 3700;

void setup() {
  size(stageWidth, stageHeight, PGraphicsSVG.SVG,"adriana-scaled.svg");
  smooth();
  lines = loadStrings("adriana.txt");

  coords = new int[lines.length][2];
  for (int i = 0; i < lines.length; i++) {
    String[] elems = split(lines[i], ",");
    println(elems);
    coords[i][0] = int(elems[0]);
    coords[i][1] = int(elems[1]);
  }
  frameRate(25);
  background(255);
  stroke(0);
  strokeWeight(1);
}

void draw() {
  // if(index < coords.length) {
    // ellipse(coords[index][0], coords[index][1], 10,10);
  noFill();
  beginShape();
  for (int i = 0; i < coords.length; i++) {
    if(i % skipValue == 0) {
      index = i;
      // scaleStroke(coords[index][0], coords[index][1], coords[index+1][0], coords[index+1][1]);
      // line(coords[index][0], coords[index][1], coords[index+1][0], coords[index+1][1]);
      // skip out of grid moments
      if(coords[index][0]!= 99999) {
        vertex(coords[index][0], coords[index][1]);
      }
    }
  }
  endShape();
  exit();
}

void scaleStroke(int x, int y, int nx, int ny) {
  int deltaX = abs(nx-x);
  int deltaY = abs(ny-y);

  if(deltaX > 25 || deltaY > 25) {
    strokeWeight(1);
  } else {
    if(deltaX > deltaY) {
      strokeWeight(25 - deltaX);
    } else if(deltaY > deltaX) {
      strokeWeight(25 - deltaY);
    }
  }
}
