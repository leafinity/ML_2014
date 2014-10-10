library ml_hw1.pocket;

import 'dart:math' show Random;
import 'dart:async';

import "package:ML_HW1/arg.dart";
import "package:ML_HW1/point.dart";
import "package:ML_HW1/train_data.dart";

List<Point> trainData;
Random ran = new Random(new DateTime.now().millisecondsSinceEpoch);

void main(List<String> arguments) {
  final Args args = parseArgs(arguments);
  if (args == null)
      return;
  
  getTrainData(args.path)
  .then((List<Point> _){
    trainData = _;
    print('turns: ${pocket()}');
  });  
}

int pocket() {
  DateTime start = new DateTime.now();
  Weight LastWeight = new Weight(0.0, 0.0, 0.0, 0.0);
  int LastCorrectNum = _checkPoints(LastWeight);
  
  for(int t = 0, dataLen = trainData.length;; t++) {
    if (start.difference(new DateTime.now()).inHours > 10) {
      return t;
    } 
    Weight weight = _correctWeight(trainData[ran.nextInt(dataLen)], LastWeight);
    int correctNum = _checkPoints(weight);
    
    if (correctNum > LastCorrectNum) {
      LastCorrectNum = correctNum;
      LastWeight = weight;
    }
      
  }
}

int _checkPoints(Weight w) {
  int num;
  for (int i = 0, len = trainData.length; i < len; i++)
    if (getY(trainData[i], w) == trainData[i].y)
      num++;
  return num;
}

bool _hasMistake(int correctNum) {
  return correctNum != trainData.length;
}


Weight _correctWeight(Point p, Weight w) {
//  int y = p.y * -1;
  return w.add(p, p.y);
}

Future<Point> _handleData(String pointStr) {
  int start = 0;
  List<String> numStrs = new List();
  for (int i = 0, len = pointStr.length; i < len; i++) {
    if (pointStr[i] == ' ') {
      if (pointStr[i+1] == ' ')
        continue;
      numStrs.add(pointStr.substring(start, i));
      start = i + 1;
    }
  }
  numStrs.add(pointStr.substring(start));
print('numStrs: $numStrs');

  return new Future.value(new Point(double.parse(numStrs[0]), double.parse(numStrs[1]),
      double.parse(numStrs[2]), double.parse(numStrs[3]), int.parse(numStrs[4])));
}
