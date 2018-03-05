/**
 * Constants
 */

/**
 * Values
 */

private PVector position;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  fullScreen(P3D);
  // fullScreen(2);
  background(0);

  position = new PVector(width / 2f, height / 2f, 0f);
}

void draw() {
  //background(0);

  final float magnitude = 64f;

  stroke(0xFFFFFFFF);

  for (int i = 0; i < 128; i++) {
    final PVector normalizedMovement = new PVector(
      getRandomSign(), 
      getRandomSign(), 
      getRandomSign()
      );
    final PVector movement = normalizedMovement.setMag(magnitude);
    final PVector newPosition = PVector.add(position, movement);

    line(
      position.x, position.y, position.z, 
      newPosition.x, newPosition.y, newPosition.z
      );

    position = newPosition;
  }
}

/*
 * Implementation
 */

private float getRandomSign() {
  return random(1f) > 0.5f ? 1f : -1f;
}