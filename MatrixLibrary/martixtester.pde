int[][] test1 = {{1,3,-2,5},{0,-4,12,-8},{2,4,3,8}};

/*
Matrix test = new Matrix(test1);
test.rref();
test.printM();

*/


/*
int[][] temp1 = {{-1, 4},{2, 3}};
int[][] temp2 = {{9, -3},{6, 1}};
Matrix n1 = new Matrix(temp1);
Matrix n2 = new Matrix(temp2);

(n1.mult(n2)).printM();
println((n1.mult(n2)).det());
*/

int[][] temp3 = {{1, 3, 5, 9}, {1, 3, 1, 7}, {4, 3, 9, 7}};
int[][] temp4 = {{7, 6, 1}, {3, 4, 8}, {2, 1, 6}};
int[][] inverseTest = {{1, -1, 3, 1, 0, 0}, {2, 1, 2, 0, 1, 0}, {-2, -2, 1, 0, 0, 1}};
Matrix n3 = new Matrix(temp3);
Matrix n4 = new Matrix(temp4);
Matrix n5 = new Matrix(inverseTest);
n5.printM();
n5.rref();
(n4.inverse()).printM();
