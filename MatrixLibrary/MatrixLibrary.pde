class Matrix {
  private double[][] array;
  
  
  public Matrix(double[][] arr1) {
     array = new double[arr1.length][arr1[0].length];
     for(int i = 0; i < arr1.length; i++) {
       for(int j = 0; j < arr1[0].length; j++) {
         array[i][j] = arr1[i][j];
       }
     }
  }
  public Matrix(int[][] arr1) {
     array = new double[arr1.length][arr1[0].length];
     for(int i = 0; i < arr1.length; i++) {
       for(int j = 0; j < arr1[0].length; j++) {
         array[i][j] = (double)(arr1[i][j]);
       }
     }
  }
  
  public Matrix(int r, int c) {
    array = new double[r][c];
  }
  
  public int rowLength() {
    return array[0].length;
  }
  public int colLength() {
    return array.length;
  }
  public int numOfRows() {
    return array.length;
  }
  public int numOfCols() {
    return array[0].length;
  }
  
  public double rowSum(int n) {
    int sum = 0;
    for(int i = 0; i < array[0].length; i++) {
      sum += array[n][i];
    }
    return sum;
  }
  public double colSum(int n) {
    int sum = 0;
    for(int i = 0; i < array.length; i++) {
      sum += array[i][n];
    }
    return sum;
  }
  
  public void rowSwap(int n1, int n2) {
    double temp = 0;
    for(int i = 0; i < this.rowLength(); i++) {
      temp = array[n1][i];
      array[n1][i] = array[n2][i];
      array[n2][i] = temp;
    }
  }
  
  public double getVal(int r, int c) {
    if(!(r >= 0 && r < this.numOfRows()) || !(c >= 0 && c < numOfCols())) {
      return -999999;
    }
    
    return array[r][c];
  }
  
  public boolean setVal(int r, int c, double n) {
    if(!(r >= 0 && r < this.numOfRows()) || !(c >= 0 && c < numOfCols())) {
      return false;
    }
    array[r][c] = n; 
    return true;
  }
  
  public boolean setVal(int r, int c, int n) {
    if(!(r > 0 && r < this.numOfRows()) || !(c > 0 && c < numOfCols())) {
      return false;
    }
    array[r][c] = n; 
    return true;
  }
  
  
  public void printM() {
    for(int i = 0; i < array.length; i++) {
      for(int j = 0; j < array[0].length; j++) {
        print(array[i][j] + " ");
      }
      println("");
    }  
  }
  
  // Row Echelon Form
  public void ref() {
    for(int i = 0; i < array[0].length - 1; i++) {
      for(int j = i + 1; j < array.length; j++) {
        double coef = 0;
        if(array[j][i] != 0) {
          coef = (array[j][i] / array[i][i]) * -1; 
          for(int n = i; n < array[0].length; n++) {
            array[j][n] += coef * array[i][n];
          }
        }
      }
    }  
  }
  
  // Reduced Row Echelon Form
  public void rref() {
    this.ref();
    for(int j = array[0].length - 2; j >= 0; j--) {
      for(int n = j - 1; n >= 0; n--) {
        array[j][array[0].length - 1] /= array[j][j];
        array[j][j] = 1;
        // this.printM();
        // println("");
        array[n][array[0].length - 1] += array[n][j] * array[j][(array[0].length - 1)] * -1;
        // println(array[n][j] * array[j][(array[0].length - 1)]);
        array[n][j] = 0;
      }
    }
    // Final Check for simplification
    for(int i = array.length - 1; i >= 0; i--) {
      array[i][array[0].length - 1] /= array[i][i];
      array[i][i] = 1;
    }
    // array[i][array[0].length - 1] += array[i+1][array[0].length - 1] * array[i][i+1];
  }
  
  public boolean add(Matrix input) {
    if(!(this.numOfRows() == input.numOfRows() && this.numOfCols() == this.numOfCols())) {
      // println("FAILED ADDITION");
      return false;
    }
    for(int i = 0; i < this.numOfRows(); i++) {
      for(int j = 0; j < this.numOfCols(); j++) {
        this.array[i][j] += input.getVal(i,j);
      }
    }
    
    return true;
  }
  
  public boolean sub(Matrix input) {
    if(!(this.numOfRows() == input.numOfRows() && this.numOfCols() == this.numOfCols())) {
      // println("FAILED ADDITION");
      return false;
    }
    for(int i = 0; i < this.numOfRows(); i++) {
      for(int j = 0; j < this.numOfCols(); j++) {
        this.array[i][j] -= input.getVal(i,j);
      }
    }
    
    return true;
  }
  
  public Matrix mult(Matrix input) {
    if(this.numOfCols() != input.numOfRows()) {
      return null;
    }
    Matrix ret = new Matrix(this.numOfRows(), input.numOfCols());
    double sum = 0;
    for(int i = 0; i < ret.numOfRows(); i++) {
      for(int j = 0; j < ret.numOfCols(); j++) {
        sum = 0;
        for(int n = 0; n < this.numOfCols(); n++) {
          sum += this.array[i][n] * input.getVal(n, j);
        }
        //println(sum);
        ret.setVal(i, j, sum);
      }
    }
    return ret;
  }
  
  public void multNum(double num) {
    for(int i = 0; i < this.numOfRows(); i++) {
      for(int j = 0; j < this.numOfCols(); j++) {
        this.array[i][j] *= num;
      }
    }
  }
  
  public Matrix T() {
    double[][] ret = new double[this.numOfCols()][this.numOfRows()];
    for(int i = 1; i < this.numOfRows(); i++) {
      for(int j = 0; j < this.numOfCols() - 1; j++) {
        ret[j][i] = this.getVal(i, j);
      }
    }
    return new Matrix(ret);
  }
  
  public double det() {
    double ret = 0;
    if(this.numOfCols() != this.numOfRows()) {
      return -999999;
    }
    if(this.numOfCols() == 2) {
      return this.getVal(0,0) * this.getVal(1,1) - this.getVal(1,0) * this.getVal(0,1);
    }
    for(int n = 0; n < this.numOfCols(); n++) {
      double[][] temp1 = new double [this.numOfCols() - 1][this.numOfCols() - 1];
      for(int i = 1; i < this.numOfRows(); i++) {
        for(int j = 0; j < this.numOfCols() - 1; j++) {
          if(j >= n) {
            temp1[i - 1][j] = this.getVal(i,j + 1);
          } else {
            temp1[i - 1][j] = this.getVal(i,j);
          }
        }
      }
      // Create object and and recursively find determinant
      ret += (new Matrix(temp1)).det() * pow(-1, n) * this.getVal(0, n);
      
    }
    
    return ret;
  }
  
  public Matrix inverse() {
    double[][] ret = new double[this
    
    
    return new Matrix(ret);
  }
  
}
