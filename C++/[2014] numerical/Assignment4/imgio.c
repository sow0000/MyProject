#include "imgio.h"

void read_data(){
	int i, j, k, n=0; //condition for loop
	FILE *fp; //file sturct
	char buf1[BUF], buf2[BUF], bufi[BUF]; //file path
	char ibuf[PIXEL*9]={0,}; //bmp image

	for(i=0;i<HUMAN;i++){ //read training data
		memset(buf1, 0, sizeof(buf1)); //make path
		strcpy(buf1, TRPATH);
		itoa(i+1, bufi, 10);
		strcat(buf1, bufi);
		strcat(buf1, "\\");

		for(j=0;j<TRIMG;j++){ //training image data
			itoa(j+1, bufi, 10); //make path
			strcpy(buf2, buf1);
			strcat(buf2, bufi);
			strcat(buf2, ".bmp");

			if(!(fp=fopen(buf2, "rb"))){
				printf("%s is not exist\n", buf2);
				return;
			}
			fseek(fp, SEEK_HEAD, SEEK_SET); //skip header
			fread(ibuf, sizeof(char), PIXEL*9, fp); //read data
			for(k=0;k<PIXEL;k++) tr[k][n]=ibuf[k*3]; //RGB to grayscale
			n++;
			fclose(fp); //close file
		}
	}

	for(i=0;i<TENUM;i++){ //read test data
		memset(buf1, 0, sizeof(buf1)); //make path
		strcpy(buf1, TEPATH);
		itoa(i+1, bufi, 10);
		strcat(buf1, bufi);
		strcat(buf1, ".bmp");

		if(!(fp=fopen(buf1, "rb"))){
			printf("%s is not exist\n", buf1);
			return;
		}
		fseek(fp, SEEK_HEAD, SEEK_SET); //skip header
		fread(ibuf, sizeof(char), PIXEL*9, fp); //read data
		for(k=0;k<PIXEL;k++) te[k][i]=ibuf[k*3]; //RGB to grayscale
		fclose(fp); //close file
	}
}

void avg_norm(){
	int i, j; //condition for loop
	double *avg; //average array
	
	avg=(double*)calloc(PIXEL, sizeof(double));

	for(i=0;i<PIXEL;i++){
		for(j=0;j<TRNUM;j++){
			avg[i]+=(double)tr[i][j]; //add pixels
		}
		avg[i]/=TRNUM; //average pixel
	}

	for(i=0;i<PIXEL;i++){
		for(j=0;j<TRNUM;j++){
			trnorm[i][j]=(double)tr[i][j]-avg[i]; //normalize
		}
	}

	for(i=0;i<PIXEL;i++){
		for(j=0;j<TENUM;j++){
			tenorm[i][j]=(double)te[i][j]-avg[i]; //normalize
		}
	}

	//print_img("avg_img.raw", avg); //print average image
	free(avg);
}

