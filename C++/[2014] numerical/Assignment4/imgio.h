#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "nrutil.h"

#define BUF			255
#define WIDTH		92
#define HEIGHT		112
#define SEEK_HEAD	54
#define HUMAN		6
#define TRIMG		8
#define TEIMG		2
#define EVNUM		10

#define PIXEL		WIDTH*HEIGHT
#define TRNUM		HUMAN*TRIMG
#define TENUM		HUMAN*TEIMG
#define TRPATH		"Training\\set_"
#define TEPATH		"Test\\"

//function
void svdcmp(double **a, int m, int n, double w[], double **v);

void read_data(); //function for read data
void avg_norm(); //function for average and normalize data
void cov_feature(); //covariance matrix and feature vector
void recognition(); //recognition

void print_img(char *fname, double *img); //function for print out data
void print_data(); //function for print out float data
void print_euc(); //function for print out euclidean distance

//variable
unsigned char tr[PIXEL][TRNUM]; //training array
unsigned char te[PIXEL][TRNUM]; //test array

double trnorm[PIXEL][TRNUM]; //normalized training array
double tenorm[PIXEL][TRNUM]; //normalized test array
double **cov; //covariance matrix
double eval[TRNUM+1]; //eigen value
double **revec; //reduced eigen vector
double evec[TRNUM][PIXEL]; //eigen vector
double fv_tr[EVNUM][TRNUM]; //feature vector of training image
double fv_te[EVNUM][TRNUM]; //feature vector of test image
