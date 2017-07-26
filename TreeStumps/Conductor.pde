public class Conductor {

  /**
   * Constants
   */

  private final String TAG = Conductor.class.getSimpleName();

  /**
   * Values
   */

  private float bpm = 64f;

  private int sixteenthIntervalMillis;

  private int nextSixteenthBeatMillis;

  private int nextEigthBeatMillis;

  private int nextQuarterBeatMillis;

  private int nextHalfBarMillis;

  private int nextBarMillis;

  private int startMillis;

  private int[] acknowledgedBeatCount;
  /**
   * Constructor
   */

  public Conductor(final float bpm) {
    setBpm(bpm);
  }

  /**
   * Getter/Setter
   */

  public void setBpm(final float bpm) {
    this.bpm = bpm;

    resetTimer();

    sixteenthIntervalMillis = (int) ((60f / this.bpm) * 1000f) / 4;
    final int millis = millis();
    nextSixteenthBeatMillis = millis + sixteenthIntervalMillis;

    acknowledgedBeatCount = new int[] {0, 0, 0, 0};
  }

  public float getBpm() {
    return bpm;
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
}