part of ml_pla.pla;

int sign(Point p, Weight w) {
  double side = w.w0 * p.x0 + w.w1 * p.x1 + w.w2 * p.x2 + w.w3 * p.x3 + w.w4 * p.x4;
  if (side > 0.0)
    return 1;
  return -1;
}

int _getErrorNum(Weight w, List<Point> trainData) {
  int num = 0;
  for (int i = 0, len = trainData.length; i < len; i++) {
    if (sign(trainData[i], w) != trainData[i].y)
      num++;
  }
  return num;
}


bool _hasMistake(int correctNum, int dataNum) {
  return correctNum < dataNum;
}

bool _pointIsWrong(Point p, Weight w) {
  if (sign(p, w) == p.y) 
    return false; // is not wrong
  else
    return true;
}

Weight _correctWeight(Point p, Weight w, double scale) {
  return w.add(p, scale);
}

List<int> randomSeq(int seed, int length) {
  List<int> seq = new List(length);
  List<bool> flags = new List.filled(length, false);
  Random ran = new Random(seed);
  for (int j = 0; j < length;) {
    int index = ran.nextInt(length);
    if (flags[index] ==false) {
      seq[j] = index;
      flags[index] = true;
      j++;
    }
  }
  
  return seq;
}