library ml_udt.hw6_16;

import 'package:hw6_unprunedDecisionTree/train_data.dart';
import 'package:hw6_unprunedDecisionTree/unpruned_decision_tree.dart';
import 'src/config.dart';

void main() {
  getTrainData(trainDataPath)
   .then((List trainData){
    DecisionTreeModel model = decisionTreeTrain(trainData, 2, printBranch: true);
   });  
}