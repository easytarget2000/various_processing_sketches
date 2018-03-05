public class Conductor {

  /**
   * Constants
   */

  private final String TAG = Conductor.class.getSimpleName();

  /**
   * Values
   */

  private float bpm = 140f;

  private int sixteenthIntervalMillis;
  
  private int startMillis;

  private int[] acknowledgedBeatCount;
  
  private int lastTapMillis = 0;
  
  /**
   * Constructor
   */

  public Conductor(final float bpm) {
    setBpm(bpm);
  }

  /**se
   * Getter/Setter
   */

  public void setBpm(final float bpm) {
    this.bpm = bpm;
    setSixteenthIntervalMillis((int) ((60f / this.bpm) * 1000f) / 4);
  }

  public float getBpm() {
    return bpm;
  }
  
  private void setSixteenthIntervalMillis(final int interval) {
    resetTimer();

    sixteenthIntervalMillis = interval;
    acknowledgedBeatCount = new int[] {0, 0, 0, 0};
    
    final float bpm = (60f / sixteenthIntervalMillis) * 1000f;
    println("DEBUG: Conductor:  setSixteenthIntervalMillis(" + sixteenthIntervalMillis + " ms): " + bpm + " BPM");
  }

  /**
   * Life Cycle
   */

  public void resetTimer() {
    startMillis = millis();
  }

  public int getBeatCount(final int beatMultiplier) {
    return (millis() - startMillis) / sixteenthIntervalMillis / beatMultiplier;
  }

  public boolean isBeatDue(final int beatMultiplier) {
    final int count = getBeatCount(beatMultiplier);
    //println(TAG + ": isBeatDue(" + beatMultiplier + "): count: " + count);
    if (count != acknowledgedBeatCount[beatMultiplier - 1]) {
      acknowledgedBeatCount[beatMultiplier - 1] = count;
      return true;
    } else {
      return false;
    }
  }
  
  public void tap() {
    final int millisSinceLastTap = millis() - lastTapMillis;
    if (millisSinceLastTap > 1000) {
      lastTapMillis = millis();
      return;
    }
    
    lastTapMillis = millis();
    final int newInterval = (sixteenthIntervalMillis + millisSinceLastTap) / 2;
    setSixteenthIntervalMillis(newInterval);
  }
  
}