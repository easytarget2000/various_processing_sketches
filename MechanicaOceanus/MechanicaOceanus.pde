/*
Based on http://beautifulprogramming.com/mechanica-oceanus/
*/

Gradient g;
Part[][] allParts;
int xCount;
int yCount;
int numParts;
int gridSize = 30;

boolean cameraOrtho = false;
boolean isPaused = false;
boolean autoPlay = false;
boolean[] edit;

void setup()
{
  fullScreen(P3D);
  colorMode(HSB);
  background(0);
  noStroke();
  smooth();
  edit = new boolean[10];
  g = new Gradient();
  createParts();
}

void draw()
{
  if (!isPaused && autoPlay) {
    if (frameCount % 800 == 0) {
      randomizeParts();
    }
  }
  
  g.update();

  //background(0);

  pushMatrix();
  translate(0, 0, 10);
  directionalLight(255, 0, 150, -0.3, 0.5, -1);
  directionalLight(255, 0, 150, 0.5, -0.3, -1);
  popMatrix();

  translate(0, 0, -100);
  if (cameraOrtho) {
    ortho(-940/2, 940/2, -540/2, 540/2, -10000, 10000);
  } else {
    perspective();
  }

  updateParts();
}

void createParts()
{
  xCount = ceil(width/gridSize);
  yCount = ceil(height/gridSize);
  allParts = new Part[yCount + 1][xCount + 1];

  for (int i = 0; i <=yCount; i++) {
    for (int j = 0; j <=xCount; j++) {     
      final Part part = new Part(j*gridSize, i*gridSize, (i*j+j) * 0.01f);
      part.colorRatio = (i+j)/(xCount+1+yCount+1);
      allParts[i][j] = part;
    }
  }
}

void updateParts()
{
  xCount = ceil(width/gridSize);
  yCount = ceil(height/gridSize);

  for (int i=0; i<=yCount; i++)
  {
    for (int j=0; j<=xCount; j++)
    {
      final Part part = allParts[i][j];
      part.update();
    }
  }
}

void randomizeParts()
{
  g.changeColors();

  float scaleMod = random(0, 0.01);
  float rotMod = random(0, 3);
  float speedMod = random(0.5, 1);

  float noiseMod = random(0.0, 0.01);
  float colorSpeed = random(0, 0.015);

  float boxW = random(1, 600);
  float boxH = random(1, 600);
  float boxD = random(1, 600);

  xCount = ceil(width/gridSize);
  yCount = ceil(height/gridSize);

  for (int i=0; i<=yCount; i++)
  {
    for (int j=0; j<=xCount; j++)
    {
      Part part = allParts[i][j];
      part.tscaleMod = scaleMod;
      part.tnoiseMod = noiseMod;
      part.trotMod = rotMod;
      part.tspeedMod = speedMod;
      part.tcolorSpeed = colorSpeed;
      part.tboxW = boxW;
      part.tboxH = boxH;
      part.tboxD = boxD;
    }
  }
}

void mousePressed()
{
  randomizeParts();
  autoPlay = false;
}

void keyPressed()
{
  if (key == 'o') cameraOrtho = !cameraOrtho;
  if (key == ' ') isPaused = !isPaused;
  if (key == 'r') randomizeParts();
  if (key == 'a') autoPlay = !autoPlay;
  if (key == 'c') g.changeColors();

  if (key == '1') edit[1] = true;
  if (key == '2') edit[2] = true;
  if (key == '3') edit[3] = true;
  if (key == '4') edit[4] = true;
  if (key == '5') edit[5] = true;
  if (key == '6') edit[6] = true;
  if (key == '7') edit[7] = true;
  if (key == '8') edit[8] = true;
  if (key == '9') edit[9] = true;
}

void keyReleased()
{
  if (key == '1') edit[1] = false;
  if (key == '2') edit[2] = false;
  if (key == '3') edit[3] = false;
  if (key == '4') edit[4] = false;
  if (key == '5') edit[5] = false;
  if (key == '6') edit[6] = false;
  if (key == '7') edit[7] = false;
  if (key == '8') edit[8] = false;
  if (key == '9') edit[9] = false;
}

class Gradient
{
  PGraphics pg;
  int w = 300;
  color[] allColorsNew;
  color[] allColorsCurrent;
  int trans = w;
  int brightFloor = 100;
  int satFloor = 200;

  Gradient()
  {
    allColorsNew = new color[w];
    allColorsCurrent = new color[w];

    createPalette();

    for (int i=0; i<w; i++)
    {
      allColorsCurrent[i] = allColorsNew[i];
    }
  }

  void update()
  {
    for (int i=0; i<5; i++)
    {
      if (trans < w)
      {
        allColorsCurrent[trans] = allColorsNew[trans];
      }
      trans++;
    }
  }

