class Vertex {

  private ArrayList<Vertex> connectedVertices;

  private float x;

  private float y;

  private float poolLeftBound;

  private float poolRightBound;

  private float poolUpperBound;

  private float poolBottomBound;

  private float poolShrinkXVelocity;

  private float poolShrinkYVelocity;

  Vertex(final float x, final float y) {
    this.connectedVertices = new ArrayList<Vertex>();

    this.x = x;
    this.y = y;
    poolLeftBound = 0f;
    poolRightBound = width;
    poolUpperBound = 0f;
    poolBottomBound = height;
    //poolShrinkXVelocity = 10f + random(1f) * 0f * 0f * 0f;
    //poolShrinkYVelocity = random(1f) * poolShrinkXVelocity;
  }

  @Override
    String toString() {
    return "[" + super.toString() + " - " + x * y + " - x: " + x + ", y: " + y + "]";
  }

  ArrayList<Vertex> getConnectedVertices() {
    return connectedVertices;
  }

  int drawConnectionsAndUpdate(int connectionCounter) {

    //ellipse(x, y, 8f, 8f);
    ++connectionCounter;

    for (final Vertex connectedVertex : connectedVertices) {
      connectionCounter += connectedVertex.drawConnectionsAndUpdate(connectionCounter);
      drawConnectionToVertex(connectedVertex);
    }

    //for (int i = 0; i < 8; i++) {
    x += getJitter();
    y += getJitter();
    //}

    //ellipse(x, y, 20f, 20f);

    poolLeftBound += poolShrinkXVelocity;
    poolRightBound -= poolShrinkXVelocity;
    poolUpperBound +=  poolShrinkYVelocity;
    poolBottomBound -=  poolShrinkYVelocity;

    if (x < poolLeftBound) {
      x = poolLeftBound;
    } else if (x > poolRightBound) {
      x = poolRightBound;
    }

    if (y < poolUpperBound) {
      y = poolUpperBound;
    } else if (y > poolBottomBound) {
      y = poolBottomBound;
    }

    if (poolLeftBound >= poolRightBound - poolShrinkXVelocity) {
      poolShrinkXVelocity = -poolShrinkXVelocity;
    }
    if (poolUpperBound >= poolBottomBound) {
      poolShrinkYVelocity = -poolShrinkYVelocity;
    }

    final int numOfConnectedVertices = connectedVertices.size();

    if (connectionCounter < 2 && numOfConnectedVertices < 2 && millis() % 33 == 0) {
      addConnectedVertex();
    } else if (millis() % 44 == 0 && numOfConnectedVertices > 2) {
      final int randomVertexIndex = (int) random(numOfConnectedVertices - 1f);
      connectedVertices.remove(randomVertexIndex);
    }

    return connectionCounter;
  }

  void drawConnectionToVertex(final Vertex nextVertex) {
    line(x, y, nextVertex.x, nextVertex.y);
  }

  void addConnectedVertex() {
    //final Vertex[] newConnectedVertices = new Vertex[connectedVertices.length + 1];
    //for (int i = 0; i < newConnectedVertices.length; i++) {
    //  if (i < newConnectedVertices.length - 1) {
    //    newConnectedVertices[i] = connectedVertices[i];
    //  } else {
    //    newConnectedVertices[i] = 
    //  }
    //}

    //connectedVertices = newConnectedVertices;
    connectedVertices.add(
      new Vertex(x + (getJitter() * 128f), y + (getJitter() * 128f))
      );
  }

  //private void drawConnections() {
  //  Peak currentPeak = nextPeak;
  //  //Peak closestPeak = null;
  //  //float closestPeakDistance = x * 2f;
  //  int connectionCount = 0;
  //  while (connectionCount < 2 && currentPeak != null && currentPeak != this) {

  //    final float distanceToOtherPeak = distanceToPeak(currentPeak);
  //    if (distanceToOtherPeak < 128f) {

  //      //final float lineLength = distanceToOtherPeak * (1f - (distanceToOtherPeak / 256f));
  //      final float lineLength = distanceToOtherPeak;

  //      final float angleToOtherPeak = angleToPeak(currentPeak);
  //      for (int i = 0; i < 1; i++) {
  //        line(
  //          x, 
  //          y, 
  //          x + (cos(angleToOtherPeak) * lineLength), 
  //          y + (sin(angleToOtherPeak) * lineLength)
  //          );

  //          x += getJitter();
  //          y += getJitter();

  //          //int alpha = (int) ((float) (i + 1) / 16) * 255;
  //          //stroke(getRandomColorWithAlpha(alpha));
  //      }

  //      ++connectionCount;
  //    }

  //    currentPeak = currentPeak.nextPeak;
  //  }
  //}

  private float getJitter() {
    return 1f - random(2f);
  }

  private float distanceToVertex(final Vertex otherVertex) {
    return distance(x, y, otherVertex.x, otherVertex.y);
  }

  private float distance(
    final float x1, 
    final float y1, 
    final float x2, 
    final float y2
    ) {
    return sqrt(
      pow((x2 - x1), 2) + pow((y2 - y1), 2)
      );
  }

  private float angleToVertex(final Vertex otherVertex) {
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

  private color getRandomColorWithAlpha(final int alpha) {
    //if (millis() % 10 == 0) {
    final int brightness = 100 + (int) random(155);
    return color(
      brightness, 
      brightness, 
      brightness, 
      alpha
      );
    //} else {
    //  return color(
    //    (int) 100 + random(155), 
    //    (int) 100 + random(155), 
    //    (int) 100 + random(155), 
    //    alpha
    //    );
    //}
  }
}