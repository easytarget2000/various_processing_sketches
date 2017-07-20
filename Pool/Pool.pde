/**
 * Constants
 */

private static final int MAX_PEAKS = 16;

/**
 * Values
 */

private Peak firstPeak;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
  background(0);

  firstPeak = buildPeak();
  firstPeak.nextPeak = buildPeak();
}

void draw() {
  background(0);
  stroke(0x88FFFFFF);

  Peak lastPeak = firstPeak;
  Peak currentPeak = firstPeak;
  int peakCounter = 0;
  while (currentPeak != null) {

    if (!currentPeak.updateAndDraw()) {
      lastPeak.nextPeak = null;
      lastPeak.nextPeak = buildPeak();
    } else if (++peakCounter < MAX_PEAKS && currentPeak.nextPeak == null) {
      currentPeak.nextPeak = buildPeak();
    }

    lastPeak = currentPeak;
    currentPeak = lastPeak.nextPeak;
  }
}

private Peak buildPeak() {
  return new Peak(null, random(width), random(height));
}