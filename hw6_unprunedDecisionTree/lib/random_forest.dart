library ml_udt.random_forest;

import 'dart:math' hide Point;
import 'point.dart';
import 'unpruned_decision_tree.dart';

class ForestModel {
  int treeNum;
  List<DecisionTreeModel> models;
  
  ForestModel(this.treeNum) {
    models = new List(treeNum);
  }
}

class ForestPrediction {
  double errRate;
  List<int> labels;
}

class FileWrite {
  int round;
  List<StringBuffer> Eout_gt_sbs;
  List<StringBuffer> Ein_gt_sbs;
  List<StringBuffer> Eout_Gt_sbs;
  
  FileWrite(this.round) {
    Eout_gt_sbs = new List(round);
    Ein_gt_sbs = new List(round);
    Eout_Gt_sbs = new List(round);
    for(int i = 0; i < round; i++){
      Eout_gt_sbs[i] = new StringBuffer();
      Eout_gt_sbs[i].write('round$i');
      Ein_gt_sbs[i] = new StringBuffer();
      Ein_gt_sbs[i].write('round$i');
      Eout_Gt_sbs[i] = new StringBuffer();
      Eout_Gt_sbs[i].write('round$i');
    }
  }
  
}
FileWrite fileWriteG;
int now_round = 0;
ForestModel forestTrain(List<Point> trainData, int dimension, int treeNum, {bool doPrint: false, List<Point> testData}) {
  //initialize model
  int datalen = trainData.length;
  ForestModel forestModel = new ForestModel(treeNum);
  
  for (int i = 0; i < treeNum; i++) {
    List<Point> newTrainData = new List(datalen);
    Random ran = new Random(new DateTime.now().millisecondsSinceEpoch);
    for (int j = 0; j < datalen; j++) {
      newTrainData[j] = trainData[ran.nextInt(datalen)];
    }
    forestModel.models[i] = decisionTreeTrain(newTrainData, dimension);
    if (doPrint) {
      fileWriteG.Eout_gt_sbs[now_round].write(',${decisionTreePredict(forestModel.models[i], testData).errRate}');
      fileWriteG.Ein_gt_sbs[now_round].write(',${decisionTreePredict(forestModel.models[i], trainData).errRate}');
      fileWriteG.Eout_Gt_sbs[now_round].write(',${forestPredict(forestModel, testData).errRate}');
    }
  }
  return forestModel;
}

ForestPrediction forestPredict(ForestModel model, List<Point> testData) {
  ForestPrediction forestPrediction = new ForestPrediction();
  int datalen = testData.length;
  forestPrediction.errRate = 0.0;
  forestPrediction.labels = new List(datalen);
  
  int errorNum = 0;
  for (int i = 0; i < datalen; i++) {
    double label = 0.0;
    for(int t = 0; t < model.treeNum; t++) {
      if(model.models[t] == null)
        break;
      label += decisionTreePredictOnePoint(model.models[t], testData[i]);
    }
    forestPrediction.labels[i] = label >= 0? 1: -1;
    if (forestPrediction.labels[i] != testData[i].y)
      errorNum++;
  }
  forestPrediction.errRate = errorNum / datalen;
  return forestPrediction;
}