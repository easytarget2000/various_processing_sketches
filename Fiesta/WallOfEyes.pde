class WallOfEyes {

  private EyeElement[] eyes;

  private PVector[] locateEyes;

  private float radianIdo[], radianKdo[];

  private float blinkRadian[], divBlink[];

  private int numEyes;

  public WallOfEyes() {

    int numIdo = 32;
    int numKdo = 30;
    int startIdo = 110;
    int stopIdo = 190;
    int startKdo = 180;
    int stopKdo = 370;
    int radiusWall = 600;

    numEyes = numIdo * numKdo;
    float divIdo = (stopIdo - startIdo) / numIdo;
    float divKdo = (stopKdo - startKdo) / numKdo;

    radianIdo = new float[numEyes];
    radianKdo = new float[numEyes];
    blinkRadian = new float[numEyes];
    divBlink = new float[numEyes];
    eyes = new EyeElement[numEyes];
    locateEyes = new PVector[numEyes];

    float ido, kdo;
    int cntEyes = 0;
    for (ido = startIdo; ido < stopIdo; ido += divIdo) { // Y
      for (kdo = startKdo; kdo < stopKdo; kdo += divKdo) { // Z

        if (cntEyes < numEyes) {
          radianIdo[cntEyes] = radians(ido);
          radianKdo[cntEyes] = radians(kdo);
          blinkRadian[cntEyes] = util.gaussdist(90, 10, 5);
          divBlink[cntEyes] = 0.5 + util.gaussdist(0.5, 0.5, 0.3);

          eyes[cntEyes] = new EyeElement();
          locateEyes[cntEyes] = new PVector(
            radiusWall * cos(radianKdo[cntEyes]) * sin(radianIdo[cntEyes]), 
            radiusWall * sin(radianKdo[cntEyes]) * sin(radianIdo[cntEyes]), 
            radiusWall * cos(radianIdo[cntEyes])
            );
        }
        ++cntEyes;
      }
    }
  }

  void drawEyes() {
    for (int i = 0; i < numEyes; ++i) {
      blinkRadian[i] += divBlink[i];
      pushMatrix();
      translate(locateEyes[i].x, locateEyes[i].y, locateEyes[i].z);
      rotateZ(radianKdo[i]); // must be this order Z -> Y
      rotateY(radianIdo[i]);
      rotateX(radians(blinkRadian[i]));
      eyes[i].show();
      popMatrix();
    }
  }
}