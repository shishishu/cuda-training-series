#include <stdio.h>

__global__ void print_thread_order() {
    int tid = threadIdx.x + threadIdx.y * blockDim.x;
    printf("Block(%d,%d): threadIdx=(%d,%d), linear_id=%d\n",
           blockIdx.x, blockIdx.y, threadIdx.x, threadIdx.y, tid);
}

int main() {
    dim3 block(32, 2); // 32x2的Block
    dim3 grid(1, 1);
    print_thread_order<<<grid, block>>>();
    cudaDeviceSynchronize();
    return 0;
}
