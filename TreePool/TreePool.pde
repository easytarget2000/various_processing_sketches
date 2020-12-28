/**
 * Constants
 */

/**
 * Values
 */

private ArrayList<Particle> particles = new ArrayList<Particle>();

private float maxJitter;

private boolean snapToFirst = false;

/**
 * Lifecycle
 */

void setup() {
  //size(1920, 1080);
   fullScreen();
   //fullScreen(2);
  background(0);
    frameRate(60f);

  configurePaint();
  maxJitter = width / 8f;
  addParticles(64);
}

void draw() {

  //if (millis() % 2 == 0) {
  //  background(0);
  //}
  
  noStroke();
  fill(0x30000000);
  rect(0f, 0f, width, height);

  for (int i = 0; i < 8; i++) {
    updateAndDrawParticles();
  }

  if (millis() % 2 == 0) {
    //println("Randomly adding particles.");
    addParticles(32);
  }
}

void keyPressed() {
  switch (key) {
    case 'c':
      snapToFirst = true;
      break;
  }
}

void keyReleased() {
  switch (key) {
    case 'c':
      snapToFirst = false;
      break;
  }
}

/**
 * 
 */

private void configurePaint() {
  noFill();
  stroke(0xFFDD8623);
}

private void addParticles(final int amount) {
  Particle lastParticle = new Particle(random(width), random(height));
  //Particle lastParticle = new Particle(width / 2f, height / 2f);
  for (int i = 0; i < amount - 1; i++) {
    //final Particle newParticle = new Particle(
    //  lastParticle.x + getJitter(), 
    //  lastParticle.y + getJitter()
    //  );
    final Particle newParticle = new Particle(random(width), random(height));
    particles.add(newParticle);
    lastParticle = newParticle;
  }
}

private float getJitter() {
  return (maxJitter / 2f) - random(maxJitter);
}

private void updateAndDrawParticles() {

  final Particle[] particlesArray = new Particle[particles.size()];
  particles.toArray(particlesArray);

  for (int i = 0; i < particles.size(); i++) {
    final Particle currentParticle = particles.get(i);
    if (!currentParticle.updateAndDraw(particlesArray, snapToFirst)) {
      particles.remove(i);
    }
  }
}
