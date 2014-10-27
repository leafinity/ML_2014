part of ml_dsa.dsa;

double _getDsaEin(List<Point> trainData, int dimension) {
  trainData = _sortData(trainData);
  int bestCorrectNum = 0;
  double lastX = -1.0;
  
  for (int i = 0, len = trainData.length; i < len; i++) {
    double threshold = (lastX + trainData[i].getX(dimension)) / 2;
    int correctNum = 0;
    
    // > threshold is circle
    for (int j = 0, len = trainData.length; j < len; j++) {
      if ((trainData[j].getX(dimension) < threshold && trainData[j].y < 0)
            ||(trainData[j].getX(dimension) > threshold && trainData[j].y > 0))
        correctNum++;
    }  
    if (correctNum > bestCorrectNum) {
      bestCorrectNum = correctNum;
      bestThreshold = threshold;
    }
    correctNum = 0;
    
    // < threshold  is circle
    for (int j = 0, len = trainData.length; j < len; j++) {
      if ((trainData[j].getX(dimension) < threshold && trainData[j].y > 0)
            ||(trainData[j].getX(dimension) > threshold && trainData[j].y < 0))
        correctNum++;
    }
    if (correctNum > bestCorrectNum) {
      bestCorrectNum = correctNum;
      bestThreshold = -1 * threshold;
    }
  }
  return ((trainData.length - bestCorrectNum)/trainData.length);
}

DsaReturn _dsaMutiDimension(List<Point> trainData, int maxDimension) {
  double bestER = 1.0, bestTH;
  int bestD;
  for (int i = 1; i <= maxDimension; i++) {
    double er = _getDsaEin(trainData, i);
    if (er < bestER) {
      bestER = er;
      bestTH = bestThreshold;
      bestD = i;
    }
  }
  return new DsaReturn(bestER, bestTH, bestD);
}

double _getEoutOfDsa(List<Point> testData, double threshold, int dimension) {
  int errorNum = 0;
  int sign = threshold > 0? 1: -1;
  threshold *= threshold > 0? 1: -1;
  for (int i = 0, len = testData.length; i < len; i++) {
    if(getSign(testData[i].getX(dimension), sign, threshold) != testData[i].y)
      errorNum++;
  }
  return errorNum / testData.length;
}

List<Point> _sortData(List<Point> data, [int dimension = 1]) {
  data.sort((Point a,  Point b) {
    if(a.getX(dimension) - b.getX(dimension) > 0)
      return 1;
    else if (a.getX(dimension) - b.getX(dimension) == 0)
      return 0;
    else 
      return -1;
  });
  return data;
}

getSign(double x, int sign, double threshold) {
  double y = sign * (x - threshold);
  return y > 0? 1: y ==0? 0: -1;
}