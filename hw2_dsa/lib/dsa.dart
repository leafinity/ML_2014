library ml_dsa.dsa;

import 'point.dart';

part 'src/dsa_util.dart';

double bestThreshold;

double getDsaEin(List<Point> trainData, int dimension)
  =>  _getDsaEin(trainData, dimension);

DsaReturn dsaMutiDimension(List<Point> trainData, int dimensionNum)
  => _dsaMutiDimension(trainData, dimensionNum);

double getEoutOfDsa(List<Point> testData, double threshold, int dimension)
  => _getEoutOfDsa(testData, threshold, dimension);
