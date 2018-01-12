class World {
  float r_X;
  float r_Y;
  float r_Z;
  float noise_seed;

  World() {
    r_X = 0;
    r_Y = 0;
    r_Z = 0;
    noise_seed = random(100);
  }

  void redraw() {
    background(0);
    ambientLight(100, 0, 100);
    translate(width / 2, height / 2, 0);
    camera(0f, -64f, 310f,
           0f, -64f, 0f,
           0f, 1f, 0f);
  }
    
  void rotate() {
    final float cicle_rotate = (frameCount % 64) / 2f;
    final float rollnoise = noise(noise_seed);
    r_X = 0.84f * sin(radians(cicle_rotate + (0.5f - rollnoise) * 15f));
    r_Y = 0.26f * cos(radians(cicle_rotate)) + (0.5f - rollnoise) * 0.08f;
    rotateX(r_X);
    rotateY(r_Y);
    noise_seed += 0.002;
  }

}