library ml_hw1.pla;

import 'dart:math' show Random;

import "package:PLA/arg.dart";
import "package:PLA/point.dart";
import "package:PLA/train_data.dart";
import "package:PLA/pla.dart";

const int ROUNDS = 2000;

void main(List<String> arguments) {
  final ArgsPLA args = parseArgsPLA(arguments);
  if (args == null)
      return;
  
  getTrainData(args.path)
  .then((List<Point> _){
    int averageUpdate = 0;
    for (int i = 0; i < ROUNDS; i++)
      averageUpdate += plaRamdom(_, new DateTime.now().millisecondsSinceEpoch, updateScale: 0.5);
    print('averge updates: ${averageUpdate ~/ ROUNDS}');
  });  
}