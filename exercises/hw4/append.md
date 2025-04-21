# matrix_sums.cu
```
nvprof ./matrix_sums
```
```
==822815== NVPROF is profiling process 822815, command: ./matrix_sums
row sums correct!
column sums correct!
==822815== Profiling application: ./matrix_sums
==822815== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   97.39%  225.83ms         1  225.83ms  225.83ms  225.83ms  [CUDA memcpy HtoD]
                    1.48%  3.4310ms         1  3.4310ms  3.4310ms  3.4310ms  row_sums(float const *, float*, unsigned long)
                    1.12%  2.6016ms         1  2.6016ms  2.6016ms  2.6016ms  column_sums(float const *, float*, unsigned long)
                    0.01%  12.639us         2  6.3190us  6.1750us  6.4640us  [CUDA memcpy DtoH]
                    0.00%  3.2640us         1  3.2640us  3.2640us  3.2640us  [CUDA memset]
      API calls:   62.19%  232.14ms         3  77.382ms  2.6272ms  226.00ms  cudaMemcpy
                   37.54%  140.15ms         2  70.073ms  123.07us  140.02ms  cudaMalloc
                    0.22%  830.98us       404  2.0560us     148ns  91.088us  cuDeviceGetAttribute
                    0.02%  81.781us         4  20.445us  17.911us  27.136us  cuDeviceGetName
                    0.01%  42.525us         2  21.262us  8.5890us  33.936us  cudaLaunchKernel
                    0.00%  15.098us         1  15.098us  15.098us  15.098us  cudaMemset
                    0.00%  10.641us         4  2.6600us     852ns  7.2090us  cuDeviceGetPCIBusId
                    0.00%  1.8140us         8     226ns     140ns     522ns  cuDeviceGet
                    0.00%  1.5530us         6     258ns     156ns     626ns  cudaGetLastError
                    0.00%  1.0730us         4     268ns     190ns     437ns  cuDeviceTotalMem
                    0.00%  1.0200us         3     340ns     181ns     656ns  cuDeviceGetCount
                    0.00%     906ns         4     226ns     196ns     265ns  cuDeviceGetUuid
                    0.00%     362ns         1     362ns     362ns     362ns  cuModuleGetLoadingMode

```

