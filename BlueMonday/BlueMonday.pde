/**
 * Constants
 */

/**
 * Values
 */

private ArrayList<Circle> circles;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
  background(0);

  initCircles();
}

void draw() {
  background(0);

  for (final Circle currentCircle : circles) {
    currentCircle.draw_();
  }

  if (random(1f) > 0.9f) {
    initCircles();
  }
}

/*
 * Implementation
 */

private void initCircles() {  
  circles = new ArrayList<Circle>();

  final float screenSize = min(width, height);
  final float diameterStep = screenSize / 32f;

  final PVector center = new PVector(width / 2f, height / 2f);

  float circleDiameter = diameterStep / 2f;
  float circleWidth = (diameterStep / 2f) + random(diameterStep);

  do {
    final Circle newCircle = new Circle(
      center, 
      circleDiameter, 
      circleWidth, 
      0xFFFF00FF
      );
    circles.add(newCircle);

    circleDiameter += circleDiameter + random(diameterStep / 4f);
    circleWidth = random(diameterStep);
  } while (circleDiameter + circleWidth < screenSize);
}
