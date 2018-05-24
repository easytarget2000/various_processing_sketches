/**
 * Constants
 */

private static final int POINTS_PER_ROTATION = 1024;

private static final float SHAPE_TO_WINDOW_SIZE_RATIO = 0.33f;

/**
 * Values
 */

private Alga[] algae;

void setup() {
  //size(1080, 1080, P3D);
  fullScreen(P3D);
  smooth();
  noiseDetail(8, 0.1f);
  colorMode(HSB, 1f);
  //frame.setUndecorated(true)

  initAlgae();
}

void draw() {
  background(0);
  drawAndUpdateAlgae();
}

private void initAlgae() {
  algae = new Alga[4];

  final float shapeUpperBound;
  shapeUpperBound = min(width, height) * SHAPE_TO_WINDOW_SIZE_RATIO;

  for (int i = 0; i < algae.length; i++) {
    final PVector velocity = new PVector(0f, 0f, 8f);

    final PVector center = new PVector(
      width / 2f, 
      height / 2f, 
      128f * i
      );

    final long randomSeed = (long) random(1024f);
    final float hue = random(1f);
    final int numOfZRotations = 4;
    
    algae[i] = new Alga(
      center, 
      velocity, 
      shapeUpperBound, 
      randomSeed, 
      hue, 
      numOfZRotations
      );
  }
}

private void drawAndUpdateAlgae() {
  for (int i = 0; i < algae.length; i++) {
    algae[i].drawAndUpdate();
  }
}
