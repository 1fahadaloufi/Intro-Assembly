#include "stdio.h"
#include "stdlib.h"

#include "bubbleSort.h"


// optimized bubleSort 
void bubbleSort(int A[] , int size) {

    int new_size; // value that updates upper idx in array to look for

    while(size > 0) {
        int new_size = 0; // if new_size stays at zero, sorting is done

        for(int i = 1; i < size; i += 1) {
            if( A[i - 1] > A[i] ) {
                swap(A, i, i - 1); // swap elements A[i] and A[i - 1]
                new_size = i; 
            }
        }

        size = new_size; 
    }
}


void swap(int A[], int idx1, int idx2) {
    int tmp = A[idx1]; 
    A[idx1] = A[idx2];
    A[idx2] = tmp; 
}

// print for testing
void printArr (int A[], int size) {
    for(int i = 0; i < size; i += 1) {
        printf("%d ", A[i]); 
    }

    printf("\n");
}


int main(int argc, char* argv[]) {
    
    int A[] = {5,4,3,2,1, -1, 35, -500, 17, 9}; 
    int size_A = sizeof(A)/sizeof(A[0]); 
    printArr(A, size_A); 

    bubbleSort(A, size_A); 
    printArr(A, size_A); 

    return EXIT_SUCCESS; 
}