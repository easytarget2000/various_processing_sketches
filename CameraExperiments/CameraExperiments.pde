private PVector finalEyePosition = new PVector(
  70f, 
  35f, 
  120f
  );

private PVector eyePosition = new PVector(0f, 0f, 0f);

private PVector finalCenterPosition = new PVector(
  50f, 
  50f, 
  0f
  );

private PVector centerPosition = new PVector(0f, 0f, 0f);

void setup() {
  size(100, 100, P3D);
}

void draw() {
  noFill();
  background(204);
  
  updateCamera();
  
  translate(50, 50, 0);
  rotateX(-PI/6);
  rotateY(PI/3);
  box(45);
}

void updateCamera() {
  eyePosition = ease(eyePosition, finalEyePosition);
  centerPosition = ease(centerPosition, finalCenterPosition);
  camera(
    eyePosition.x, eyePosition.y, eyePosition.z, 
    centerPosition.x, centerPosition.y, centerPosition.z, 
    0f, 1f, 0f
    );
}

private PVector ease(final PVector originalVector, final PVector finalVector) {
  final PVector deltaVector = PVector.sub(finalVector, originalVector);
  final PVector easedDeltaVector = PVector.mult(deltaVector, 0.01f);
  return PVector.add(originalVector, easedDeltaVector);
}