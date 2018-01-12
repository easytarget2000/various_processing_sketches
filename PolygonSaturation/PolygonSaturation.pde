/**
 * Constants
 */

/**
 * Values
 */

private ArrayList<Vertex> vertices = new ArrayList<Vertex>();

private ArrayList<Polygon> polygons = new ArrayList<Polygon>();

private float polygonRadius;

/**
 * Lifecycle
 */

void setup() {
  size(1920, 1080);
  // fullScreen();
  // fullScreen(2);
  background(0);
  initVertices();
}

void draw() {
  background(0);
  noFill();
  stroke(0xFFFFFFFF);
  for (final Polygon polygon : polygons) {
    polygon.drawAndUpdate();
  }
  
  for (final Vertex vertex : vertices) {
    vertex.update();
  }
}

void keyPressed() {
  addPolygon();
}

/**
 * Implementations
 */

private void initVertices() {
  final float centerX = width / 2f;
  final float centerY = height / 2f;
  polygonRadius = width / 64f;

  final Vertex[] newVertices = new Vertex[3];
  for (int i = 0; i < 3; i++) {
    final float vertexAngle = (TWO_PI / 3f) * (i + 1);
    final float vertexX = centerX + (cos(vertexAngle) * polygonRadius);
    final float vertexY = centerY + (sin(vertexAngle) * polygonRadius);

    final Vertex vertex = new Vertex(vertexX, vertexY);
    vertices.add(vertex);
    newVertices[i] = vertex;
  }

  final Polygon polygon = new Polygon(newVertices);
  polygons.add(polygon);
}

private void addPolygon() {
  final int lastVertexIndex = vertices.size() - 1;

  final Vertex[] lastVertices = new Vertex[] {
    vertices.get(lastVertexIndex), 
    vertices.get(lastVertexIndex - 1)
  };

  final Vertex[] newVertices = new Vertex[3];
  newVertices[0] = lastVertices[0];
  newVertices[1] = lastVertices[1];

  final Vertex newVertex = new Vertex(lastVertices);
  vertices.add(newVertex);
  newVertices[2] = newVertex;

  final Polygon polygon = new Polygon(newVertices);
  polygons.add(polygon);
}