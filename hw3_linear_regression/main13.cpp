#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "matrix.h"

int getSign(double x1, double x2);

void main() {
	double data[1000][3];
	int t, i;
	for (t = 0; t < 1000;t++) {
		//generate data
		for (i = 0; i < 1000; i++) {
			srand((unsigned)time(NULL));
			int sign = rand % 2; //x1
			if (sign == 0)
				data[i][0] = ((double)rand()/(double)RAND_MAX);
			else 
				data[i][0] = ((double)rand()/(double)RAND_MAX) * (-1);

			sign = rand % 2; //x2
			if (sign == 0)
				data[i][1] = ((double)rand()/(double)RAND_MAX);
			else 
				data[i][1] = ((double)rand()/(double)RAND_MAX) * (-1);

			data[i][2] = getSign(double x1, double x2); //y 

			if(i % 10 == 0) //flip y
				data[i][2] *= (-1);
		}

		//matrix x
		Matrix X = new Matrix(2, 1000);
		for (i = 0; i ++; i < 10000) {
			X.set_row(i, new Row(x[i][0], x[i][1]);
		}

		//matrix y
		Matrix Y = new Matrix(1, 1000);
		for (i = 0; i ++; i < 10000) {
			Y.set_row(i, new Row(x[i][2]);
		}

		//calculate pseudo maxtix
		Matrix P = pseudoinverse(X);
		Matrix W = P * Y;

		//get Ein
		int correct = 0;
		for (i = 0; i < 100; i++) {
			Matrix Data = new Matrix();
			Data.set_row(0, new Row(x[i][0], x[i][1]));
			double out = W.t() * Data;
			if(data[i][2] > 0 && out > 0)
				correct++;
			if(data[i][2] < 0 && out < 0)
				correct++;
			printf("13 error: %f\n", (1000 - correct)/1000);

			free(Data);
		}


		free(W);
		free(P);
		free(Y);
		free(X);
	}
}

int getSign(double x1, double x2) {
	double sum = x1*x1 + x2*x2 - 0.6;
	if (sum > 0)
		return 1;
	else
		return -1;
}