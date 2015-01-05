library ml_ada.hw6_13;

import 'package:hw6_adaboost/train_data.dart';
import 'package:hw6_adaboost/adaboost.dart';
import 'src/config.dart';

void main() {
  AdaboostModel model;
  getTrainData(trainDataPath)
   .then((List trainData) {
    model = adaboostTrain(trainData, 2, 300);
    return getTrainData(testDataPath);
  })
  .then((List testData) {
    AdaboostPrediction predict = adaboostPredict(model, testData);
    print('Eout(Gt) = ${predict.errRate}');
   });  
}