library ml_udt.hw6_19;

import 'package:hw6_unprunedDecisionTree/train_data.dart';
import 'package:hw6_unprunedDecisionTree/random_forest.dart';
import 'src/config.dart';

int round = 100;
List trainData, testData;
void main() {
  getTrainData(trainDataPath)
   .then((_) {
    trainData = _;
    return getTrainData(testDataPath);
  })
  .then((_) {
    testData = _;
    double errIn = 0.0, errOut = 0.0;
    for (int i = 0; i < round; i++) {
      ForestModel model = forestTrain(trainData, 2, 300);

      ForestPrediction predict;
      
      predict= forestPredict(model, trainData);
      errIn += predict.errRate;
      predict = forestPredict(model, testData);
      errOut += predict.errRate;
    }
    print('Ein = ${errIn/round}');
    print('Eout = ${errOut/round}');
  });
}