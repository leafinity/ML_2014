library ml_hw1.pocket;

import 'dart:async';

import "package:PLA/arg.dart";
import "package:PLA/point.dart";
import "package:PLA/train_data.dart";
import "package:PLA/pla.dart";

const int ROUNDS = 2000;

void main(List<String> arguments) {
  final ArgsPocket args = parseArgsPocket(arguments);
  if (args == null)
      return;
  
  double averageErrorRate = 0.0;
  
  getTrainData(args.trainDataPath)
  .then((List<Point> trainData) {
    List a = new List.generate(ROUNDS, (int round) => round);
    Weight weight;
    return Future.forEach(a, (e) {
      weight = pocketLikePLA(trainData, new DateTime.now().millisecondsSinceEpoch);
      return getTrainData(args.testDataPath)
      .then((List<Point> testData) { 
          print('turn $e: ${testWeight(weight, testData) / testData.length}');
          averageErrorRate += testWeight(weight, testData) / testData.length;
      });
    });
  }).then((_) => print(averageErrorRate / ROUNDS));
}