library ml_regularized.point;

class Point {
  
  List<double> _x;
  int y;
  
  double getX(int dimension) => _x[dimension -1];
  
  double operator[](int index) => _x[index];
  
  Point(this._x, this.y);
  
  String toString() => 'point: ($_x, $y)';
  
}

class Wreg {
  List<double> _w;
  
  double operator[](int index) => _w[index];
    
  Wreg(this._w);
  
  String toString() => 'weight: $_w';
}