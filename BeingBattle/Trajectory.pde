class Trajectory {

  private PVector position;

  private PVector movement;

  private int ageBetweenDrops;

  private int age;

  private int ageOfLastBeingDrop;

  private Trajectory() {
    age = 0;
    ageOfLastBeingDrop = 0;
  }

  Trajectory(final PVector position_) {
    this();
    position = position_;

    final float maxRandomMovement = min(width, height) / 64f;

    final PVector randomMovement = new PVector();
    randomMovement.x = (maxRandomMovement / 2f) - random(maxRandomMovement);
    randomMovement.y = (maxRandomMovement / 2f) - random(maxRandomMovement);
    setMovement(randomMovement.mult(2f));
  }

  Trajectory(final PVector position_, final PVector movement_) {
    this();
    position = position_;
    setMovement(movement_);
  }

  void setMovement(final PVector movement_) {
    movement = movement_;
    ageBetweenDrops = (int) (movement.mag() / 2f);
  }

  PVector getPosition() {
    return position;
  }

  boolean updateAndDropBeing() {
    position = PVector.add(position, movement);

    avoidCollision();

    if (age++ - ageOfLastBeingDrop >= ageBetweenDrops) {
      ageOfLastBeingDrop = age;
      return true;
    } else {
      return false;
    }
  }

  private void avoidCollision() {
    if (position.x < 0f || position.x > width) {
      movement.x *= -0.95f;
    }
    
    if (position.y < 0f || position.y > height) {
      movement.y *= -0.95f;
    }
  }
}