part of ml_dsa.dsa;

class DsaReturn {
  double errorRate;
  double threshold;
  int direction;
  int dimension;
  
  DsaReturn(this.errorRate, this.threshold, this.direction, this.dimension);
}

DsaReturn _linearseparationOneDimension(List<Point> trainData, List<double> dataWeight, int dimension) {
  trainData = _sortData(trainData, dimension);
//  print(dataWeight);
  double tatalWeight = dataWeight.fold(0, (prev, element) => prev + element);
  double lastX = 0.0;
  
  double bestErrRate = 1.0;
  double bestThreshold;
  int direction;
  
  for (int i = 0, len = trainData.length; i <= len; i++) {
    double threshold;
    if (i == len)
      threshold = (lastX + 1.0) / 2;
    else
      threshold = (lastX + trainData[i].getX(dimension)) / 2;
    double errRate = 0.0;
    
    // > threshold is circle( y > 0)
    for (int j = 0, len = trainData.length; j < len; j++) {
      if ((trainData[j].getX(dimension) < threshold/*X*/&& trainData[j].y > 0/*O*/)
            ||(trainData[j].getX(dimension) > threshold/*O*/ && trainData[j].y < 0/*X*/))
        errRate += 1 * dataWeight[j];
    }
    errRate /= tatalWeight;
    if (errRate < bestErrRate) {
      bestErrRate = errRate;
      bestThreshold = threshold;
      direction = 1; // < threshold
    }
    errRate = 0.0;
    
    // < threshold  is wrong
    for (int j = 0, len = trainData.length; j < len; j++) {
      if ((trainData[j].getX(dimension) < threshold/*O*/ && trainData[j].y < 0/*X*/)
            ||(trainData[j].getX(dimension) > threshold/*X*/ && trainData[j].y > 0)/*O*/)
        errRate+= 1 * dataWeight[j];
    }
    errRate /= tatalWeight;
    if (errRate < bestErrRate) {
      bestErrRate = errRate;
      bestThreshold = threshold;
      direction = -1;
    }
    if (i < len)
      lastX = trainData[i].getX(dimension);
  }
  return new DsaReturn(bestErrRate, bestThreshold, direction, dimension);
}

DsaReturn _dsaMutiDimension(List<Point> trainData, List<double> dataWeight, int maxDimension) {
  double bestER = 1.0, bestTH;
  int bestDirection, bestDimension;
  for (int i = 1; i <= maxDimension; i++) {
    DsaReturn model = _linearseparationOneDimension(trainData, dataWeight, i);
    if (model.errorRate < bestER) {
      bestER = model.errorRate;
      bestTH = model.threshold;
      bestDirection = model.direction;
      bestDimension = model.dimension;
    }
  }
  return new DsaReturn(bestER, bestTH, bestDirection, bestDimension);
}

double _getEoutOfDsa(List<Point> testData, DsaReturn dsaModel) {
  int dimension = dsaModel.dimension;
  double threshold = dsaModel.threshold;
  int errorNum = 0;
  int sign = dsaModel.direction;
  for (int i = 0, len = testData.length; i < len; i++) {
    if(getSign(testData[i].getX(dimension), sign, threshold) != testData[i].y)
      errorNum++;
  }
  return errorNum / testData.length;
}

List<Point> _sortData(List<Point> data, [int dimension = 1]) {
  data.sort((Point a,  Point b) {
    if(a.getX(dimension) > b.getX(dimension))
      return 1;
    else if (a.getX(dimension) == b.getX(dimension))
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