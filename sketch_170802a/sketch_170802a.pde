
/**
 * Constants
 */

/**
 * Values
 */

private float angleOffset = 0f;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  //fullScreen();
  fullScreen(1);
  background(0);
}

void draw() {
  //background(0);
  if (millis() < 2000) {
    return
  }
  noFill();
  stroke(0xFFFFFFFF);

  final float centerX = width / 2f;
  final float centerY = height / 2f;
  final float radius = height / (int) (24f - angleOffset);

  angleOffset += 0.001f;

  ellipse(
    centerX + (cos(1.25f * PI + angleOffset) * radius), 
    centerY + (sin(1.25f * PI + angleOffset) * radius), 
    8f, 
    8f
    );

  ellipse(
    centerX + (cos(1.75f * PI + angleOffset) * radius), 
    centerY + (sin(1.75f * PI + angleOffset) * radius), 
    8f, 
    8f
    );

  arc(
    centerX, 
    centerY, 
    radius * 2f, 
    radius * 2f, 
    0.33f * PI + angleOffset, 
    0.67f * PI + angleOffset
    );
}