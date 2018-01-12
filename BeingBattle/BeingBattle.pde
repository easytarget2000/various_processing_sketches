/**
 * Constants
 */

private int NUM_OF_TRAJECTORIES = 32;

/**
 * Values
 */

private float clearScreenProbability;

private ArrayList<Trajectory> trajectories;

private ArrayList<Being> beings;

private color lastBeingColor;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  // fullScreen();
  fullScreen(2);


  background(0);

  clearScreenProbability = 0.08f;
  initTrajectories();
  beings = new ArrayList<Being>();
}

void draw() {

  if (random(1f) < clearScreenProbability) {
    background(getRandomColor());
  }
  updateTrajectories();
  updateAndDrawBeings();
}

/**
 * Implementations
 */

private void initTrajectories() {
  trajectories = new ArrayList<Trajectory>();

  for (int i = 0; i < NUM_OF_TRAJECTORIES; i++) {
    final PVector trajectoryPosition = new PVector(width / 2f, height / 2f);
    addTrajectory(trajectoryPosition);
  }
}

private void addTrajectory(final PVector position) {
  trajectories.add(new Trajectory(position));
}

private void addBeing(final PVector position) {
  final color beingColor;// = getRandomColor();
  if (lastBeingColor == 0xFFFFFFFF) {
    beingColor = 0xFF000000;
  } else {
    beingColor = 0xFFFFFFFF;
  }
  final Being newBeing = new Being(position, beingColor);
  beings.add(newBeing);
  lastBeingColor = beingColor;
}

private void updateTrajectories() {
  for (final Trajectory currentTrajectory : trajectories) {
    final boolean dropBeing = currentTrajectory.updateAndDropBeing();

    if (dropBeing) {
      addBeing(currentTrajectory.getPosition());
    }
  }
}

private void updateAndDrawBeings() {
  for (int beingIndex = 0; beingIndex < beings.size(); beingIndex++) {
    final Being currentBeing = beings.get(beingIndex);

    final boolean beingIsAlive = currentBeing.updateAndDraw();
    if (!beingIsAlive) {
      beings.remove(beingIndex);
    }
  }
}

private color getRandomColor() {
  return getRandomColor(0xFF);
}

private color getRandomColor(final int alpha) {
  return color(
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    alpha
    );
}