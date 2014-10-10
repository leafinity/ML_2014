library ml_hw1.point;

int getY(Point p, Weight w) {
  double side = w.w1 * p.x1 + w.w2 * p.x2 + w.w3 * p.x3 + w.w4 * p.x4;
  if (side > 0.0)
    return 1;
  return -1;
}
class Point {
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
      print('error: out of range');
      return -1.0;
  }
  String toString() => 'point: ($x1, $x2, $x3, $x4, $y)';
}

class Weight {
  double w0; // -threshold
  double w1;
  double w2;
  double w3;
  double w4;
  
  Weight(this.w1, this.w2, this.w3, this.w4, [double threshold = 0.0]) {
    w0 = 0 - threshold;
  }
  
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
      print('error: out of range');
      return -1.0;
  }
  
  add(Point p, int direct)
    => new Weight(
    w1 + direct * p.x1,
    w2 + direct * p.x2,
    w3 + direct * p.x3,
    w4 + direct * p.x4
    );
  
  String toString() => 'weight: ($w1, $w2, $w3, $w4)';
}