void cov_feature(){
	int i, j, k; //condition for loop
	//char buf[BUF], bufi[BUF];

	cov=(double**)malloc(sizeof(double*)*(TRNUM+1)); //allocate covariance array
	cov[0]=(double*)calloc((TRNUM+1)*(TRNUM+1), sizeof(double));

	revec=(double**)malloc(sizeof(double*)*(TRNUM+1)); //allocate reduced eigenvector array
	revec[0]=(double*)calloc((TRNUM+1)*(TRNUM+1), sizeof(double));

	for(i=1;i<=TRNUM;i++){ //allocate 2-D array
		cov[i]=cov[0]+(i*(TRNUM+1));
		revec[i]=revec[0]+(i*(TRNUM+1));
	}

	for(i=0;i<TRNUM;i++){ //covariance matrix
		for(j=0;j<TRNUM;j++){
			for(k=0;k<PIXEL;k++){
				cov[i+1][j+1]+=(trnorm[k][i]*trnorm[k][j]);
			}
		}
	}

	svdcmp(cov, TRNUM, TRNUM, eval, revec); //get reduced eigen vector

	for(i=0;i<EVNUM;i++){ //eigen vector
		for(j=0;j<PIXEL;j++){
			for(k=0;k<TRNUM;k++){
				evec[i][j]+=(double)(trnorm[j][k]*revec[k+1][i+1]);
			}
		}
	}
/*
	for(i=0;i<EVNUM;i++){ //print eigenvector image
		itoa(i+1, bufi, 10);
		strcpy(buf, "eigenface");
		strcat(buf, bufi);
		strcat(buf, ".raw");
		print_img(buf, evec[i]);
	}
*/
	for(i=0;i<EVNUM;i++){ //feature vector of training image
		for(j=0;j<TRNUM;j++){
			for(k=0;k<PIXEL;k++){
				fv_tr[i][j]+=(double)(evec[i][k]*trnorm[k][j]);
			}
		}
	}

	for(i=0;i<EVNUM;i++){ //feature vector of test image
		for(j=0;j<TENUM;j++){
			for(k=0;k<PIXEL;k++){
				fv_te[i][j]+=(double)(evec[i][k]*tenorm[k][j]);
			}
		}
	}

	free(cov[0]); //free memory
	free(cov);
	free(revec[0]);
	free(revec);
}

void recognition(){
	int i, j, k, n; //condition for loop
	double dev, euc_cur, euc_min=0; //deviation, euclidean distance
	//FILE *fp;

	//fp=fopen("euc1.txt", "w");

	for(i=0;i<TENUM;i++){
		euc_min=0;
		for(j=0;j<TRNUM;j++){
			euc_cur=0;
			for(k=0;k<EVNUM;k++){ //deviation
				dev=fv_te[k][i]-fv_tr[k][j];
				euc_cur+=(dev*dev);
			}
			euc_cur=sqrt(euc_cur); //euclidean distance
			if(euc_min==0 || euc_min>euc_cur){ //minimum euclidean distance
				euc_min=euc_cur;
				n=(j/TRIMG)+1;
			}
			//if(i==0) fprintf(fp, "%f\n", euc_cur);
		}
		printf("Test image %02d -> Training set %02d : %f\n", i, n, euc_min);
	}
	
	//fclose(fp);
}

void print_img(char *fname, double *img){
	FILE *fp;
	int i;
	unsigned char *buf;
	
	buf=(unsigned char*)malloc(PIXEL);

	for(i=0;i<PIXEL;i++){
		if(img[i]>255) buf[i]=255;
		else if(img[i]<0) buf[i]=0;
		else buf[i]=(unsigned char)img[i];
	}

	fp=fopen(fname, "wb");
	fwrite(buf, sizeof(char), PIXEL, fp);
	fclose(fp);
	free(buf);
}

void print_data(){
	FILE *fp;
	int i;
	
	fp=fopen("norm_tr1.txt", "w");
	for(i=0;i<PIXEL;i++){
		fprintf(fp, "%f\n", trnorm[i][0]);
	}
	fclose(fp);
	
	fp=fopen("norm_te1.txt", "w");
	for(i=0;i<PIXEL;i++){
		fprintf(fp, "%f\n", tenorm[i][0]);
	}
	fclose(fp);
	
	fp=fopen("norm_te2.txt", "w");
	for(i=0;i<PIXEL;i++){
		fprintf(fp, "%f\n", tenorm[i][2]);
	}
	fclose(fp);
	
	fp=fopen("eig_tr1.txt", "w");
	for(i=0;i<EVNUM;i++){
		fprintf(fp, "%f\n", trnorm[i][0]);
	}
	fclose(fp);
	
	fp=fopen("eig_te1.txt", "w");
	for(i=0;i<EVNUM;i++){
		fprintf(fp, "%f\n", tenorm[i][0]);
	}
	fclose(fp);
	
	fp=fopen("eig_te2.txt", "w");
	for(i=0;i<EVNUM;i++){
		fprintf(fp, "%f\n", trnorm[i][2]);
	}
	fclose(fp);
}