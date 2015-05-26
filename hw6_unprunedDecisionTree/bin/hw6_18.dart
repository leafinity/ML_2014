library ml_udt.hw6_18;

import 'package:hw6_unprunedDecisionTree/train_data.dart';
import 'package:hw6_unprunedDecisionTree/unpruned_decision_tree.dart';
import 'src/config.dart';

void main() {
  DecisionTreeModel model;
  getTrainData(trainDataPath)
   .then((List trainData) {
    model = decisionTreeTrain(trainData, 2);
    return getTrainData(testDataPath);
  })
  .then((List testData) {
    DecisionTreePrediction predict = decisionTreePredict(model, testData);
    print('Eout = ${predict.errRate}');
   });  
}