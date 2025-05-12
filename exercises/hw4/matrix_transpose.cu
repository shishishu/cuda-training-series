/*
src code: https://github.com/NVIDIA-developer-blog/code-samples/blob/master/series/cuda-cpp/transpose/transpose.cu
*/

#include <stdio.h>
// Convenience function for checking CUDA runtime API results
// can be wrapped around any runtime API call. No-op in release builds.
inline
cudaError_t checkCuda(cudaError_t result)
{
#if defined(DEBUG) || defined(_DEBUG)
  if (result != cudaSuccess) {
    fprintf(stderr, "CUDA Runtime Error: %s\n", cudaGetErrorString(result));
    assert(result == cudaSuccess);
  }
#endif
  return result;
}

const int TILE_DIM = 32;
const int BLOCK_ROWS = 8;
const int NUM_REPS = 100;

void postprocess(const float *ref, const float *res, int n, float ms)
{
  bool passed = true;
  for (int i = 0; i < n; i++) {
    if (res[i] != ref[i]) {
      printf("%d %f %f\n", i, res[i], ref[i]);
      printf("%25s\n", "*** FAILED ***");
      passed = false;
      break;
    }
  }
  if (passed)
    printf("%20.2f\n", 2 * n * sizeof(float) * 1e-6 * NUM_REPS / ms);
}

// simple copy kernel
// Used as reference case representing best effective bandwidth.
__global__ void copy(float *odata, const float *idata) {
  int x = blockIdx.x * TILE_DIM + threadIdx.x;
  int y = blockIdx.y * TILE_DIM + threadIdx.y;  // be careful, not BLOCK_ROWS
  int width = gridDim.x * TILE_DIM;
  for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS) {
    odata[(y + j) * width + x] = idata[(y + j) * width + x];
  }
}

// copy kernel using shared memory
// Also used as reference case, demonstrating effect of using shared memory.
__global__ void copySharedMem(float *odata, const float *idata) {
  __shared__ float tile[TILE_DIM * TILE_DIM];
  int x = blockIdx.x * TILE_DIM + threadIdx.x;
  int y = blockIdx.y * TILE_DIM + threadIdx.y;
  int width = gridDim.x * TILE_DIM;
  for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS) {
    tile[(threadIdx.y + j) * TILE_DIM + threadIdx.x] = idata[(y + j) * width + x];
  }
  __syncthreads();
  for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS) {
    odata[(y + j) * width + x] = tile[(threadIdx.y + j) * TILE_DIM + threadIdx.x];
  }
}

// naive transpose
// Simplest transpose; doesn't use shared memory.
// Global memory reads are coalesced but writes are not.
__global__ void transposeNaive(float *odata, const float *idata) {
  int x = blockIdx.x * TILE_DIM + threadIdx.x;
  int y = blockIdx.y * TILE_DIM + threadIdx.y;
  int width = gridDim.x * TILE_DIM;
  for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS) {
    odata[x * width + (y + j)] = idata[(y + j) * width + x]; 
  }
}

// coalesced transpose
// Uses shared memory to achieve coalesing in both reads and writes
// Tile width == #banks causes shared memory bank conflicts.
__global__ void transposeCoalesced(float *odata, const float *idata)
{
  __shared__ float tile[TILE_DIM][TILE_DIM];
    
  int x = blockIdx.x * TILE_DIM + threadIdx.x;
  int y = blockIdx.y * TILE_DIM + threadIdx.y;
  int width = gridDim.x * TILE_DIM;

  for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)
     tile[threadIdx.y+j][threadIdx.x] = idata[(y+j)*width + x];

  __syncthreads();

  x = blockIdx.y * TILE_DIM + threadIdx.x;  // transpose block offset
  y = blockIdx.x * TILE_DIM + threadIdx.y;

  for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)                                                                                                            
     odata[(y+j)*width + x] = tile[threadIdx.x][threadIdx.y + j];
}

