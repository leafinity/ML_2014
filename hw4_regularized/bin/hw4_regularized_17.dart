library ml_regularized.regularized;

import 'dart:math' hide Point;
import 'config.dart';
import 'package:hw4_regularized/train_data.dart';
import 'package:hw4_regularized/point.dart';
import 'package:hw4_regularized/matrix.dart';

void main() {
  getTrainData(trainFile)
  .then((List<Point> trainData) {
    List xRows = new List();
    List yRows = new List();
    for (int i = 0, len = trainData.length; i<len; i++) {
      xRows.add(new Row([trainData[i][0], trainData[i][1]]));
      yRows.add(new Row([trainData[i].y]));
    }
    Matrix x = new Matrix(xRows);
    Matrix y = new Matrix(yRows);
    

    for (int power in [2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10]) {
      print('power: $power');
      Matrix lunda = new Matrix.filled(trainData.length, trainData.length, pow(10.0, power)); 
      print((x.trasfer().multi(x) + lunda).inverse().multi((x.trasfer().multi(y))));
    }
  })
  .then((_) => getTrainData(testFile))
  .then((_){
    print('test error rate');
  });
}

