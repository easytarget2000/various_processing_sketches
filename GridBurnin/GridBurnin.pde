/*
Constants
 */

/*
Variables
 */

private float hue = 0f;

/*
Lifecycle
 */

void setup() {
  //size(800, 600);
  fullScreen(P3D);
  colorMode(HSB, 1f);
  background(0);
    frameRate(60f);

}

void draw() {
  clearScreen();  
  setHue();
  drawGrid();
  manipulatePixels();
}

/*
Implementations
 */

private void clearScreen() {
  background(0);

  //noStroke();
  //fill(0f, 0f, 0f, 0.1f);
  //rect(0f, 0f, width, height);
}

private void setHue() {
  if ((hue += 0.01f) > 1f) {
    hue = 0f;
  }
}

private void drawGrid() {
  noFill();
  //stroke(0f, 0f, 1f, 1f);

  final float numberOfSteps = map((float) mouseX, 0f, (float) width, 64f, 256f); 
  final float stepSize = max(width, height) / numberOfSteps;
  final float stepSizeHalf = stepSize / 2f;

  final float angleOffset = PI * ((float) mouseX / width);

  for (float column = 0; column < width; column += stepSize) {
    for (float row = 0; row < height; row += stepSize) {
      final float angle = PI + angleOffset;
      stroke(hue, noise(column, row), 1f, 1f);
      line(
        column + stepSizeHalf - (cos(angle) * stepSizeHalf), 
        row + stepSizeHalf - (sin(angle) * stepSizeHalf), 
        column + stepSizeHalf + (cos(angle) * stepSizeHalf), 
        row + stepSizeHalf + (sin(angle) * stepSizeHalf)
        );
    }
  }
}

private void manipulatePixels() {
  int cellsize = 2; // Dimensions of each cell in the grid
  int cols, rows;
  cols = width/cellsize;             // Calculate # of columns
  rows = height/cellsize;            // Calculate # of rows
  
  loadPixels();
  // Begin loop for columns
  for ( int i = 0; i < cols; i++) {
    // Begin loop for rows
    for ( int j = 0; j < rows; j++) {
      int x = i*cellsize + cellsize/2; // x position
      int y = j*cellsize + cellsize/2; // y position
      int loc = x + y*width;           // Pixel array location
      color c = pixels[loc];       // Grab the color
      // Calculate a z position as a function of mouseX and pixel brightness
      float z = (mouseX/(float)width) * brightness(pixels[loc]) - 100.0;
      // Translate to the location, set fill and stroke, and draw the rect
      pushMatrix();
      translate(x, y, z);
      fill(c);
      noStroke();
      rectMode(CENTER);
      rect(0, 0, cellsize, cellsize);
      popMatrix();
    }
  }
  updatePixels();
}
