public interface ProjectorListener { //<>// //<>//
  public void drawSample(final float t);
}

public class Projector {
  private int[][] result;
  int samplesPerFrame = 1;
  int numFrames = 540;        
  float shutterAngle = 0.6f;
  ProjectorListener listener;

  boolean recording = false;
  boolean preview = false;

  //float ease(float p) {
  //  return 3*p*p - 2*p*p*p;
  //}

  //float ease(float p, float g) {
  //  if (p < 0.5) 
  //    return 0.5 * pow(2*p, g);
  //  else
  //    return 1 - 0.5 * pow(2*(1 - p), g);
  //}

  float mn = .5*sqrt(3), ia = atan(sqrt(.5));

  //float c01(float g) {
  //  return constrain(g, 0, 1);
  //}

  Projector(final int width_, final int height_, final ProjectorListener listener) {
    result = new int[width_ * height_][3];
    this.listener = listener;
  }

  void perform() {
    float t = 0f;

    if (preview) {
      final float c = mouseY*1.0/height;
      if (mousePressed)
        println(c);
      t = (millis()/(20f * numFrames))%1;
      if (listener != null) {
        listener.drawSample(t);
      }
    } else {
      for (int i=0; i<width*height; i++)
        for (int a=0; a<3; a++)
          result[i][a] = 0;

      final float c = 0f;
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

      if (recording) {
        saveFrame("f###.png");
        if (frameCount==numFrames) {
          exit();
        }
      }
    }
  }
}
