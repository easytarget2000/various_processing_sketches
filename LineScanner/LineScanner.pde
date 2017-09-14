/**
 * Constants
 */

/**
 * Values
 */

private Conductor conductor = new Conductor(108f);

private float speed = 1f;

private float lineY = 0f;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);

  setRandomSpeed();

  background(0);
  
  noFill();
  stroke(0xFFFF00FF);
}

void draw() {
  background(0);
  
  line(0, lineY, width, lineY);
  
  lineY += speed;
  if (lineY > height) {
    lineY = 0;
  }
 
 if (conductor.isBeatDue(1f)) {
   
 }
}

private void setRandomSpeed() {
  speed = 2f + random(height / 128f);
}