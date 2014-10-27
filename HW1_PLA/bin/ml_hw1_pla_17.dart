library ml_hw1.pla;

import 'dart:math' show Random;

import "package:pla_r4/arg.dart";
import "package:pla_r4/point.dart";
import "package:pla_r4/train_data.dart";
import "package:pla_r4/pla.dart";

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