/*
Constants
 */

/*
Variables
 */

private ArrayList<PolygonDriver> polygonDrivers;

/*
Lifecycle
 */

void setup() {
  //size(800, 600);
  fullScreen();
  // size(1024, 1024, P3D);
  // fullScreen(P3D);
  colorMode(HSB, 1f);
  smooth();
  initPolygonDriversEmpty();
}

void draw() {
  clearScreen();
  updateAndDrawPolygonDrivers();
}

void mousePressed() {
  final PVector mousePosition = new PVector(mouseX, mouseY, 0f);
  addPolygon(mousePosition);
}

/*
Implementations
 */

private void clearScreen() {
  background(0);

  //noStroke();
  //fill(0f, 0f, 0f, 0.1f);
  //rect(0f, 0f, width, height);
}

private void initPolygonDriversEmpty() {
  polygonDrivers = new ArrayList<PolygonDriver>();
}

private void addPolygon(final PVector position) {
  final float maxVelocity = min(width, height) / 256f;
  final PVector velocity = new PVector(
    (maxVelocity / 2f) - random(maxVelocity), 
    (maxVelocity / 2f) - random(maxVelocity), 
    0f
    );
  final float angularVelocity = PI * random(0.001f);
  final float maxJitter = maxVelocity / 16f;
  final PolygonDriver polygonDriver = new PolygonDriver(
    buildShape(position), 
    velocity, 
    angularVelocity, 
    maxJitter
    );
  polygonDrivers.add(polygonDriver);
}

private PShape buildShape(final PVector position) {
  final float shapeX1 = 0f;
  final float shapeY1 = 0f;
  final float shapeX2 = 256f;
  final float shapeY2 = 16f;
  final float shapeX3 = 320f;
  final float shapeY3 = 280f;
  final PShape shape = createShape(
    TRIANGLE, 
    shapeX1, 
    shapeY1, 
    shapeX2, 
    shapeY2, 
    shapeX3, 
    shapeY3
    );
  shape.translate(position.x, position.y);
  shape.setFill(0xFFFFFFFF);
  shape.setStroke(0xFF000000);
  shape.rotate(random(TWO_PI));
  return shape;
}

private void updateAndDrawPolygonDrivers() {
  strokeWeight(8f);
  for (int driverIndex = 0; driverIndex < polygonDrivers.size(); driverIndex++) {
    final PolygonDriver currentDriver = polygonDrivers.get(driverIndex);
    currentDriver.updateAndDraw();
  }
}
