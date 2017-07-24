/**
 * Constants
 */

private static final int MAX_PEAKS = 256;

/**
 * Values
 */

private ArrayList<Vertex> vertexTreeTops;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
  background(0);

  initVertices();
  noFill();
  setColor();
}

void draw() {
  //background(0);

  int connectionCounter = 0;
  for (final Vertex treeTopVertex : vertexTreeTops) {
    connectionCounter += treeTopVertex.drawConnectionsAndUpdate(connectionCounter);
  }
  
  println("draw(): connectionCounter: " + connectionCounter);

  if (millis() % 22 == 0) {
    setColor();
    addTreeTopVertex();
  }
}

private void initVertices() {
  vertexTreeTops = new ArrayList<Vertex>();
  addTreeTopVertex();
}

private void addTreeTopVertex() {
  final float firstVertexXPos = random(width);
  final float firstVertexYPos = random(height);

  //final Vertex secondVertex = new Vertex(
  //  new Vertex[0], 
  //  firstVertexXPos + 10f, 
  //  firstVertexYPos + 10f
  //  );
  //connectedVertices[0] = secondVertex;

  final Vertex firstVertex = new Vertex(firstVertexXPos, firstVertexYPos);
  vertexTreeTops.add(firstVertex);
}

private void setColor() {
  if (getBrightness() > 0.1f) {
    stroke(0x20000000);
  } else {
    stroke(getRandomColor());
  }
}

private float getBrightness() {
  int pointCounter = 0;
  float brightnessSum = 0;
  for (int x = width / 20; x < width; x += width / 20) {
    for (int y = height / 20; y < height; y += height / 20) {
      brightnessSum += brightness(get(x, y)) / 255f;
      //println("rgb: " + get(x, y) + " brightness: " + brightness(get(x, y)));
      ++pointCounter;
    }
  }
  //final float brightness = brightnessSum / (float) pointCounter;
  //println("Brightness: " + brightness);
  //return brightness;
  return brightnessSum / (float) pointCounter;
}

private color getRandomColor() {
  if (millis() % 10 != 0) {
    final int brightness = 100 + (int) random(155);
    return color(
      brightness, 
      brightness, 
      brightness, 
      32
      );
  } else {
    return color(
      (int) 100 + random(155), 
      (int) 100 + random(155), 
      (int) 100 + random(155), 
      32
      );
  }
}