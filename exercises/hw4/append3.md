# original code
```
ncu ./matrix_add_2d
```
```
==PROF== Profiling "matrix_add_2D" - 0: 0%....50%....100% - 20 passes
Success!
==PROF== Disconnected from process 3055865
[3055865] matrix_add_2d@127.0.0.1
  matrix_add_2D(const unsigned int (*)[1024], const unsigned int (*)[1024], unsigned int (*)[1024], unsigned long, unsigned long), 2025-May-24 10:49:50, Context 1, Stream 7
    Section: GPU Speed Of Light Throughput
    ---------------------------------------------------------------------- --------------- ------------------------------
    DRAM Frequency                                                           cycle/usecond                         868.29
    SM Frequency                                                             cycle/nsecond                           1.28
    Elapsed Cycles                                                                   cycle                         71,812
    Memory [%]                                                                           %                          57.33
    DRAM Throughput                                                                      %                          24.52
    Duration                                                                       usecond                             56
    L1/TEX Cache Throughput                                                              %                          82.28
    L2 Cache Throughput                                                                  %                          54.10
    SM Active Cycles                                                                 cycle                      66,794.16
    Compute (SM) [%]                                                                     %                           4.57
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   This kernel exhibits low compute throughput and memory bandwidth utilization relative to the peak performance 
          of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak typically indicate    
          latency issues. Look at Scheduler Statistics and Warp State Statistics for potential reasons.                 

    Section: Launch Statistics
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Size                                                                                                      1,024
    Function Cache Configuration                                                                  cudaFuncCachePreferNone
    Grid Size                                                                                                       1,024
    Registers Per Thread                                                   register/thread                             16
    Shared Memory Configuration Size                                                  byte                              0
    Driver Shared Memory Per Block                                              byte/block                              0
    Dynamic Shared Memory Per Block                                             byte/block                              0
    Static Shared Memory Per Block                                              byte/block                              0
    Threads                                                                         thread                      1,048,576
    Waves Per SM                                                                                                     6.40
    ---------------------------------------------------------------------- --------------- ------------------------------

    Section: Occupancy
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Limit SM                                                                   block                             32
    Block Limit Registers                                                            block                              4
    Block Limit Shared Mem                                                           block                             32
    Block Limit Warps                                                                block                              2
    Theoretical Active Warps per SM                                                   warp                             64
    Theoretical Occupancy                                                                %                            100
    Achieved Occupancy                                                                   %                          74.00
    Achieved Active Warps Per SM                                                      warp                          47.36
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   This kernel's theoretical occupancy is not impacted by any block limit. The difference between calculated     
          theoretical (100.0%) and measured achieved occupancy (74.0%) can be the result of warp scheduling overheads   
          or workload imbalances during the kernel execution. Load imbalances can occur between warps within a block    
          as well as across blocks of the same kernel. See the CUDA Best Practices Guide                                
          (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on           
          optimizing occupancy.
```
```
ncu --metrics l1tex__t_sectors_pipe_lsu_mem_global_op_ld.sum,l1tex__t_requests_pipe_lsu_mem_global_op_ld.sum ./matrix_add_2d
```
```
==PROF== Profiling "matrix_add_2D" - 0: 0%....50%....100% - 5 passes
Success!
==PROF== Disconnected from process 3056684
[3056684] matrix_add_2d@127.0.0.1
  matrix_add_2D(const unsigned int (*)[1024], const unsigned int (*)[1024], unsigned int (*)[1024], unsigned long, unsigned long), 2025-May-24 10:50:42, Context 1, Stream 7
    Section: Command line profiler metrics
    ---------------------------------------------------------------------- --------------- ------------------------------
    l1tex__t_requests_pipe_lsu_mem_global_op_ld.sum                                request                         65,536
    l1tex__t_sectors_pipe_lsu_mem_global_op_ld.sum                                  sector                      2,097,152
    ---------------------------------------------------------------------- --------------- ------------------------------
```

# coalesced
```
==PROF== Profiling "matrix_add_2D" - 0: 0%....50%....100% - 20 passes
Success!
==PROF== Disconnected from process 3057665
[3057665] matrix_add_2d@127.0.0.1
  matrix_add_2D(const unsigned int (*)[1024], const unsigned int (*)[1024], unsigned int (*)[1024], unsigned long, unsigned long), 2025-May-24 10:52:43, Context 1, Stream 7
    Section: GPU Speed Of Light Throughput
    ---------------------------------------------------------------------- --------------- ------------------------------
    DRAM Frequency                                                           cycle/usecond                         735.78
    SM Frequency                                                             cycle/nsecond                           1.07
    Elapsed Cycles                                                                   cycle                         18,741
    Memory [%]                                                                           %                          74.07
    DRAM Throughput                                                                      %                          74.07
    Duration                                                                       usecond                          17.44
    L1/TEX Cache Throughput                                                              %                          26.34
    L2 Cache Throughput                                                                  %                          34.77
    SM Active Cycles                                                                 cycle                      16,621.17
    Compute (SM) [%]                                                                     %                          16.82
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   Memory is more heavily utilized than Compute: Look at the Memory Workload Analysis section to identify the    
          DRAM bottleneck. Check memory replay (coalescing) metrics to make sure you're efficiently utilizing the       
          bytes transferred. Also consider whether it is possible to do more work per memory access (kernel fusion) or  
          whether there are values you can (re)compute.                                                                 

    Section: Launch Statistics
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Size                                                                                                      1,024
    Function Cache Configuration                                                                  cudaFuncCachePreferNone
    Grid Size                                                                                                       1,024
    Registers Per Thread                                                   register/thread                             16
    Shared Memory Configuration Size                                                  byte                              0
    Driver Shared Memory Per Block                                              byte/block                              0
    Dynamic Shared Memory Per Block                                             byte/block                              0
    Static Shared Memory Per Block                                              byte/block                              0
    Threads                                                                         thread                      1,048,576
    Waves Per SM                                                                                                     6.40
    ---------------------------------------------------------------------- --------------- ------------------------------

    Section: Occupancy
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Limit SM                                                                   block                             32
    Block Limit Registers                                                            block                              4
    Block Limit Shared Mem                                                           block                             32
    Block Limit Warps                                                                block                              2
    Theoretical Active Warps per SM                                                   warp                             64
    Theoretical Occupancy                                                                %                            100
    Achieved Occupancy                                                                   %                          79.26
    Achieved Active Warps Per SM                                                      warp                          50.72
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   This kernel's theoretical occupancy is not impacted by any block limit. The difference between calculated     
          theoretical (100.0%) and measured achieved occupancy (79.3%) can be the result of warp scheduling overheads   
          or workload imbalances during the kernel execution. Load imbalances can occur between warps within a block    
          as well as across blocks of the same kernel. See the CUDA Best Practices Guide                                
          (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on           
          optimizing occupancy.            
```
```
==PROF== Profiling "matrix_add_2D" - 0: 0%....50%....100% - 5 passes
Success!
==PROF== Disconnected from process 3058075
[3058075] matrix_add_2d@127.0.0.1
  matrix_add_2D(const unsigned int (*)[1024], const unsigned int (*)[1024], unsigned int (*)[1024], unsigned long, unsigned long), 2025-May-24 10:53:42, Context 1, Stream 7
    Section: Command line profiler metrics
    ---------------------------------------------------------------------- --------------- ------------------------------
    l1tex__t_requests_pipe_lsu_mem_global_op_ld.sum                                request                         65,536
    l1tex__t_sectors_pipe_lsu_mem_global_op_ld.sum                                  sector                        262,144
    ---------------------------------------------------------------------- --------------- ------------------------------
```
