#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define INPUT_PATH		"gray\\barbara(512x512).raw"
#define OUTPUT_PATH		"output.bmp"

#define HEADER_SIZE		40
#define RGB_PALETTE		256
#define WIDTH			512
#define HEIGHT			512

#define BMP_WIDTH		WIDTH*3
#define IMAGE_SIZE		WIDTH*HEIGHT

typedef struct header{
	unsigned int size_file;
	unsigned short reserved1;
	unsigned short reserved2;
	unsigned int offset;
	unsigned int size_header;
	unsigned int width;
	unsigned int height;
	unsigned short plane;
	unsigned short bit;
	unsigned int compression;
	unsigned int size_image;
	unsigned int resolution_h;
	unsigned int resolution_v;
	unsigned int palette;
	unsigned int important;
}HEADER;

typedef struct rgb{
	unsigned char blue;
	unsigned char green;
	unsigned char red;
	unsigned char reserved;
}RGB;

int main(){
	int i, j;
	int INPUT_IMAGE_SIZE=IMAGE_SIZE;
	int OUTPUT_IMAGE_SIZE=BMP_WIDTH*HEIGHT;

	char *input=(char*)malloc(INPUT_IMAGE_SIZE); //input image
	char *output=(char*)malloc(OUTPUT_IMAGE_SIZE); //output image

	FILE *fp; //file sturct
	HEADER hp; //bmp header
	RGB cp[RGB_PALETTE]; //palette header

	fp=fopen(INPUT_PATH, "rb"); //file open
	fread(input, sizeof(char), INPUT_IMAGE_SIZE, fp); //read data
	fclose(fp); //close file

	//gray to bmp
	for(i=0;i<HEIGHT;i++){
		for(j=0;j<BMP_WIDTH;j++){
			output[((HEIGHT-i-1)*BMP_WIDTH)+j]=input[(i*WIDTH)+(j/3)];
		}
	}

	//header
	hp.size_file=OUTPUT_IMAGE_SIZE+sizeof(hp)+sizeof(cp)+2;
	hp.reserved1=0;
	hp.reserved2=0;
	hp.offset=sizeof(hp)+sizeof(cp)+2;
	hp.size_header=HEADER_SIZE;
	hp.width=WIDTH;
	hp.height=HEIGHT;
	hp.plane=1;
	hp.bit=24;
	hp.compression=0;
	hp.size_image=IMAGE_SIZE;
	hp.resolution_h=0;
	hp.resolution_v=0;
	hp.palette=0;
	hp.important=0;

	//RBB palette
	for(i=0;i<RGB_PALETTE;i++){
		cp[i].blue=cp[i].green=cp[i].red=i;
		cp[i].reserved=0;
	}

	fp=fopen(OUTPUT_PATH, "wb"); //file open
	fwrite("BM", sizeof(char), 2, fp); //write header
	fwrite((char*)&hp, sizeof(char), sizeof(hp), fp); //write header
	fwrite((char*)cp, sizeof(char), sizeof(cp), fp); //write header
	fwrite(output, sizeof(char), OUTPUT_IMAGE_SIZE, fp); //write data
	fclose(fp); //close file

	free(input);
	free(output);

	return 0;
}