```
ncu ./matrix_sums
```
```
==PROF== Connected to process 823622 (/data/docker/zhouxiangjun/cuda-training-series/exercises/hw4/matrix_sums)
==PROF== Profiling "row_sums" - 0: 0%....50%....100% - 19 passes
row sums correct!
==PROF== Profiling "column_sums" - 1: 0%....50%....100% - 19 passes
column sums correct!
==PROF== Disconnected from process 823622
[823622] matrix_sums@127.0.0.1
  row_sums(const float *, float *, unsigned long), 2025-Apr-22 00:30:24, Context 1, Stream 7
    Section: GPU Speed Of Light Throughput
    ---------------------------------------------------------------------- --------------- ------------------------------
    DRAM Frequency                                                           cycle/usecond                         872.95
    SM Frequency                                                             cycle/nsecond                           1.29
    Elapsed Cycles                                                                   cycle                      4,412,358
    Memory [%]                                                                           %                          76.17
    DRAM Throughput                                                                      %                          35.14
    Duration                                                                       msecond                           3.42
    L1/TEX Cache Throughput                                                              %                          95.94
    L2 Cache Throughput                                                                  %                          12.57
    SM Active Cycles                                                                 cycle                   3,497,634.02
    Compute (SM) [%]                                                                     %                           2.68
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   Memory is more heavily utilized than Compute: Look at the Memory Workload Analysis section to identify the L1 
          bottleneck. Check memory replay (coalescing) metrics to make sure you're efficiently utilizing the bytes      
          transferred. Also consider whether it is possible to do more work per memory access (kernel fusion) or        
          whether there are values you can (re)compute.                                                                 

    Section: Launch Statistics
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Size                                                                                                        256
    Function Cache Configuration                                                                  cudaFuncCachePreferNone
    Grid Size                                                                                                          64
    Registers Per Thread                                                   register/thread                             21
    Shared Memory Configuration Size                                                  byte                              0
    Driver Shared Memory Per Block                                              byte/block                              0
    Dynamic Shared Memory Per Block                                             byte/block                              0
    Static Shared Memory Per Block                                              byte/block                              0
    Threads                                                                         thread                         16,384
    Waves Per SM                                                                                                     0.10
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   The grid for this launch is configured to execute only 64 blocks, which is less than the GPU's 80             
          multiprocessors. This can underutilize some multiprocessors. If you do not intend to execute this kernel      
          concurrently with other workloads, consider reducing the block size to have at least one block per            
          multiprocessor or increase the size of the grid to fully utilize the available hardware resources. See the    
          Hardware Model (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#metrics-hw-model)            
          description for more details on launch configurations.                                                        

    Section: Occupancy
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Limit SM                                                                   block                             32
    Block Limit Registers                                                            block                             10
    Block Limit Shared Mem                                                           block                             32
    Block Limit Warps                                                                block                              8
    Theoretical Active Warps per SM                                                   warp                             64
    Theoretical Occupancy                                                                %                            100
    Achieved Occupancy                                                                   %                          12.50
    Achieved Active Warps Per SM                                                      warp                           8.00
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   This kernel's theoretical occupancy is not impacted by any block limit. The difference between calculated     
          theoretical (100.0%) and measured achieved occupancy (12.5%) can be the result of warp scheduling overheads   
          or workload imbalances during the kernel execution. Load imbalances can occur between warps within a block    
          as well as across blocks of the same kernel. See the CUDA Best Practices Guide                                
          (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on           
          optimizing occupancy.                                                                                         

  column_sums(const float *, float *, unsigned long), 2025-Apr-22 00:30:24, Context 1, Stream 7
    Section: GPU Speed Of Light Throughput
    ---------------------------------------------------------------------- --------------- ------------------------------
    DRAM Frequency                                                           cycle/usecond                         879.08
    SM Frequency                                                             cycle/nsecond                           1.30
    Elapsed Cycles                                                                   cycle                      3,307,618
    Memory [%]                                                                           %                          46.87
    DRAM Throughput                                                                      %                          46.87
    Duration                                                                       msecond                           2.54
    L1/TEX Cache Throughput                                                              %                          16.47
    L2 Cache Throughput                                                                  %                          16.76
    SM Active Cycles                                                                 cycle                   2,546,831.92
    Compute (SM) [%]                                                                     %                           4.57
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   This kernel grid is too small to fill the available resources on this device, resulting in only 0.1 full      
          waves across all SMs. Look at Launch Statistics for more details.                                             

    Section: Launch Statistics
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Size                                                                                                        256
    Function Cache Configuration                                                                  cudaFuncCachePreferNone
    Grid Size                                                                                                          64
    Registers Per Thread                                                   register/thread                             26
    Shared Memory Configuration Size                                                  byte                              0
    Driver Shared Memory Per Block                                              byte/block                              0
    Dynamic Shared Memory Per Block                                             byte/block                              0
    Static Shared Memory Per Block                                              byte/block                              0
    Threads                                                                         thread                         16,384
    Waves Per SM                                                                                                     0.10
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   The grid for this launch is configured to execute only 64 blocks, which is less than the GPU's 80             
          multiprocessors. This can underutilize some multiprocessors. If you do not intend to execute this kernel      
          concurrently with other workloads, consider reducing the block size to have at least one block per            
          multiprocessor or increase the size of the grid to fully utilize the available hardware resources. See the    
          Hardware Model (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#metrics-hw-model)            
          description for more details on launch configurations.                                                        

    Section: Occupancy
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Limit SM                                                                   block                             32
    Block Limit Registers                                                            block                              8
    Block Limit Shared Mem                                                           block                             32
    Block Limit Warps                                                                block                              8
    Theoretical Active Warps per SM                                                   warp                             64
    Theoretical Occupancy                                                                %                            100
    Achieved Occupancy                                                                   %                          12.45
    Achieved Active Warps Per SM                                                      warp                           7.97
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   This kernel's theoretical occupancy is not impacted by any block limit. The difference between calculated     
          theoretical (100.0%) and measured achieved occupancy (12.5%) can be the result of warp scheduling overheads   
          or workload imbalances during the kernel execution. Load imbalances can occur between warps within a block    
          as well as across blocks of the same kernel. See the CUDA Best Practices Guide                                
          (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on           
          optimizing occupancy.        
```

```
ncu --metrics l1tex__t_sectors_pipe_lsu_mem_global_op_ld.sum,l1tex__t_requests_pipe_lsu_mem_global_op_ld.sum ./matrix_sums
```
```
==PROF== Connected to process 824524 (/data/docker/zhouxiangjun/cuda-training-series/exercises/hw4/matrix_sums)
==PROF== Profiling "row_sums" - 0: 0%....50%....100% - 4 passes
row sums correct!
==PROF== Profiling "column_sums" - 1: 0%....50%....100% - 4 passes
column sums correct!
==PROF== Disconnected from process 824524
[824524] matrix_sums@127.0.0.1
  row_sums(const float *, float *, unsigned long), 2025-Apr-22 00:31:34, Context 1, Stream 7
    Section: Command line profiler metrics
    ---------------------------------------------------------------------- --------------- ------------------------------
    l1tex__t_requests_pipe_lsu_mem_global_op_ld.sum                                request                      8,388,608
    l1tex__t_sectors_pipe_lsu_mem_global_op_ld.sum                                  sector                    268,435,456
    ---------------------------------------------------------------------- --------------- ------------------------------

  column_sums(const float *, float *, unsigned long), 2025-Apr-22 00:31:34, Context 1, Stream 7
    Section: Command line profiler metrics
    ---------------------------------------------------------------------- --------------- ------------------------------
    l1tex__t_requests_pipe_lsu_mem_global_op_ld.sum                                request                      8,388,608
    l1tex__t_sectors_pipe_lsu_mem_global_op_ld.sum                                  sector                     33,554,432
    ---------------------------------------------------------------------- --------------- ------------------------------

```
