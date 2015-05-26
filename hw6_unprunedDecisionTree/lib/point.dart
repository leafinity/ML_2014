library ml_ada.point;

class Point {
  
  List<double> _x;
  int y;
  
  double getX(int dimension) => _x[dimension -1];
  
  Point(this._x, this.y);
  
  String toString() => 'point: ($_x, $y)';
  
}