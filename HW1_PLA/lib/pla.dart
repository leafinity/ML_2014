library ml_pla.pla;

import 'dart:math' show Random;
import "point.dart";

part 'pla_src/util.dart';

/** for all PLA futions, return the number of updates
 *  [plaOrder] would using the order of data set 
 */
int plaOrder(List<Point> trainData, {double updateScale: 1.0}) {
  int correctNum = 0;
  int update = 0;
  Weight weight = new Weight(0.0, 0.0, 0.0, 0.0);
  int dataLen =trainData.length;
  for(int t = 0;; t++) {
    if (!_hasMistake(correctNum, dataLen)) {
      break;
    } else if (_pointIsWrong(trainData[t % dataLen], weight)) {
      update++;
      weight = _correctWeight(trainData[t % dataLen], weight, updateScale);
      correctNum = 0;
    } else {
      correctNum++;
    }
  }
  return update;
}

/** [plaRamdom] would run in random sequece by using given [randomSeed]
 *  and it return the number of updates
 */
int plaRamdom(List<Point> trainData, int randomSeed, {double updateScale: 1.0}) {
  int dataLen = trainData.length;
    
  List<int> seq = randomSeq(randomSeed, dataLen);
    
  int correctNum = 0;
  int update = 0;
  Weight weight = new Weight(0.0, 0.0, 0.0, 0.0);
    
  for(int t = 0;; t++) {
    if (!_hasMistake(correctNum, dataLen)) {
      break;
    } else if (_pointIsWrong(trainData[seq[t % dataLen]], weight)) {
      update++;
      weight = _correctWeight(trainData[seq[t % dataLen]], weight, updateScale);
      correctNum = 0;
    } else {
      correctNum++;
    }
  }
  return update;
}

/** it return the final weight
 */
Weight pocket(List<Point> trainData, int randomSeed , {int updateRounds: 50, double updateScale: 1.0}) {
  Weight BestWeight = new Weight(0.0, 0.0, 0.0, 0.0);
  Weight weight = new Weight(0.0, 0.0, 0.0, 0.0);
  int BestErrorNum = _getErrorNum(BestWeight, trainData);
  int dataLen = trainData.length;
  int update = 0;

  while(true) {
    if (update >= updateRounds)
      break;
    
    List<int> seq = randomSeq(randomSeed, dataLen);
    for(int t = 0; t < dataLen; t++) {
      if (update >= updateRounds) {
        break;
      } else if (_pointIsWrong(trainData[seq[t]], weight)) {
        weight = _correctWeight(trainData[seq[t]], weight, updateScale);
        int errorNum = _getErrorNum(weight, trainData);
        if (errorNum <= BestErrorNum) {
          BestErrorNum = errorNum;
          BestWeight = weight;
        }
        update++;
      }
    }
  }
  return BestWeight;
}

/** it is more like PLA, since it do not keep the best weight,
 *  and it return the final weight
 */
Weight pocketLikePLA(List<Point> trainData, int randomSeed , {int updateRounds: 50, double updateScale: 1.0}) {
  Weight weight = new Weight(0.0, 0.0, 0.0, 0.0);
  int dataLen = trainData.length;
  int update = 0;

  while(true) {
    if (update >= updateRounds)
      break;
    
    List<int> seq = randomSeq(randomSeed, dataLen);
    for(int t = 0; t < dataLen; t++) {
      if (update >= updateRounds) {
        break;
      } else if (_pointIsWrong(trainData[seq[t]], weight)) {
        weight = _correctWeight(trainData[seq[t]], weight, updateScale);
        update++;
      }
    }
  }
  return weight;
}

/** return the remanding errorNum by testing weight
 */
int testWeight(Weight weigth, List<Point> data)
  => _getErrorNum(weigth, data);