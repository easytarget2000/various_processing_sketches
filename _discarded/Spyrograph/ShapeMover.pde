class ShapeMover {

  private float radiusLimit;

  private PVector centerPosition;

  private float trackRadius;
  
  private float trackRadiusVelocity;

  private float angleOnTrack;

  private float angleOnTrackVelocity;

  public ShapeMover(
    final float radiusLimit_, 
    final PVector centerPosition_, 
    final float trackRadiusFactor,
    final float trackRadiusVelocity_,
    final float angleOnTrack_, 
    final float angleOnTrackVelocity_
    ) {
    radiusLimit = radiusLimit_;
    centerPosition = centerPosition_;
    if (trackRadiusFactor > 1f) {
      trackRadius = radiusLimit;
    } else {
      trackRadius = radiusLimit * trackRadiusFactor;
    }
    trackRadiusVelocity = trackRadiusVelocity_;
    angleOnTrack = angleOnTrack_;
    angleOnTrackVelocity = angleOnTrackVelocity_;
  }
  
  public void update() {
    angleOnTrack += angleOnTrackVelocity;
    trackRadius += trackRadiusVelocity;
  }

  public void drawConfigured() {
    final float radiusDifference = radiusLimit - trackRadius;
    final PVector position = new PVector(
      centerPosition.x + (cos(angleOnTrack) * radiusDifference), 
      centerPosition.y + (sin(angleOnTrack) * radiusDifference)
      );

    ellipse(position.x, position.y, radiusDifference, radiusDifference);
  }
}
