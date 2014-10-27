library ml_pla.point;

class Point {
  double x0 = 1.0;
  double x1;
  double x2;
  double x3;
  double x4;
  int y;
  
  Point(this.x1, this.x2, this.x3, this.x4, this.y);
  
  double operator[](int index) {
    if (index == 0)
      return x1;
    else if(index == 1)
      return x2;
    else if(index == 2)
      return x3;
    else if(index == 3)
      return x4;
    else 
      throw new StateError('out of range');
  }
  
  String toString() => 'point: ($x0, $x1, $x2, $x3, $x4, $y)';
}

class Weight {
  double w0;
  double w1;
  double w2;
  double w3;
  double w4;
  
  Weight(this.w1, this.w2, this.w3, this.w4, {this.w0: 0.0});
  
  double operator[](int index) {
    if (index == 0)
      return w1;
    else if(index == 1)
      return w2;
    else if(index == 2)
      return w3;
    else if(index == 3)
      return w4;
    else 
      throw new StateError('out of range');
  }
  
  add(Point p, [double scale = 1.0])
    => new Weight(w1 + p.y * p.x1 * scale, w2 + p.y * p.x2 * scale, w3 + p.y * p.x3 * scale,
        w4 + p.y * p.x4 * scale, w0: w0 + p.y * p.x0 * scale);
  
  String toString() => 'weight: ($w0, $w1, $w2, $w3, $w4)';
}