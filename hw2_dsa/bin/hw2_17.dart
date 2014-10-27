library ml_hw2.dsa17;

import 'package:decision_stump/point.dart';
import 'package:decision_stump/dsa.dart';
import 'package:decision_stump/generate.dart';

const int ROUND = 5000;

void main() {
  double errorRate = 0.0;
  double Eout = 0.0;
  for (int i = 0; i < ROUND; i++) {
    List<Point1> data = generateOneDimensionData(20, 20);
    errorRate += getDsaEin(data, 1);
    bestThreshold *= bestThreshold < 0? -1: 1; 
    Eout += 0.5 + 0.3 * (bestThreshold -1);
  }
  
  print('average Ein = ${errorRate/ROUND}');
  print('average Eout = ${(Eout/ROUND)}');
}