  void changeColors()
  {
    trans = 0;
    satFloor = (int) random(255);
    brightFloor = (int) random(255);
    createPalette();
  }

  void createPalette()
  {
    pg = createGraphics(w, 1);
    pg.colorMode(HSB);
    pg.beginDraw();

    pg.noStroke();

    color baseColor = color(random(255), random(satFloor, 255), random(brightFloor, 255));
    pg.background(baseColor);

    int numColors = 4;
    for (int i=0; i<numColors; i++)
    {
      addColor();
    }

    pg.endDraw();

    for (int i=0; i<w; i++)
    {
      allColorsNew[i] = pg.get(i, 0);
    }
  }

  void addColor()
  {
    color c = color(random(255), random(satFloor, 255), random(brightFloor, 255));
    float pos = random(w);
    float size = w/4;

    for (int i=0; i<w; i++)
    {
      float ratio = 0;
      float d = abs(i-pos);
      if (d < size)
      {
        ratio = 1.0 - (d/size);
      }
      pg.fill(hue(c), saturation(c), brightness(c), (ratio)*255);
      pg.rect(i, 0, 1, 1);
    }
  }

  void draw()
  {
    image(pg, 0, height/2, width, 10);
  }

  color getColor(float _ratio)
  {
    float ratio = constrain(_ratio, 0, 1);
    int index = floor((w-1) * _ratio);
    return allColorsCurrent[index];
  }
}

class Part
{
  float x, y, z;
  float rx, ry, rz;
  float vrx, vry, vrz;
  float colorRatio;

  float osc1, osc2, osc3;

  float scaleMod = 0.001;
  float noiseMod = 0.002;
  float rotMod = 3;
  float speedMod = 0.25;
  float colorSpeed = 0.003;
  float colorTime = 0;
  float boxW = 300;
  float boxH = 300;
  float boxD = 300;

  float tscaleMod = scaleMod;
  float tnoiseMod = noiseMod;
  float trotMod = rotMod;
  float tspeedMod = speedMod;
  float tcolorSpeed = colorSpeed;
  float tboxW = boxW;
  float tboxH = boxH;
  float tboxD = boxD;

  Part(float _x, float _y, float _z)
  {
    x = _x;
    y = _y;
    z = _z;
  }

  void update()
  {
    updateInputValues();
    updateProperties();
    if (!isPaused) 
    {
      updateColor();
      move();
    }
    render();
  }

  void updateInputValues()
  {
    if (edit[1]) tnoiseMod = getValue(tnoiseMod, -0.01, 0.01);
    if (edit[2]) tcolorSpeed = getValue(tcolorSpeed, -0.02, 0.02);

    if (edit[3]) tscaleMod = getValue(tscaleMod, -0.02, 0.02);
    if (edit[4]) trotMod = getValue(trotMod, -3, 3);
    if (edit[5]) tspeedMod = getValue(tspeedMod, -2, 2);

    if (edit[6]) tboxW = tboxH = tboxD = getValue(tboxW, 0, 800);
    if (edit[7]) tboxW = getValue(tboxW, 0, 800);
    if (edit[8]) tboxH = getValue(tboxH, 0, 800);
    if (edit[9]) tboxD = getValue(tboxD, 0, 800);
  }

  void updateProperties()
  {
    float transMod = 0.1;
    scaleMod += (tscaleMod - scaleMod) * transMod;
    noiseMod += (tnoiseMod - noiseMod) * transMod;
    rotMod += (trotMod - rotMod) * transMod;
    speedMod += (tspeedMod - speedMod) * transMod;
    colorSpeed += (tcolorSpeed - colorSpeed) * transMod;
    boxW += (tboxW - boxW) * transMod;
    boxH += (tboxH - boxH) * transMod;
    boxD += (tboxD - boxD) * transMod;
  }

  void updateColor()
  {
    colorTime += colorSpeed;

    float n = noise(x*noiseMod, y*noiseMod, colorTime);
    n = map(n, 0.3, 0.7, 0, 1);
    n = constrain(n, 0, 1); 
    colorRatio = n;
  }

  void move()
  {
    osc1 += 0.01 * speedMod;
    osc2 += 0.007 * speedMod;
    osc3 += 0.003 * speedMod;

    rx = sin(osc1 + x*scaleMod) * rotMod;
    ry = sin(osc2 + y*scaleMod) * rotMod;
    rz = sin(osc3 + (x+z)*scaleMod*0.1) * rotMod;
  }

  void render()
  { 
    pushMatrix();
    translate(x, y, z);
    rotateY(ry);
    rotateX(rx);
    rotateZ(rz);
    fill(g.getColor(colorRatio));
    box(boxW, boxH, boxD);
    popMatrix();
  }

  float getValue(float value, float lower, float upper)
  {
    float v = value;
    v += (map(mouseX, 0, width, lower, upper) - value) * 0.3;
    return v;
  }
}
