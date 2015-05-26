import 'dart:io';
import 'dart:math';

void main() {
  File file = new File('hw6_20_eout_gt_small.csv'); 
  List<String> lines = file.readAsLinesSync();
  
  List<List<double>> nums = new List(lines.length - 1);
  for (int i = 1; i < lines.length; i++) {
    nums[i - 1] = new List(300);
    int j = 0;
    int start = lines[i].indexOf(',') + 1;
    while(true) {
      int index = lines[i].indexOf(',', start);
      if (index == -1)
        break;
      nums[i - 1][j++] = double.parse(lines[i].substring(start, index));
      start = index + 1;
    }
    nums[i - 1][j] = double.parse(lines[i].substring(start));
  }
  int len = nums[0].length;
  for (int i = 0; i < len; i++) {
    double sum = nums.fold(0, (prev, element) => prev + element[i]);
    double mean = sum / len;
    double var_sum = nums.fold(0, (prev, element) => prev + pow(element[i] - mean, 2));
    print('when t = $i, variance = ${var_sum / len}');
  }
}