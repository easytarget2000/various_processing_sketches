class Node {

  private final String name;

  private final float sz;

  private Node nextn;

  private float xpos;

  private float ypos;

  private float zpos;

  private float vx;

  private float vy;

  private float vz;

  Node(final float xpos, final float ypos, final float zpos, final String name, final Node nextn) {
    this.xpos=xpos;
    this.ypos=ypos;
    this.zpos=zpos;
    this.sz=33;
    this.name=name;
    this.vx=random(-30.1, 5);
    this.vy=random(-2, 13.1);
    this.vz=random(-2, 9);
    this.nextn=nextn;
  }

  void exec(final Group g) {

    this.xpos += vx;
    this.ypos += vy;
    this.zpos += vz;
    if (g != null) {
      //g.push();
      //g.translate(this.xpos, this.ypos);
      ////      g.translate(this.xpos,this.ypos,this.zpos);

      //g.box(this.sz);
      ////g.rect(0,0,50,50);
      //g.pop();
    } else {
      float nxpos= nextn.xpos;
      float nypos= nextn.ypos;
      float nzpos= nextn.zpos;
      pushMatrix();
      translate(this.xpos, this.ypos, this.zpos);
      float sx=0, sy=0, sz=0;
      float ox=0, oy=0, oz=0;
      float dx= nextn.xpos-this.xpos;
      float dy= nextn.ypos-this.ypos;
      float dz= nextn.zpos-this.zpos;
      //float ii=random(0.3,0.301);
      //float jj=random(0.3,0.302);
      float ii=0.3;
      float jj=0.3;
      float ai=random(0, HALF_PI);
      float aj=random(0, HALF_PI);
      //ai=aj=0;
      for (float i=0; i<2*Math.PI; i+=ii) {
        for (float j=0; j<Math.PI; j+=jj) {

          sx = (i) * (sin(j + aj) * pow(cos(i + ai), 3f));
          sy = (i) * (sin(j + aj) * pow(cos(i + ai), 3f));
          sz = (i) * cos(j+aj)*2.3;
          ox=map(sx, -1, 1, -1*dx/2, 1*dx/2);
          oy=map(sy, -1, 1, -1*dy/2, 1*dy/2);
          oz=map(sz, -1, 1, -1*dz/2, 1*dz/2);
          //oz=0;
          pushMatrix();
          translate(ox, oy, oz);
          //box(this.sz);
          if (counter%10==0) {
            t*=-1;
          }
          if (t<0) {
            //texture(p);
          }
          //plane(this.xpos-this.nextn.xpos,this.ypos-this.nextn.ypos);
          box((this.xpos-this.nextn.xpos)/30, (this.ypos-this.nextn.ypos)/3, (this.zpos-this.nextn.zpos)/3);
          //line(this.xpos,this.ypos,this.zpos,this.nextn.xpos,this.nextn.ypos,this.nextn.zpos);
          //box(3);
          //sphere(23);
          popMatrix();
        }
      }
      popMatrix();

      /*
      push();
       console.log('exec not g:'+g);
       translate(this.xpos,this.ypos);
       //  translate(this.xpos,this.ypos,this.zpos);
       //box(this.sz);
       box(this.xpos-this.nextn.xpos,this.ypos-this.nextn.ypos,this.zpos-this.nextn.zpos);
       //sphere(this.sz);
       //rect(0,0,50,50);
       console.log('this output');
       pop();
       float xx = map(noise(this.vx,this.vy),0,1,10,750);
       float yy = map(noise(this.vy,this.vx),0,1,10,750);
       console.log("node name:"+this.name);
       console.log("node prev:"+this.nextn);
       //line(this.xpos,this.ypos,this.zpos,this.nextn.xpos,this.nextn.ypos,this.nextn.zpos);
       //push();
       //translate(xx,yy);
       //line(0,0,0,this.vx,this.vy,this.vz);
       //pop();
       */
    }
  }

  float getX() {
    return this.xpos;
  }
  /*
  get nextn(){
   return this.nextn;  
   }
   set nextn(nx){
   this.nextn=nx;  
   }*/
}
