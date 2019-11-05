private static final int MAX_NODES = 12;

float p;
//float ns
private Group grp;
float xpline, ypline; 
float xdist, ydist;
private int counter=0, img;
float rndp=1;

private float t=1;

void setup() {
  fullScreen(P3D);
  //   \n The term readymade was first used by French artist Marcel Duchamp to \n describe the works of art he made from manufactured objects.\n It has since often been applied more generally to artworks by other artists\n made in this way',40,20);
  background(80, 5);
  stroke(0.5);
  //  p.background(100);
  grp = new Group();
  xpline=10;
  ypline=10;
  xdist=1;
  ydist=1;
  float x, y, z;

  for (int i = 0; i < MAX_NODES; i++) {
    x =(i%xpline)*xdist;
    y = floor(i/xpline)*ydist;
    z = noise(-30f, 50f);

    final Node newNode = new Node(
      x - width / 2f, 
      y, 
      z, 
      String.valueOf(i), 
      null
      );
    grp.addnode(newNode);
  }

  for (int i=0; i<MAX_NODES; i++) {
    if (i != MAX_NODES-1) {
      grp.group.get(i).nextn = grp.group.get((i+1));
    } else {
      grp.group.get(i).nextn = grp.group.get(0);
    }
  }

  strokeWeight(0.7f);
  //grp.addnode(new node(23,3,2,0));
}

void draw() {
  //background(80);
  //p.background(40);
  //ns.exec();  
  camera(sin(frameCount * 0.01) * 100+900, sin(frameCount *0.01)*900, cos(frameCount * 0.01) * 100+900, 0, 0, 0, 0, 1, 0);
  //camera(0,sin(frameCount*0.001)*900,cos(frameCount*0.001)*900,0,0,0,0,1,0);
  //camera(0,900,90,0,0,0,0,1,0);
  //texture(img);
  grp.exec();

  //grp.exec(p);
  //p.updatePixels();
  //image(p,-windowWidth/2,0);
  counter++;
  if (counter % 15 == 0) {
    randomisevel();
  }
  if (counter%100==0) {
    background(80, 5);
  }
  if (counter%190==0) {
    resetgrp();  
    rndp=3;
  }

  if (counter%13==0) {
    rndp+=3;
  }
  if (counter%rndp==0) {
    //rndp=random(1,14);
    randomisepos();
  }
  if (counter%67==0) {
    //rndp=random(1,14);
    background(80, 5);
  }
}

void randomisepos() {
  for (int i = 0; i < MAX_NODES; i++) {
    final Node n = grp.group.get(i);
    n.xpos = noise(-n.xpos, n.xpos);
    n.ypos = noise(-n.ypos, n.ypos);
    final float xx = map(noise(-n.xpos, n.xpos), 0, 1, 1, 7);
    final float yy = map(noise(-n.ypos, n.ypos), 0, 1, 1, 7);
    n.xpos += (i % xpline) * xdist - width / 2f;
    n.ypos += floor(i / xpline) * ydist;
    n.xpos += xx;
    n.ypos += yy;
  }
}

void resetgrp() {
  for (int i = 0; i < MAX_NODES; i++) {
    final Node n = grp.group.get(i);
    n.xpos=random(-2, 3);
    n.ypos=random(-30, 400);
    n.xpos += (i%xpline)*xdist- width/2f;
    n.ypos += floor(i/xpline)*ydist;
  }
}
void randomisevel() {
  for (int i=0; i < MAX_NODES; i++) {
    final Node n = grp.group.get(i);
    n.vx = random(-2f, 3f);
    n.vy = random(-3f, 4f);
    n.vz = random(-3f, 3f);
  }
}
