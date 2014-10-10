library ml_hw1.train_data;

import 'dart:async';
import 'dart:io';

import 'point.dart';

List<Point> _trainData;

Future getTrainData(String path) {
  File data = new File(path);
  return data.readAsLines()
  .then((List<String> data) {
    _trainData = new List();
    return Future.forEach(data, 
      (e) => _handleData(e)
      .then((Point point) => _trainData.add(point)));
  })
  .then((_) => new Future.value(_trainData));
}

Future<Point> _handleData(String pointStr) {
  int start = 0;
  List<String> numStrs = new List();
  for (int i = 0, len = pointStr.length; i < len; i++) {
    if (pointStr[i] == ' ' || pointStr[i] == '\t') {
      if (pointStr[i+1] == ' ')
        continue;
      numStrs.add(pointStr.substring(start, i));
      start = i + 1;
    }
  }
  numStrs.add(pointStr.substring(start));

  return new Future.value(new Point(double.parse(numStrs[0]), double.parse(numStrs[1]),
      double.parse(numStrs[2]), double.parse(numStrs[3]), int.parse(numStrs[4])));
}