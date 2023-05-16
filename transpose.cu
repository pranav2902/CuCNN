#include "constants.h"
#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <iostream>

void transpose(float *matrix_t, float *matrix){

    for(int n = 0; n<4*7; n++) {
        int i = n/4;
        int j = n%4;
        matrix_t[n] = matrix[7*j + i];
    }
}


void initialize_output(float *matrix, int matrix_M, int matrix_N){
    for (int i = 0; i < matrix_M; i++){
        for (int j = 0; j < matrix_N; j++){
            matrix[(i*matrix_N) + j] = i+j;
        }
    }
}


void check_matrix(float *matrix, int matrix_M, int matrix_N){
    for (int i=0; i<matrix_M; i++){
        for (int j=0; j<matrix_N; j++)
        {
                printf("%.2f", matrix[(i*matrix_M)+j]);
                printf(" ");
        }
        printf("\n");
    }
    printf("\n");
}



int main(){

    float *d_output, *d_input;
    float *output = (float*)malloc(sizeof(float) * 4 * 7);
    float *input = (float*)malloc(sizeof(float) * 4 * 7);
    initialize_output(input, 4, 7);

    transpose(output, input);
    check_matrix(output, 7, 4);


    /*
    check_matrix(input, 4, 7);

    cudaMalloc((void**)&d_input, sizeof(float) * (4 * 7));
    cudaMalloc((void**)&d_output, sizeof(float) * (7 * 4));
    
    cudaMemcpy(d_input, input, sizeof(float) * (7 * 4), cudaMemcpyHostToDevice);



    dim3 griddim(4);
    dim3 blockdim(7);

    transpose<<<griddim, blockdim>>>(d_output, d_input);


    cudaMemcpy(output, d_output, sizeof(float) * (7 * 4), cudaMemcpyDeviceToHost);

    check_matrix(output, 7, 4);

    cudaFree(d_output);
    cudaFree(d_input);
    */
    free(output);
    free(input);



    return 0;


}