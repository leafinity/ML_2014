library matrix;

class Row {
  List<double> _elms;
  int elmsNum;
  double operator[](int index) => _elms[index];
  
  Row(this._elms) {
    elmsNum = _elms.length;
  }
}

class Matrix {
  List<Row> _rows;
  int m, n;
  Row operator[](int index) => _rows[index];
  
  Matrix(this._rows) {
    m = _rows.length;
    n = _rows[0].elmsNum;
  }
  
  Matrix.from(Matrix m2) {
    List<Row> rows = new List(m2.m);
    for(int i = 0; i < m; i++) {
      List<double> row = new List();
      for (int j = 0; j < n; j++) {
        row.add(this[j][i]);
      }
      rows[i] = new Row(row);
    }
  }
  
  Matrix.filled(this.m, this.n, double e) {
    List<Row> rows = new List(m);
    for(int i = 0; i < m; i++) {
      List<double> row = new List();
      for (int j = 0; j < n; j++) {
        row.add(e);
      }
      rows[i] = new Row(row);
    }
  }
  
  Matrix operator+(Matrix m2) {
    Matrix m1 = new Matrix.from(this);
    for(int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        m1[i][j] += m2[i][j];
      }
    }
    return m1;
  }
      
  
  Matrix operator*(int muti) {
    Matrix m1 = new Matrix.from(this);
    for(int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
            m1[i][j] *= muti;
      }
    }
    return m1;
  }
  
  Matrix multi(Matrix a) {
    //TODO matrix * matrix
    return this;
  }
  
  Matrix trasfer() {
    List<Row> rows = new List();
    for(int i = 0; i < n; i++) {
      List<double> row = new List();
      for (int j = 0; j < m; j++) {
        row.add(this[j][i]);
      }
      rows.add(new Row(row));
    }
    return new Matrix(rows);
  }
  
  Matrix inverse() {
    //TODO: inverse
    return this;
  }
}