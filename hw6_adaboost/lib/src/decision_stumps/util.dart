part of ml_ada.dsa;

class DsaReturn {
  double errorRate;
  double threshold;
  int direction;
  int dimension;
  
  DsaReturn(this.errorRate, this.threshold, this.direction, this.dimension);
}

DsaReturn _linearseparationOneDimension(List<AdaboostTrainData> trainData, int dimension) {
  trainData = _sortData(trainData, dimension);
  double tatalWeight = trainData.fold(0, (prev, element) => prev + element.weight);
  double lastX = 0.0;
  
  double bestErrRate = 1.0;
  double bestThreshold;
  int direction;
  
  for (int i = 0, len = trainData.length; i <= len; i++) {
    double threshold;
    if (i == len)
      threshold = (lastX + 1.0) / 2;
    else
      threshold = (lastX + trainData[i].point.getX(dimension)) / 2;
    double errRate = 0.0;
    
    // > threshold is circle( y > 0)
    for (int j = 0, len = trainData.length; j < len; j++) {
      if ((trainData[j].point.getX(dimension) < threshold/*X*/&& trainData[j].point.y > 0/*O*/)
            ||(trainData[j].point.getX(dimension) > threshold/*O*/ && trainData[j].point.y < 0/*X*/))
        errRate += 1 * trainData[j].weight;
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
      if ((trainData[j].point.getX(dimension) < threshold/*O*/ && trainData[j].point.y < 0/*X*/)
            ||(trainData[j].point.getX(dimension) > threshold/*X*/ && trainData[j].point.y > 0)/*O*/)
        errRate+= 1 * trainData[j].weight;
    }
    errRate /= tatalWeight;
    if (errRate < bestErrRate) {
      bestErrRate = errRate;
      bestThreshold = threshold;
      direction = -1;
    }
    if (i < len)
      lastX = trainData[i].point.getX(dimension);
  }
  return new DsaReturn(bestErrRate, bestThreshold, direction, dimension);
}

DsaReturn _dsaMutiDimension(List<AdaboostTrainData> trainData, int maxDimension) {
  double bestER = 1.0, bestTH;
  int bestDirection, bestDimension;
  for (int i = 1; i <= maxDimension; i++) {
    DsaReturn model = _linearseparationOneDimension(trainData, i);
    if (model.errorRate < bestER) {
      bestER = model.errorRate;
      bestTH = model.threshold;
      bestDirection = model.direction;
      bestDimension = model.dimension;
    }
  }
  return new DsaReturn(bestER, bestTH, bestDirection, bestDimension);
}

List<AdaboostTrainData> _sortData(List<AdaboostTrainData> data, [int dimension = 1]) {
  data.sort((AdaboostTrainData a,  AdaboostTrainData b) {
    if(a.point.getX(dimension) > b.point.getX(dimension))
      return 1;
    else if (a.point.getX(dimension) == b.point.getX(dimension))
      return 0;
    else 
      return -1;
  });
  return data;
}