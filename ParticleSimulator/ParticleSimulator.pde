/**
 * Constants
 */

private static final int PARTICLE_ROUNDS_PER_FRAME = 1;

private static final int DEFAULT_NUM_OF_PARTICLES = 256;

private static final boolean DRAW_ATTRACTOR = false;

/**
 * Values
 */

private Particle[] particles;

private PVector attractorPosition;

private float attractorSign = 1f;

private float attractorMaxVelocity;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
  //fullScreen(); 
   fullScreen(2);
       frameRate(60f);

  background(0);

  colorMode(HSB, 1f);

  initParticles(1f);
  initAttractor();
}

void draw() {
  //background(0);
  //background(0x03000000);
  fill(0f, 0f, 0f, 0.1f);
  rect(-1f, -1f, width + 1f, height + 1f);

  //for (int round = 0; round < PARTICLE_ROUNDS_PER_FRAME; round++) {
  updateAndDrawParticles();
  //}
  updateAttractorPosition();

  //if (random(1f) > 0.99f) {
  //  initAttractor();
  //} else 
  //if (random(1f) > 0.9f) {
  //  initParticles(1f);
  //} else if (attractorSign == -1f && random(1f) > 0.5f) {
  //  attractorSign = 1f;
  //} else if (attractorSign == 1f && random(1f) > 0.9f) {
  //  attractorSign = -1f;
  //}

  if (DRAW_ATTRACTOR) {
    stroke(0f, 0f, 1f, 1f);
    ellipse(attractorPosition.x, attractorPosition.y, 32f, 32f);
  }
}

/*
 * Implementation
 */

private void initParticles(final float density) {
  final int numOfParticles = (int) (DEFAULT_NUM_OF_PARTICLES * density);
  particles = new Particle[numOfParticles];

  final float maxVelocity = 32f + random(4f);//min(width, height) / 128f;

  final PVector particleSourcePosition = new PVector(width / 2f, height / 2f);
  final float particleToSourceMaxDistance = min(width, height) / 128f + random(min(width, height));
  final float distToSource = particleToSourceMaxDistance;

  for (int i = 0; i < particles.length; i++) {
    final float hue = (float) i / (particles.length - 1f);

    final float angleToSource = hue * TWO_PI;

    final float xPos = particleSourcePosition.x + (cos(angleToSource) * distToSource);
    final float yPos = particleSourcePosition.y + (sin(angleToSource) * distToSource);
    final PVector position = new PVector(xPos, yPos);

    final PVector velocity = new PVector(random(maxVelocity), random(maxVelocity));
    final float mass = 60f + random(4f);

    particles[i] = new Particle(position, velocity, mass, hue);
  }
}

private void initAttractor() {
  attractorPosition = new PVector(width / 2f, height / 2f);
  attractorMaxVelocity = min(width, height) / 64f;
}

private void updateAndDrawParticles() {
  noStroke();
  for (final Particle currentParticle : particles) {
    final PVector vectorToAttractor = PVector.sub(attractorPosition, currentParticle.getPosition());
    final float distanceToAttractor = PVector.dist(attractorPosition, currentParticle.getPosition());
    final PVector forceOnParticle = PVector.mult(vectorToAttractor, attractorSign * 128f / distanceToAttractor);
    currentParticle.update(forceOnParticle);
    currentParticle.draw_(forceOnParticle.mag());
  }
}

private void updateAttractorPosition() {
  //attractorPosition.x += (attractorMaxVelocity / 2f) - random(attractorMaxVelocity);
  //attractorPosition.y += (attractorMaxVelocity / 2f) - random(attractorMaxVelocity);
}

private void switchAttractorSign() {
  attractorSign *= -1f;
}
