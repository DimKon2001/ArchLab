#include <stdio.h>
#include <stdlib.h>
#include <time.h>


int main(){
    /*perform addition of two matrices.*/

    //initialize srand
    srand(time(NULL));   
    int rows = 10;
    int columns = 10;
    //initialize matrices
    int** matrix_A = (int**)malloc(rows*sizeof(int*));
    int** matrix_B = (int**)malloc(rows*sizeof(int*));
    int** matrix_C = (int**)malloc(rows*sizeof(int*));

    //init with random elements - access by row
    for(int i = 0; i<rows; i++){
        matrix_A[i] = (int*)malloc(columns*sizeof(int));
        matrix_B[i] = (int*)malloc(columns*sizeof(int));
        matrix_C[i] = (int*)malloc(columns*sizeof(int));
        for(int j = 0; j<columns; j++){
            matrix_A[i][j] = rand()%100;
            matrix_B[i][j] = rand()%100;
        }
    }
    printf("Matrices initialized!\n");

    //add - access by column
    for(int j = 0; j<columns; j++){
        for(int i = 0; i<rows; i++){
            matrix_C[i][j] = matrix_A[i][j] + matrix_B[i][j];
        }
    }

    //print result - access by row
    printf("A is:\n");
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<columns; j++){
            printf("%3.d ", matrix_A[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    printf("B is:\n");
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<columns; j++){
            printf("%3.d ", matrix_B[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    printf("C = A + B is:\n");
    for(int i = 0; i<rows; i++){
        for(int j = 0; j<columns; j++){
            printf("%3.d ", matrix_C[i][j]);
        }
        printf("\n");
    }
    printf("\n");
    return 0;
}