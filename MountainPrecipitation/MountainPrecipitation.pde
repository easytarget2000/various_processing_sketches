/**
 * Constants
 */

/**
 * Values
 */

private ArrayList<Drop> drops = new ArrayList<Drop>();

private ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  fullScreen();
  // fullScreen(2);
  background(0);
  //addObstacles();
  configurePaint();
}

private void addObstacles() {
  final int numOfNewObstacles = 512;
  float lastObstacleHeight = height / 4f;
  for (int i = 0; i < numOfNewObstacles; i++) {
    obstacles.add(
      new Obstacle(random(width), lastObstacleHeight += random(32f), 0.5f + random(4f))
      );
  }
}

void draw() {
  //background(0);

  addDrops();
  //for (int i = 0; i < 2; i++) {
    updateAndDrawDrops();
  //}
  
  if (mousePressed) {
    addObstacleCluster(mouseX, mouseY);
  }

  if (random(1f) < 0.005f) {
    background(0);
    drops = new ArrayList<Drop>();
  }

  if (random(1f) < 0.01f) {
    configurePaint();
  }
}

private void configurePaint() {
  noFill();
  stroke(getRandomColorWithAlpha(64));
}

private void addObstacleCluster(final float centerX, final float centerY) {
  final float clusterRadius = (width / 64f) * (1f + random(1f));
  final int numberOfObstacles = 32; 
  final float xStepSize = clusterRadius * 2f / numberOfObstacles;

  float y = centerY;
  for (float x = centerX - clusterRadius; x < centerX + clusterRadius; x += xStepSize) {
    y += -8f + random(16f);
    final Obstacle newObstacle = new Obstacle(x, y, 20f);
    ellipse(newObstacle.x, newObstacle.y, 3f, 3f);
    obstacles.add(newObstacle);
  }
}

private void addDrops() {
  for (int i = drops.size(); i < width * 2; i++) {
    drops.add(
      new Drop(random(width), -(height / 16f) + random(height), 0.5f + random(16f))
      );
  }
}

private void updateAndDrawDrops() {
  final Obstacle[] obstaclesArray = new Obstacle[this.obstacles.size()];
  this.obstacles.toArray(obstaclesArray);

  for (int i = 0; i < drops.size(); i++) {
    final Drop currentDrop = drops.get(i);
    if (currentDrop.update(obstaclesArray)) {
      currentDrop.drawConfigured();
    } else {
      drops.remove(i);
    }
  }
}

private void drawObstacles() {
  for (final Obstacle obstacle : obstacles) {
  }
}

private color getRandomColorWithAlpha(final int alpha) {
  return color(
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    (int) random(100) + 155, 
    alpha
    );
}

/**
 Drop Class
 */

public class Drop {

  private float x;

  private float y;

  private float yVelocity;

  public Drop(final float x, final float y, final float yVelocity) {
    this.x = x;
    this.y = y;
    this.yVelocity = yVelocity;
  }

  public boolean update(final Obstacle[] obstacles) {
    y += yVelocity;

    for (final Obstacle obstacle : obstacles) {
      if (touchesObstacle(obstacle)) {
        if (random(1f) > 0.5f) {
          y -= yVelocity;
        } else {
          y += random(32f);
        }
        continue;
      }
    }

    return y < height;
  }

  private boolean touchesObstacle(final Obstacle obstacle) {
    return y > obstacle.y && y < obstacle.y + 16f && x > obstacle.x - obstacle.widthHalf && x < obstacle.x + obstacle.widthHalf;
  }

  public void drawConfigured() {
    point(x, y);
  }
}

/**
 Obstacle Class
 */

public class Obstacle {

  private float x;

  private float y;

  private float maxBarrierVelocity;

  private float widthHalf;

  public Obstacle(final float x, final float y, final float maxBarrierVelocity) {
    this.x = x;
    this.y = y;
    this.maxBarrierVelocity = maxBarrierVelocity;
    this.widthHalf = 2f; //random(128f);
  }
}