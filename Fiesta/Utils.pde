import java.util.Random;

public class Utils {

  private Random random = new Random();

  //public Utils() {
  //  random = new Random();
  //}
  
  public float gaussdist(float pmean, float plimit, float pdevi) {
    /**
       Gaussian distribution
       1.parameters.
       pmean  : mean value
       plimit : max value of abs(deviation)
       ex. plimit >= 0
       pmean = 0.5, plimit = 0.5 -> return value = from 0.0 to 1.0
       pdevi  : standard deviation value
       ex. good value? -> pdevi = plimit / 2
       2.return.
       gaussian distribution
    **/

    if (plimit == 0) {
      return pmean;
    }

    float gauss = (float) random.nextGaussian() * pdevi;
    // not good idea
    if (abs(gauss) > plimit) {
      gauss = pow(plimit, 2) / gauss;
    }

    return pmean + gauss;
    
  }
}