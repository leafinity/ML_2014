library ml_ada.hw6_15;

import 'package:hw6_adaboost/train_data.dart';
import 'package:hw6_adaboost/adaboost.dart';
import 'src/config.dart';

List trainData, testData;
void main() {
  getTrainData(trainDataPath)
   .then((_) {
    trainData = _;
    return getTrainData(testDataPath);
  })
  .then((_) {
    testData = _;
    AdaboostModel model = adaboostTrain(trainData, 2, 300, doPrint: true, testData: testData);
    AdaboostPrediction predict = adaboostPredict(model, trainData);
    print('Ein(GT): ${predict.errRate}');
   });
}