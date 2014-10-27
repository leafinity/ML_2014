library ml_dsa.point;

class Point {
  
  List<double> _x;
  int y;
  
  double getX(int dimension) => _x[dimension -1];
  
  Point(this._x, this.y);
  
  String toString() => 'point: ($_x, $y)';
  
}

class Point1 extends Point {
  
  double get x1 => _x[0];
  
  Point1(List<double> inputX, int inputY)
    :super(inputX, inputY);
}

class Point9 extends Point {

  double get x1 => _x[0];
  double get x2 => _x[1];
  double get x3 => _x[2];
  double get x4 => _x[3];
  double get x5 => _x[4];
  double get x6 => _x[5];
  double get x7 => _x[6];
  double get x8 => _x[7];
  double get x9 => _x[8];
  
  Point9(List<double> inputX, int inputY)
    :super(inputX, inputY);
}

class DsaReturn {
  double errorRate;
  double threshold;
  int dimension;
  
  DsaReturn(this.errorRate, this.threshold, this.dimension);
}