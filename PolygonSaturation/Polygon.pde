public class Polygon { //<>//

  private Vertex[] vertices;

  public Polygon(final Vertex[] vertices) {
    this.vertices = vertices;
  }

  public void drawAndUpdate() {

    for (int currentVertexIndex = 0; currentVertexIndex < 3; currentVertexIndex++) {
      final int nextVertexIndex;
      if (currentVertexIndex < 2) {
        nextVertexIndex = currentVertexIndex + 1;
      } else {
        nextVertexIndex = 0;
      }

      line(
        vertices[currentVertexIndex].getX(), 
        vertices[currentVertexIndex].getY(), 
        vertices[nextVertexIndex].getX(), 
        vertices[nextVertexIndex].getY()
        );

    }
  }
}