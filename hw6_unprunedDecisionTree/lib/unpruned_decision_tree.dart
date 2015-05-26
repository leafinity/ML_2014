library ml_udt.unprunedDecisionTree;

import 'point.dart';
import 'decision_stumps.dart';

class DecisionTreeModel {
  TreeNode root;
}
class DecisionTreePrediction{
  List<int> labels;
  double errRate;
}
class TreeNode {
  DsaReturn model;//for non-leaf
  int label;//for leaf
  
  TreeNode left;//label = -1
  TreeNode right;//label = 1
  
  bool isLeaf;
  
  TreeNode({this.isLeaf: false}); 
}

int dim;
bool printBranchG;
DecisionTreeModel decisionTreeTrain(List<Point> trainData, int dimensions, {bool printBranch: false}) {
  dim = dimensions;
  printBranchG = printBranch;
  DecisionTreeModel decisionTreeModel = new DecisionTreeModel()
    ..root = _createNode(trainData);
  
  return decisionTreeModel;
}

DecisionTreePrediction decisionTreePredict(DecisionTreeModel model, List<Point> testData) {
  //initail DecisionTreePrediction
  int datalen = testData.length;
  DecisionTreePrediction decisionTreePrediction = new DecisionTreePrediction();
  decisionTreePrediction.labels = new List(datalen);
  int errorNum = 0;
  
  //predict labels
  for (int i = 0, len = testData.length; i < len; i++) {
    decisionTreePrediction.labels[i] = decisionTreePredictOnePoint(model, testData[i]);
    if (decisionTreePrediction.labels[i] != testData[i].y)
      errorNum++;
  }
  
  decisionTreePrediction.errRate = errorNum / datalen;
  return decisionTreePrediction;
}

int i = 0;
TreeNode _createNode(List<Point> trainData) {
  if(printBranchG) {
    print('now: $i');
    //print('train: $trainData');
  }
  i++;
  
  //if termination criteria met
  TreeNode node;
  if (_metTermination(trainData)) {
    node = new TreeNode(isLeaf: true);
    node.label = trainData[0].y;
    if (printBranchG)
      print('leaf: ${node.label}');
  } else {
    node = new TreeNode();
    //learn branching criteria b(x)
    DsaReturn dsaModel = dsaMutiDimension(trainData, dim);
    List<Point> positiveData = new List();
    List<Point> negtiveData = new List();
    //split Data
    //print('dsaModel: ${dsaModel.dimension}, ${dsaModel.direction}, ${dsaModel.threshold}');
    for (Point p in trainData) {
      if (dsaPredict(dsaModel, p) >= 0)
        positiveData.add(p);
      else
        negtiveData.add(p);
    }
    if (positiveData.length == 0) {
      node.isLeaf = true;
      node.label = -1;
      if (printBranchG)
        print('leaf: ${node.label}');
    } else if (negtiveData.length == 0) {
      node.isLeaf = true;
      node.label = 1;
      if (printBranchG)
        print('leaf: ${node.label}');
    } else {
      node.model = dsaModel;
      node.left = _createNode(negtiveData);
      node.right = _createNode(positiveData);
    }
  }
  return node;
}

bool _metTermination(List<Point> trainData) {
  if (trainData.length == 1)
    return true;
  bool yIsSame = true, xIsSame = true;
  int y;
  List<double> lastX;
  for (Point p in trainData) {
    if(y == null) {
      y = p.y;
      lastX= new List.generate(dim, (int i) => p.getX(i + 1));
    } else {
      if (p.y != y)
        yIsSame = false;
      List<double> x = new List.generate(dim, (int i) => p.getX(i + 1));
      for (int i = 0; i < dim; i++) {
        if(x[i] != lastX[i]) {
          xIsSame = false;
          break;
        }
      }
    }
    if (!yIsSame && !xIsSame)
      return false;
  }
  return true;
}

int decisionTreePredictOnePoint(DecisionTreeModel model, Point datum) {
  TreeNode treeNode = model.root;
  while(!treeNode.isLeaf) {
    if (dsaPredict(treeNode.model, datum) >= 0)
      treeNode = treeNode.right;
    else treeNode = treeNode.left;
  }
  return treeNode.label;
}