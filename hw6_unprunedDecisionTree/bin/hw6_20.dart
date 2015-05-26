library ml_udt.hw6_19;

import 'dart:io';
import 'package:hw6_unprunedDecisionTree/train_data.dart';
import 'package:hw6_unprunedDecisionTree/random_forest.dart';
import 'src/config.dart';

int round = 100;
List trainData, testData;
void main() {
  getTrainData(trainDataPath)
   .then((_) {
    trainData = _;
    return getTrainData(testDataPath);
  })
  .then((_) {
    testData = _;
    double errIn = 0.0, errOut = 0.0;
    fileWriteG = new FileWrite(round);
    for (int i = 0; i < round; i++) {
      ForestModel model = forestTrain(trainData, 2, 300, doPrint: true, testData: testData);
      now_round++;
    }
    File file1 = new File('hw6_20_ein_gt.csv');
    if (file1.existsSync()) {
      file1.deleteSync();
    }
    file1.createSync();

    File file2 = new File('hw6_20_eout_gt_small.csv');
    if (file2.existsSync()) {
      file2.deleteSync();
    }
    file2.createSync();

    File file3 = new File('hw6_20_eout_Gt.csv');
    if (file3.existsSync()) {
      file3.deleteSync();
    }
    file3.createSync();
    
    //write title
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < 300; i++) {
      sb.write(',t=$i');
    }
    file1.writeAsStringSync(sb.toString() + '\n', mode: FileMode.APPEND);
    file2.writeAsStringSync(sb.toString() + '\n', mode: FileMode.APPEND);
    file3.writeAsStringSync(sb.toString() + '\n', mode: FileMode.APPEND);
    
    for(int i = 0; i < round; i++) {
      file1.writeAsStringSync(fileWriteG.Ein_gt_sbs[i].toString() + '\n', mode: FileMode.APPEND);
      file2.writeAsStringSync(fileWriteG.Eout_gt_sbs[i].toString() + '\n', mode: FileMode.APPEND);
      file3.writeAsStringSync(fileWriteG.Eout_Gt_sbs[i].toString() + '\n', mode: FileMode.APPEND);
    }
    print('done');
  });
}