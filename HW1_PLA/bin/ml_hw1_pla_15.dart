library ml_hw1.pla;

import 'dart:math' show Random;

import "package:pla_r4/arg.dart";
import "package:pla_r4/point.dart";
import "package:pla_r4/train_data.dart";
import "package:pla_r4/pla.dart";

Random ran = new Random(new DateTime.now().millisecondsSinceEpoch);

void main(List<String> arguments) {
  final ArgsPLA args = parseArgsPLA(arguments);
  if (args == null)
      return;
  
  getTrainData(args.path)
  .then((List<Point> _){
    print('updates: ${plaOrder(_)}');
  });  
}







