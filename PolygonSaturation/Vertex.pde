public class Vertex {

  //private int id;

  private float x;

  private float y;

  private float maxJitter = 0f;

  private float maxJitterHalf = 0f;

  public Vertex(final float x, final float y) {
    //this.id = id;
    this.x = x;
    this.y = y;
    setMaxJitter(width / 256f);
  }

  public Vertex(final Vertex[] otherVertices) {
    final float s = 1/sqrt(PI);
    x = otherVertices[1].x + s * (otherVertices[1].y - otherVertices[0].y);
    y = otherVertices[1].y + s * (otherVertices[0].x - otherVertices[1].x);
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public void update() {
    x += getJitter();
    y += getJitter();
  }

  public float angle(final Vertex otherVertex) {
    return angle(x, y, otherVertex.x, otherVertex.y);
  }

  private float angle(
    final float x1, 
    final float y1, 
    final float x2, 
    final float y2
    ) {
    final float calcAngle = atan2(
      -(y1 - y2), 
      x2 - x1
      );

    if (calcAngle < 0) {
      return calcAngle + TWO_PI;
    } else {
      return calcAngle;
    }
  }

  private float getJitter() {
    return maxJitterHalf - random(maxJitter);
  }

  private void setMaxJitter(final float maxJitter) {
    this.maxJitter = maxJitter;
    this.maxJitterHalf = this.maxJitter / 2f;
  }
}