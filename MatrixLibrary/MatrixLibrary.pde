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
  
  
  public double[] rowGet(int r, int mult) {
    double[] ret = new double[this.numOfCols()];
    for(int i = 0; i < array[0].length; i++) {
      ret[i] = array[r][i] * mult;
    }
    return ret;
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
    double coef;
    // Step through each row (excluding the last one)
    for(int i = 0; i < array.length - 1; i++) {
      
      // Check to see if we have a zero in the first spot
      int temp = 0;
      boolean t = false;
      if(array[i][i] == 0) {
        t = true;
        // If so, search for the first non-zero spot along the same column
        for(int n = i + 1; n < array.length; n++) {
          if(t && array[n][i] != 0){
            temp = n;
            t = false;
          }
        }
        // If the search was unsuccessful, return with current total operation
        if(t) {
          return;
        }
        
        // Otherwise, swap rows and continue operation 
        this.rowSwap(i, temp);
      }
      
      // Ensure that first spot is 1 
      if(array[i][i] != 1) {
        // Divide entire array by first number to simply coeficient
        double c = array[i][i];
        for(int n = i; n < array[0].length; n++) {
          array[i][n] = array[i][n]/c;  
        }
      }
      
      // Step through each row after the current row
      for(int j = i + 1; j < array.length; j++) {
        // println("i=" + i + " j=" + j);
        // Check to see if row operation is needed 
        if(array[j][i] != 0) {
          // println(array[j][i] + " " + array[i][i] + "  i=" + i + " j=" + j);
          // Apply row operation to zero position
          coef = array[j][i] * -1;
          for(int n = i; n < array[0].length; n++) {
            array[j][n] = coef * array[i][n] + array[j][n];  
          }
        }
      }
    }
    
    // Finally, simplify final row (if needed)
    if(array[array.length - 1][array.length - 1] != 1) {
      // Divide entire array by first number to simply coeficient
      double c = array[array.length - 1][array.length - 1];
      for(int n = array.length - 1; n < array[0].length; n++) {
        array[array.length - 1][n] = array[array.length - 1][n]/c;  
      }
    }
  }
  
  // Reduced Row Echelon Form
  public void rref() {
    // Arrange Array into Row Echelon Form
    this.ref();
    
    // Start running through rows from bottom -> up
    for(int i = array.length - 1; i > 0; i--) {
      
      // Check to see if first number isnt 0
      if(array[i][i] == 0) {
        // If not, then return with current total operation
        return;
      }
      
      // Run through the column
      for(int j = i - 1; j >= 0; j--) {
        // Check to see if spot is 0
        if(array[j][i] != 0) {
          // Apply Row Operation
          double coef = array[j][i] * -1;
          for(int n = i; n < array[0].length; n++) {
            array[j][n] = array[j][n] + coef * array[i][n];
          }
          
        }
      }
    }
    return;
    
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
    // Check to see if inverse is even possible
    if(array.length != array[0].length) {
      println("Error: not a sqaure Matrix; Inverse Failed");
      return null;
    }
    
    // Build matrix for RREF
    double[][] arr = new double[array.length][2 * array[0].length];
    
    // Enter in matrix data
    for(int i = 0; i < array.length; i++) {
      for(int j = 0; j < array[0].length; j++) {
        arr[i][j] = array[i][j];
        // Add in 1s as necessary to set up identity)
        if(i == j) {
          arr[i][j + array[0].length] = 1;
        }
      }
    }
    
    // Make Temporary Matrix
    Matrix temp = new Matrix(arr);
    
    // Run RREF
    temp.rref();
    
    // Create new return array
    double[][] ret = new double[array.length][array[0].length];
    for(int i = 0; i < array.length; i++) {
      for(int j = 0; j < array[0].length; j++) {
        ret[i][j] = temp.getVal(i, j + array[0].length);
      }
    }
    
    return new Matrix(ret);
  }
  
}