// No bank-conflict transpose
// Same as transposeCoalesced except the first tile dimension is padded 
// to avoid shared memory bank conflicts.
__global__ void transposeCoalesced2(float *odata, const float *idata)
{
  __shared__ float tile[TILE_DIM][TILE_DIM+1];
    
  int x = blockIdx.x * TILE_DIM + threadIdx.x;
  int y = blockIdx.y * TILE_DIM + threadIdx.y;
  int width = gridDim.x * TILE_DIM;

  for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)
     tile[threadIdx.y+j][threadIdx.x] = idata[(y+j)*width + x];

  __syncthreads();

  x = blockIdx.y * TILE_DIM + threadIdx.x;  // transpose block offset
  y = blockIdx.x * TILE_DIM + threadIdx.y;

  for (int j = 0; j < TILE_DIM; j += BLOCK_ROWS)
     odata[(y+j)*width + x] = tile[threadIdx.x][threadIdx.y + j];
}

int main(){
  const int nx = 1024;
  const int ny = 1024;
  const int mem_size = nx * ny * sizeof(float);

  dim3 dimGrid(nx / TILE_DIM, ny / TILE_DIM, 1);
  dim3 dimBlock(TILE_DIM, BLOCK_ROWS, 1);
  printf("Matrix size: %d %d, Block size: %d %d, Tile size: %d %d\n", nx, ny, TILE_DIM, BLOCK_ROWS, TILE_DIM, TILE_DIM);
  printf("dimGrid: %d %d %d. dimBlock: %d %d %d\n", dimGrid.x, dimGrid.y, dimGrid.z, dimBlock.x, dimBlock.y, dimBlock.z);

  float *h_idata = (float*)malloc(mem_size);
  float *h_cdata = (float*)malloc(mem_size);
  float *h_tdata = (float*)malloc(mem_size);
  float *gold = (float*)malloc(mem_size);

  float *d_idata, *d_cdata, *d_tdata;
  cudaMalloc(&d_idata, mem_size);
  cudaMalloc(&d_cdata, mem_size);
  cudaMalloc(&d_tdata, mem_size);

  for (int j = 0; j < ny; j++) {
    for (int i = 0; i < nx; i++) {
      h_idata[j * nx + i ] = j * nx + i;
    }
  }

  for (int j = 0; j < ny; j++) {
    for (int i = 0; i < nx; i++) {
      gold[j * nx + i ] = h_idata[i * nx + j];
    }
  }

  cudaMemcpy(d_idata, h_idata, mem_size, cudaMemcpyHostToDevice);

  // timing
  cudaEvent_t startEvent, stopEvent;
  cudaEventCreate(&startEvent);
  cudaEventCreate(&stopEvent);
  float ms;
  
  cudaError_t err;
  printf("%25s%25s\n", "Routine", "Bandwidth (GB/s)");

  // copy
  printf("%25s", "copy");
  checkCuda(cudaMemset(d_cdata, 0, mem_size));
  // warmup
  copy<<<dimGrid, dimBlock>>>(d_cdata, d_idata);
  err = cudaGetLastError();
  if (err != cudaSuccess) {
    printf("Kernel launch failed: %s\n", cudaGetErrorString(err));
    exit(1);
  }
  checkCuda(cudaEventRecord(startEvent, 0));
  for (int i = 0; i < NUM_REPS; i++) {
    copy<<<dimGrid, dimBlock>>>(d_cdata, d_idata);
  }
  checkCuda(cudaEventRecord(stopEvent, 0));
  checkCuda(cudaEventSynchronize(stopEvent));
  checkCuda(cudaEventElapsedTime(&ms, startEvent, stopEvent));
  checkCuda(cudaMemcpy(h_cdata, d_cdata, mem_size, cudaMemcpyDeviceToHost));
  postprocess(h_idata, h_cdata, nx*ny, ms);

  // copySharedMem
  printf("%25s", "shared memory copy");
  checkCuda(cudaMemset(d_cdata, 0, mem_size));
  // warmup
  copySharedMem<<<dimGrid, dimBlock>>>(d_cdata, d_idata);
  err = cudaGetLastError();
  if (err != cudaSuccess) {
    printf("Kernel launch failed: %s\n", cudaGetErrorString(err));
    exit(1);
  }
  checkCuda(cudaEventRecord(startEvent, 0));
  for (int i = 0; i < NUM_REPS; i++) {
    copySharedMem<<<dimGrid, dimBlock>>>(d_cdata, d_idata);
  }
  checkCuda(cudaEventRecord(stopEvent, 0));
  checkCuda(cudaEventSynchronize(stopEvent));
  checkCuda(cudaEventElapsedTime(&ms, startEvent, stopEvent));
  checkCuda(cudaMemcpy(h_cdata, d_cdata, mem_size, cudaMemcpyDeviceToHost));
  postprocess(h_idata, h_cdata, nx*ny, ms);

  // transposeNaive
  printf("%25s", "naive transpose");
  checkCuda(cudaMemset(d_tdata, 0, mem_size));
  // warmup
  transposeNaive<<<dimGrid, dimBlock>>>(d_tdata, d_idata);
  err = cudaGetLastError();
  if (err != cudaSuccess) {
    printf("Kernel launch failed: %s\n", cudaGetErrorString(err));
    exit(1);
  }
  checkCuda(cudaEventRecord(startEvent, 0));
  for (int i = 0; i < NUM_REPS; i++) {
    transposeNaive<<<dimGrid, dimBlock>>>(d_tdata, d_idata);
  }
  checkCuda(cudaEventRecord(stopEvent, 0));
  checkCuda(cudaEventSynchronize(stopEvent));
  checkCuda(cudaEventElapsedTime(&ms, startEvent, stopEvent));
  checkCuda(cudaMemcpy(h_tdata, d_tdata, mem_size, cudaMemcpyDeviceToHost));
  postprocess(gold, h_tdata, nx*ny, ms);

  // transposeCoalesced
  printf("%25s", "coalesced transpose");
  checkCuda(cudaMemset(d_tdata, 0, mem_size));
  // warmup
  transposeCoalesced<<<dimGrid, dimBlock>>>(d_tdata, d_idata);
  err = cudaGetLastError();
  if (err != cudaSuccess) {
    printf("Kernel launch failed: %s\n", cudaGetErrorString(err));
    exit(1);
  }
  checkCuda(cudaEventRecord(startEvent, 0));
  for (int i = 0; i < NUM_REPS; i++) {
    transposeCoalesced<<<dimGrid, dimBlock>>>(d_tdata, d_idata);
  }
  checkCuda(cudaEventRecord(stopEvent, 0));
  checkCuda(cudaEventSynchronize(stopEvent));
  checkCuda(cudaEventElapsedTime(&ms, startEvent, stopEvent));
  checkCuda(cudaMemcpy(h_tdata, d_tdata, mem_size, cudaMemcpyDeviceToHost));
  postprocess(gold, h_tdata, nx*ny, ms);

  // transposeCoalesced2
  printf("%25s", "coalesced transpose 2");
  checkCuda(cudaMemset(d_tdata, 0, mem_size));
  // warmup
  transposeCoalesced2<<<dimGrid, dimBlock>>>(d_tdata, d_idata);
  err = cudaGetLastError();
  if (err != cudaSuccess) {
    printf("Kernel launch failed: %s\n", cudaGetErrorString(err));
    exit(1);
  }
  checkCuda(cudaEventRecord(startEvent, 0));
  for (int i = 0; i < NUM_REPS; i++) {
    transposeCoalesced2<<<dimGrid, dimBlock>>>(d_tdata, d_idata);
  }
  checkCuda(cudaEventRecord(stopEvent, 0));
  checkCuda(cudaEventSynchronize(stopEvent));
  checkCuda(cudaEventElapsedTime(&ms, startEvent, stopEvent));
  checkCuda(cudaMemcpy(h_tdata, d_tdata, mem_size, cudaMemcpyDeviceToHost));
  postprocess(gold, h_tdata, nx*ny, ms);

  return 0;
}
