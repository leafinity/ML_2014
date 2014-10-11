library ml_hw1.pla;

import 'dart:math' show Random;

import "package:PLA/arg.dart";
import "package:PLA/point.dart";
import "package:PLA/train_data.dart";
import "package:PLA/pla.dart";

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







