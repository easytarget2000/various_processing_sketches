/*
Constants
 */

/*
Variables
 */

private int numOfWanderersToInit = 1024;

private ArrayList<Wanderer> wanderers;

/*
Lifecycle
 */

void setup() {
  size(800, 600);
  //fullScreen();
  // size(1024, 1024, P3D);
  // fullScreen(P3D);
  colorMode(HSB, 1f);

  clearScreen();
  setWanderers();
}

void draw() {
  //fadeClearScreen();
  updateAndDrawWanderers();
}

/*
Implementations
 */

private void clearScreen() {
  background(0);
}

private void setWanderers() {
  wanderers = new ArrayList<Wanderer>();
  for (int i = 0; i < numOfWanderersToInit; i++) {
    final PVector position = new PVector(random(width), random(height));
    final Wanderer wanderer = new Wanderer(position);
    wanderers.add(wanderer);
  }
}

private void fadeClearScreen() {
  noStroke();
  fill(0f, 0f, 0f, 0.1f);
  rect(0f, 0f, width, height);
}

private void updateAndDrawWanderers() {
  final PVector focusVector = new PVector(width / 2f, height / 2f);
  final float minFocusVectorDistance = 256f;
  final float maxFocusVectorDistance = 264f;
  for (final Wanderer wanderer : wanderers) {
    wanderer.updateAndDraw(focusVector, minFocusVectorDistance, maxFocusVectorDistance);
  }
}
