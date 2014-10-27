library ml_hw2.dsa19;

import 'package:decision_stump/arg.dart';
import 'package:decision_stump/train_data.dart';
import 'package:decision_stump/point.dart';
import 'package:decision_stump/dsa.dart';


void main(List<String> arguments) {
  final ArgsTrain args = parseArgsTrainData(arguments);
  if (args == null)
      return;
  
  getTrainData(args.path)
  .then((List<Point> _){
    DsaReturn answer = dsaMutiDimension(_, 9);
    print('average error rate: ${answer.errorRate}');
  });  
}