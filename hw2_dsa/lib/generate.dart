library ml_dsa.generate;

import 'dart:math';
import 'point.dart';

/* if u want to generate noise data, u should pass an integer between 0 and 99 to [noise],
 * it presents the percentage of noise data.
 * 
 */
List<Point1> generateOneDimensionData(int size, [int noise = 0]) {
  List<Point1> data = new List();
  Random ran = new Random(new DateTime.now().millisecondsSinceEpoch);
  
  for (int i = 0; i < size; i++) {
    bool postive = ran.nextBool();
    double value = ran.nextDouble();
    
    int sign = postive == true? 1: -1;
    
    int mod = 100 ~/ noise;
    if (i % mod == 0)
      data.add(new Point1([sign * value], sign * -1));
    else
      data.add(new Point1([sign * value], sign));
  }
  
  return data;
}