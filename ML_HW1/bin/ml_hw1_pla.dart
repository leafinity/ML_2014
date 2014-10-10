library ml_hw1.pla;

import "package:ML_HW1/arg.dart";
import "package:ML_HW1/point.dart";
import "package:ML_HW1/train_data.dart";

List<Point> trainData;

void main(List<String> arguments) {
  final Args args = parseArgs(arguments);
  if (args == null)
      return;
  
  getTrainData(args.path)
  .then((List<Point> _){
    trainData = _;
    print('turns: ${pla()}');
  });  
}


int pla() {
  int correctNum = 0;
  Weight weight = new Weight(0.0, 0.0, 0.0, 0.0);
  for(int t = 0, dataLen = trainData.length;; t++) {
    if (!_hasMistake(correctNum)) {
      return t;
    } else if (_pointIsWrong(trainData[t % dataLen], weight)) {
      weight = _correctWeight(trainData[t % dataLen], weight);
      correctNum = 0;
    } else {
      correctNum++;
    }
    
    if (t % 100000 == 0)
      print('turns: $t, $correctNum');
  }
}

bool _pointIsWrong(Point p, Weight w) {
  if (getY(p, w) == p.y)
    return false;
  else
    return true;
}

bool _hasMistake(int correctNum) {
  return correctNum != trainData.length;
}


Weight _correctWeight(Point p, Weight w) {
  return w.add(p, -p.y);
}