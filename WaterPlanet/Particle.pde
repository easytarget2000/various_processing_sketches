class Particle {
  float nx_start, ny_start, nr_start;
  float radius_val;
  float div_nx_start, div_ny_start;
  float div_ido, div_kdo;

  Particle() {
    nx_start = random(10f);
    ny_start = random(10f);
    nr_start = random(10f);
    radius_val = 200;
    div_ido = 0.5f;
    div_kdo = 0.5f;
    div_nx_start = 0.0008f;
    div_ny_start = 0.0002f;
  }

  void draw() {
    //stroke(260, 100, 80, 100);
    noStroke();
    sphere(radius_val);

    nx_start += div_nx_start;
    ny_start += div_ny_start;
    nr_start += 0.001f;

    div_nx_start += 0.000001f;
    div_ny_start += 0.000003f;

    float ny = ny_start;
    float nr = nr_start;

    for (float ido = 0f; ido <= 90f; ido += div_ido) {
      float radian_ido = radians(ido);
      div_kdo = 180f / max(160f / div_ido * sin(radian_ido), 1);

      float nx = nx_start;
      for (float kdo = 180; kdo <= 360f; kdo += div_kdo) {

        float radian_kdo = radians(kdo);


        final float thisx = radius_val * cos(radian_kdo) * sin(radian_ido);
        final float thisy = radius_val * sin(radian_kdo) * sin(radian_ido);
        final float thisz = radius_val * cos(radian_ido);

        pushMatrix();

        translate(thisx, thisy, thisz);
        rotateZ(radian_kdo);
        rotateY(radian_ido);

        //noFill();
        fill(
          160 + 100 * noise(nx, ny), 
          //100 - 30 * customNoise(nr),
          //200 - 50 * noise(ny, ny, nx),
          200 - 30 * noise(ny, nx), 
          200 - 30 * noise(ny, nx), 
          200 - 30 * noise(ny, nx)
          );
        rect(0f, 0f, div_ido * 3.8f, div_ido * 4.6f);

        popMatrix();

        nx += 0.04f;
        nr += 0.08f;
      }
      ny += 0.04;
    }
  }

  float customNoise(float value) {
    return abs(pow(sin(value), 3f) * cos(value));
  }
}