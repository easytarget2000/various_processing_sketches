/**
 * Constants
 */

private static final boolean DEBUG = true;

/**
 * Values
 */

private PVector cameraEye = new PVector(0f, 0f, 0f);

private PVector cameraCenter = new PVector(0f, 0f, 0f);

private ArrayList<TunnelElement> elements = new ArrayList<TunnelElement>();

private boolean clearScreen = true;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080, P3D);
  fullScreen(P3D);
  // fullScreen(2);
  colorMode(HSB, 1f);
  background(0);
  setupCamera();
    frameRate(60f);

  elements.add(buildFirstTunnelElement());
}

void draw() {
  if (clearScreen) {
    background(0);
  }

  //if (random(1f) > 0.9f) {
  //  clearScreen = !clearScreen;
  //}

  updateCamera();

  drawAndUpdateElements();
  if (random(1f) > 0.9f) {
    addTunnelElement();
  }
}

/*
 * Implementation
 */

private TunnelElement buildFirstTunnelElement() {
  final PVector position = new PVector(0f, 0f, 0f);
  final PVector velocity = new PVector(0.1f - random(0.2f), 0.1f - random(0.2f), 16f);
  final float diameter = width / 16f;
  final float hue = getRandomHue();

  return new TunnelElement(position, velocity, diameter, 4096f, hue);
}

private void addTunnelElement() {

  final TunnelElement lastElement = getLastTunnelElement();
  final TunnelElement newTunnelElement = buildNextTunnelElement(lastElement);

  elements.add(newTunnelElement);
}

private TunnelElement getLastTunnelElement() {
  final int numberOfElements = elements.size();
  return elements.get(numberOfElements - 1);
}

private TunnelElement buildNextTunnelElement(final TunnelElement previousElement) {
  final PVector nextPosition = getRandomInitPosition(previousElement.getPosition());
  final PVector nextVelocity = new PVector(0.1f - random(0.2f), 0.1f - random(0.2f), 2f);
  final float nextDiameter = previousElement.getDiameter();
  final float nextHue;
  if (random(1f) > 0.9f) {
    nextHue = getRandomHue();
  } else {
    nextHue = getNextHue(previousElement.getHue());
  }

  return new TunnelElement(
    nextPosition, 
    nextVelocity, 
    nextDiameter,
    4096f,
    nextHue
    );
}

private PVector getRandomInitPosition(final PVector originalPosition) {
  //final PVector pullVector = new PVector(
  //  originalPosition.x + (16f - random(32f)), 
  //  originalPosition.y + (16f - random(32f)), 
  //  0f
  //  );

  return originalPosition;

  //return ease(pullVector, centerPosition, 0.1f);
}

private float getRandomHue() {
  return random(1f);
}

private float getNextHue(final float previousHue) {
  final float hue = previousHue + random(0.01f);
  return hue;
}

private void drawAndUpdateElements() {
  final float alpha = clearScreen ? 1f : 0.5f;
  
  noFill();

  for (int i = 0; i < elements.size() - 1; i++) {
    final TunnelElement currentElement = elements.get(i);
    final TunnelElement nextElement = elements.get(i + 1);
    currentElement.draw_(nextElement.getPosition(), alpha);
    final boolean isOnScreen = currentElement.update();

    if (DEBUG) {
      text(String.valueOf(i), currentElement.getPosition().x, currentElement.getPosition().y, currentElement.getPosition().z);
    }

    if (!isOnScreen) {
      elements.remove(i);
    }
  }
}

private void setupCamera() {
  cameraEye = getDefaultCameraEye();
  cameraCenter = getDefaultCameraCenter();
}

private void updateCamera() {
  final TunnelElement tunnelElement = elements.get(elements.size() - 1);
  final PVector tunnelPosition = tunnelElement.getPosition();
  cameraEye = ease(cameraEye, tunnelPosition, 0.5f);
  camera(
    2048f, 0f, (height/ 2f) / tan(PI * 30f / 180f),
    //tunnelPosition.x, tunnelPosition.y, (height/ 2f) / tan(PI * 30f / 180f), 
    cameraCenter.x, cameraCenter.y, cameraCenter.z, 
    0f, 1f, 0f
    );
}

private PVector getDefaultCameraEye() {
  return new PVector(
    width / 2f, 
    height / 2f, 
    (height/ 2f) / tan(PI * 30f / 180f)
    );
}

private PVector getDefaultCameraCenter() {
  return new PVector(
    0f, 
    0f, 
    0f
    );
}

private PVector ease(final PVector originalVector, final PVector finalVector, final float factor) {
  final PVector deltaVector = PVector.sub(finalVector, originalVector);
  final PVector easedDeltaVector = PVector.mult(deltaVector, factor);
  return PVector.add(originalVector, easedDeltaVector);
}
