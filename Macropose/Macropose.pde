/**
 * Constants
 */

/**
 * Values
 */

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
  background(0);
      frameRate(60f);

}

void draw() {
  background(0);
  //noStroke();

  final float widthHalf = width / 2f;
  final float heightHalf = height / 2f;

  for (float a = 0f; a < 1f; a += 0.05f) {
    for (float b = 0f; b < 6f; b += 0.1f) {
      final float d = b / 2f + millis() / 3000f;
      point(
        widthHalf + 256f * cos(d) + 128f * cos(a + d), 
        heightHalf + 256f * sin(d) + 1f * sin(a + d)
        );

      stroke(0xFF881888);

      point(
        widthHalf + 128f * cos(d) + 1024f * cos(a + d), 
        heightHalf + 128f * sin(d) + 4f * sin(a + d)
        );
        
      stroke(0xFFFFFFFF);
    }
  }
}
