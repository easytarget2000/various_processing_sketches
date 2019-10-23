public interface ProjectorListener {
  public void drawSample(final float t);
}

public class Projector {
  private int[][] result;
  private float t, c;
  private int samplesPerFrame = 4;
  private int numFrames = 540;        
  private float shutterAngle = .6;
  ProjectorListener listener;

  boolean recording = false;
  boolean preview = true;

  float ease(float p) {
    return 3*p*p - 2*p*p*p;
  }

  //float ease(float p, float g) {
  //  if (p < 0.5) 
  //    return 0.5 * pow(2*p, g);
  //  else
  //    return 1 - 0.5 * pow(2*(1 - p), g);
  //}

  float mn = .5*sqrt(3), ia = atan(sqrt(.5));

  float c01(float g) {
    return constrain(g, 0, 1);
  }

  Projector(final int width_, final int height_, final ProjectorListener listener) {
    result = new int[width_ * height_][3]; //<>//
    this.listener = listener; //<>//
  }

  void perform() {
    if (recording) {
      for (int i=0; i<width*height; i++)
        for (int a=0; a<3; a++)
          result[i][a] = 0;

      c = 0;
      for (int sa=0; sa<samplesPerFrame; sa++) {
        t = map(frameCount-1 + sa*shutterAngle/samplesPerFrame, 0, numFrames, 0, 1);
        if (listener != null) {
          listener.drawSample(t);
        }
        loadPixels();
        for (int i=0; i<pixels.length; i++) {
          result[i][0] += pixels[i] >> 16 & 0xff;
          result[i][1] += pixels[i] >> 8 & 0xff;
          result[i][2] += pixels[i] & 0xff;
        }
      }

      loadPixels();
      for (int i=0; i<pixels.length; i++)
        pixels[i] = 0xff << 24 | 
          int(result[i][0]*1.0/samplesPerFrame) << 16 | 
          int(result[i][1]*1.0/samplesPerFrame) << 8 | 
          int(result[i][2]*1.0/samplesPerFrame);
      updatePixels();

      saveFrame("f###.png");
      if (frameCount==numFrames)
        exit();
    } else if (preview) {
      c = mouseY*1.0/height;
      if (mousePressed)
        println(c);
      t = (millis()/(20.0*numFrames))%1;
      if (listener != null) {
        listener.drawSample(t);
      }
    } else {
      t = mouseX*1.0/width;
      c = mouseY*1.0/height;
      if (mousePressed)
        println(c);
      if (listener != null) {
        listener.drawSample(t);
      }
    }
  }
}
