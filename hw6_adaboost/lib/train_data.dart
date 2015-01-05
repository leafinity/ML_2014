library ml_ada.train_data;

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
  List<double> x = new List();
  int i = 0;
  for (;; i++) {
    if (pointStr[i].compareTo(' ') != 0 && pointStr[i].compareTo('\t') != 0)
      break;
  }
  for (int len = pointStr.length; i < len; i++) {
    if (pointStr[i] == ' ' || pointStr[i] == '\t') {
      if (pointStr[i+1] == ' ')
        continue;
      double a;
      try {
        a = double.parse(pointStr.substring(start, i));
      } catch(e) {
        print('str ${pointStr.substring(start, i)}, $e');
      }
      x.add(double.parse(pointStr.substring(start, i)));
      start = i + 1;
    }
  }
  int y= int.parse(pointStr.substring(start));

  return new Future.value(new Point(x, y));
}