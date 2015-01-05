library ml_ada.hw6_14;

import 'package:hw6_adaboost/train_data.dart';
import 'package:hw6_adaboost/adaboost.dart';
import 'src/config.dart';

void main() {
  getTrainData(trainDataPath)
   .then((List trainData){
    AdaboostModel model = adaboostTrain(trainData, 2, 300);
    print('U(t) = ${model.dataWeights.fold(0, (prev, element) => prev + element)}');
   });  
}