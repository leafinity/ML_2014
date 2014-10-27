library ml_hw2.dsa20;

import 'package:decision_stump/arg.dart';
import 'package:decision_stump/train_data.dart';
import 'package:decision_stump/point.dart';
import 'package:decision_stump/dsa.dart';

void main(List<String> arguments) {
  final ArgsBoth args = parseArgsBothData(arguments);
  if (args == null)
      return;
  
  DsaReturn answer;
  
  getTrainData(args.trainDataPath)
  .then((List<Point> trainData) {
    answer = dsaMutiDimension(trainData, 9);
    print('threshold: ${answer.threshold}');
  })
  .then((_) => getTrainData(args.testDataPath))
  .then((List<Point> testData) {
    print('Eout: ${getEoutOfDsa(testData, answer.threshold, answer.dimension)}');
  });
}