import 'package:hw3_logistic_regression/arg.dart';
import 'package:hw3_logistic_regression/point.dart';
import 'package:hw3_logistic_regression/train_data.dart';
import 'package:hw3_logistic_regression/logistic_regression.dart';

void main(List<String> arguments) {
  final ArgsBoth args = parseArgsBothData(arguments);
  if (args == null)
      return;
  Weight weight;
  getTrainData(args.trainDataPath)
  .then((List<Point21> trainData) {
    weight = trainSGD(trainData, 0.001, 2000);
  })
  .then((_) => getTrainData(args.testDataPath))
  .then((List<Point21> testData) {
    print('Eout: ${zeroOneErrorRate(testData, weight)}');
  });
}