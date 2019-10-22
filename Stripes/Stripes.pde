int margin = 50;
int numFrames = 128;

void setup() {
  size(600, 600);
}

void draw() {
  background(0);

  float t = 1.0*(frameCount-1)%numFrames/numFrames;

  // Draws every pixel
  for (int i = margin; i < width - margin; i+= 3) {
    for (int j = margin; j < height - margin; j++) {
      final color color_ = pixel_color(i, j, t);
      set(i, j, color_);
      set(i + 1, j, color_);
      set(i + 2, j, color_);
    }
  }

  // Draws a white rectangle
  stroke(255);
  noFill();
  rect(margin, margin, width-2*margin, height-2*margin);
}

color pixel_color(float x, float y, float t) {
  float result = ease(
    map(
    sin(TWO_PI * (t + scalar_field_offset(x, y))), 
    -1f, 
    1f, 
    0f, 
    1f
    ), 
    3f
    );
  return color(255*result);
}

float ease(float p, float g) {
  if (p < 0.5f)
    return 0.5f * pow(2f * p, g);
  else
    return 1f - (0.5f * pow(2f * (1f - p), g));
}

//float scalar_field_offset(float x, float y) {
//  float distance = dist(x, y, width / 2f, height / 2f);
//  return 0.5f * (x + y) /  distance;
//}

float scale = 0.003f;

//float scalar_field_offset(float x, float y) {
//  return 10f * noise(scale * x, scale * y);
//}

 
float scalar_field_offset(float x,float y){
  float distance = dist(x,y,0.5*width,0.5*height);
   
  float result = 300/(25+distance);
  return result;
}
