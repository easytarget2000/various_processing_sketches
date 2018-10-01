// Based on https://gist.github.com/beesandbombs/b01e6cbf0641fa69b584c3253df28423

private static final float CROSS_WIDTH = 44f;

private static final float CROSS_HEIGHT = CROSS_WIDTH * 3f;

private static final int N = 12;

private float tt;

private float t, c;

/*
 * Lifecycle
 */

void setup() {
  size(1080, 720);
  pixelDensity(2);
  smooth(8);
  rectMode(CENTER);
  stroke(32);
  noFill();
}

void draw() {
  t = float(mouseX) / width;
  c = float(mouseY) / height;
  draw_();
}

/*
 * Implementations
 */

void draw_() {
  push();
  translate(width / 2f, height / 2f);

  if (3f * t < 1) {
    t = 3*t;

    background(234); 
    stroke(34);

    for (int i = -N; i <= N; i++) {
      for (int j =- N; j <= N; j++) {
        tt = ease(t, 3);
        push();
        translate(i*CROSS_HEIGHT - j*CROSS_WIDTH*tt, j*CROSS_HEIGHT + i*CROSS_WIDTH*tt);
        rotate(HALF_PI*tt);
        drawCross();
        pop();
      }
    }
  } else if (3f * t < 2f) {
    t = 3*t - 1;

    background(34);
    stroke(234);

    push();
    scale(-1, 1);
    for (int i=-N; i<=N; i++) {
      for (int j=-N; j<=N; j++) {
        tt = 1f - ease(t, 3f);
        push();
        translate((i+.5)*CROSS_HEIGHT + (j+.5)*CROSS_WIDTH*tt, (j+.5)*CROSS_HEIGHT - (i+.5)*CROSS_WIDTH*tt);
        rotate(-HALF_PI*tt);
        drawCross();
        pop();
      }
    }
    pop();
  } else {
    t = 3*t - 2;

    background(t>.5?34:234);
    stroke(t>.5?234:34);

    for (int i=-N; i<=N; i++) {
      for (int j=-N; j<=N; j++) {
        tt = ease(t, 3);
        push();
        translate((i+.5*(t>.5?1:0))*CROSS_HEIGHT, (j+.5*(t>.5?1:0))*CROSS_HEIGHT);
        rotate(HALF_PI*tt);
        //scale(map(cos(TWO_PI*tt), 1, -1, 1, sqrt(2)*3/4));
        rect(0f, 0f, 2f * CROSS_WIDTH, 2 * CROSS_WIDTH);
        pop();
      }
    }
  }
  pop();
}

private void push() {
  pushMatrix();
  pushStyle();
}

private void pop() {
  popStyle();
  popMatrix();
}

private void drawCross() {
  rect(0f, 0f, CROSS_WIDTH, CROSS_HEIGHT);
  rect(0f, 0f, CROSS_HEIGHT, CROSS_WIDTH);
}

private float ease(final float p, final float g) {
  if (p < 0.5f) {
    return 0.5f * pow(2f * p, g);
  } else {
    return 1f - 0.5f * pow(2f * (1f - p), g);
  }
}
