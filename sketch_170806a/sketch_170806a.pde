/**
 * Constants
 */

/**
 * Values
 */

private Walker[] walkers;

private Border[] borders;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  // fullScreen();
   fullScreen(2);
  background(0);

  noFill();
  stroke(0x30FFFFFF);

  walkers = new Walker[1024];
  for (int i = 0; i < walkers.length; i++) {
    walkers[i] = new Walker(width / 2f, random(height), 64f);
  }

  borders = new Border[8];
  for (int i = 0; i < borders.length; i++) {
    borders[i] = new Border(random(width / 2f), random(height /2f), random(width), random(height));
  }
}

void draw() {
  //background(0);

  for (final Walker walker : walkers) {
    walker.update(borders);
    walker.drawConfigured();
  }
}

public class Walker {

  private float x;

  private float y;

  private float maxJitter;

  private float maxJitterHalf;

  private Walker(final float x, final float y, final float maxJitter) {
    this.x = x;
    this.y = y;

    setMaxJitter(maxJitter);
  }

  public void setMaxJitter(final float maxJitter) {
    this.maxJitter = maxJitter;
    this.maxJitterHalf = this.maxJitter / 2f;
  }

  public void update(final Border borders[]) {
    float newX = x + getJitter();
    float newY = y + getJitter();

    if (newX < 0) {
      newX = 0;
    } else if (newX > width) {
      newX = width;
    } else if (newY < 0) {
      newY = 0;
    } else if (newY > height) {
      newY = height;
    }

    for (final Border border : borders) {
      final float lastSide = border.getSide(x, y);
      final float newSide = border.getSide(newX, newY);
      if ((lastSide < 0 && newSide > 0) || (lastSide > 0 && newSide < 0)) {
        return;
      }
    }

    x = newX;
    y = newY;
  }

  public void drawConfigured() {
    point(x, y);
  }

  private float getJitter() {
    return maxJitterHalf - random(maxJitter);
  }
}

public class Border {

  private float startX;

  private float startY;

  private float endX;

  private float endY;

  public Border(
    final float startX, 
    final float startY, 
    final float endX, 
    final float endY
    ) {
    this.startX = startX;
    this.startY = startY;
    this.endX = endX;
    this.endY = endY;
  }

  public float getSide(final float pointX, final float pointY) {
    return ((endX - startX) * (pointY - startY))
      - ((pointX - startX) * (endY - startY));
  }
}