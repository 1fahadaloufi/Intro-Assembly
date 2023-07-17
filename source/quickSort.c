#include "stdio.h"
#include "stdlib.h"

#include "quickSort.h"


void quickSort(int arr[], int left, int right) {
    if(left < right) {
        int pivotIdx = partition(arr, left, right);
        quickSort(arr, left, pivotIdx - 1);
        quickSort(arr, pivotIdx + 1, right); 
    }
}

int partition(int arr[], int left, int right) {
    int pivotIdx = (left + right) / 2; 
    int pivotVal = arr[pivotIdx]; 

    arr[pivotIdx] = arr[right]; 

    int storeIdx = left; 

    for(int i = left; i < right; i += 1) {
        int tmp = arr[i]; 
        
        if(tmp < pivotVal) {
            arr[i] = arr[storeIdx];
            arr[storeIdx] = tmp; 

            storeIdx += 1; 
        }
    }

    arr[right] = arr[storeIdx]; 
    arr[storeIdx] = pivotVal; 

    return storeIdx; 

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

    quickSort(A, 0, size_A - 1); 
    printArr(A, size_A); 

    return EXIT_SUCCESS; 
}