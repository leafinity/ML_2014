library ml_ada.dsa;

import 'point.dart';

part 'src/decision_stumps/util.dart';

DsaReturn dsaMutiDimension(List<AdaboostTrainData> trainData, int dimensionNum)
  => _dsaMutiDimension(trainData, dimensionNum);

int dsaPredict(DsaReturn model, Point point) {
  double thrs = model.threshold;
  int dir = model.direction;
  int dim = model.dimension;
  double y = dir * (point.getX(dim) - thrs);
  return y > 0? 1: -1; 
}