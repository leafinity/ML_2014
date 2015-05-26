library ml_regularized.regularized;

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
    
    Matrix lunda = new Matrix.filled(trainData.length, trainData.length, 10.0);
    print((x.trasfer().multi(x) + lunda).inverse().multi((x.trasfer().multi(y))));
  });
}