library ml_ada.adaboost;

import 'dart:math' hide Point;
import 'point.dart';
import 'decision_stumps.dart';

class AdaboostModel {
  int iterations;
  List<DsaReturn> classifiers;
  List<double> alphas;
  List<double> dataWeights;
}

class AdaboostPrediction {
  List<int> labels;
  double errRate;
}

AdaboostModel adaboostTrain(List<Point> trainData, int dimensions, int iterations, {bool doPrint: false, List<Point> testData}) {
  //initalize adaboostModel and data weights
  AdaboostModel adaboostModel = new AdaboostModel();
  adaboostModel.iterations = iterations;
  adaboostModel.classifiers = new List(iterations);
  adaboostModel.alphas = new List(iterations);
  
  int datalen = trainData.length;
  List<double> u = new List.filled(datalen, 1 / datalen); //u(1) = [1/N, ... , 1/N]
  
  //boostiog
  for (int t = 0; t < iterations; t++) {
    //get classifier[t]
    DsaReturn dsaModel = dsaMutiDimension(trainData, u, dimensions);
    
    if(doPrint)
      print('U($t): ${u.fold(0, (prev, element) => prev + element)}');
    
    //update u
    double errorT = dsaModel.errorRate;
    if (doPrint)
      print('g($t): $errorT');
    
    double scalingFactor = pow((1 - errorT) / errorT, 1/2);
//    print('errorT: $errorT, scalingFactor: $scalingFactor');
    for (int i = 0; i < datalen; i++) {
      //incorrect <-- incorrect * scaling
      if(dsaPredict(dsaModel, trainData[i]) != trainData[i].y)
        u[i] *= scalingFactor;
      //correct <-- correct / scaling
      else
        u[i] /= scalingFactor;
    }
    
    //save classifier and its weight
    adaboostModel.classifiers[t] = dsaModel;
    adaboostModel.alphas[t] = log(scalingFactor);
    adaboostModel.dataWeights = u;
    
    if(doPrint) {
      print('alpha($t): ${adaboostModel.alphas[t]}');
      AdaboostPrediction predict_in = adaboostPredict(adaboostModel, trainData);
      print('Ein(Gt): ${predict_in.errRate}');
      AdaboostPrediction predict_out = adaboostPredict(adaboostModel, testData);
      print('Eout(Gt): ${predict_out.errRate}');
    }
      
    if (errorT == 0.0)
      break;
  }
  return adaboostModel;
}

AdaboostPrediction adaboostPredict(AdaboostModel model, List<Point> testData) {
  //initail AdaboostPrediction
  AdaboostPrediction adaboostPrediction = new AdaboostPrediction();
  int datalen = testData.length;
  adaboostPrediction.labels = new List(datalen);
  int errorNum = 0;
  //predict each test data
  for (int i = 0; i < datalen; i++) {
    //initailize
    double predictNum = 0.0;
    //predict
    for(int t = 0; t < model.iterations; t++) {
      if (model.classifiers[t] == null)
        break;
      predictNum += model.alphas[t] * dsaPredict(model.classifiers[t], testData[i]);
    }
    //get predict label
    adaboostPrediction.labels[i] = predictNum > 0? 1: -1;
    //compute error
    errorNum += adaboostPrediction.labels[i] == testData[i].y? 0: 1;
  }
  adaboostPrediction.errRate = errorNum/datalen;
  return adaboostPrediction;
}
