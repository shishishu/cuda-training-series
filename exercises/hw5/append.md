# reductions.cu
```
ncu ./reductions
```
```
==PROF== Profiling "atomic_red" - 0: 0%....50%....100% - 19 passes
atomic sum reduction correct!
==PROF== Profiling "reduce_a(float *, float *)" - 1: 0%....50%....100% - 19 passes
reduction w/atomic sum correct!
==PROF== Profiling "reduce_ws(float *, float *)" - 2: 0%....50%....100% - 19 passes
reduction warp shuffle sum correct!
==PROF== Disconnected from process 858914
[858914] reductions@127.0.0.1
  atomic_red(const float *, float *), 2025-Jun-08 21:51:38, Context 1, Stream 7
    Section: GPU Speed Of Light Throughput
    ---------------------------------------------------------------------- --------------- ------------------------------
    DRAM Frequency                                                           cycle/usecond                         877.28
    SM Frequency                                                             cycle/nsecond                           1.30
    Elapsed Cycles                                                                   cycle                     26,414,181
    Memory [%]                                                                           %                           1.03
    DRAM Throughput                                                                      %                           0.18
    Duration                                                                       msecond                          20.36
    L1/TEX Cache Throughput                                                              %                           0.82
    L2 Cache Throughput                                                                  %                           1.03
    SM Active Cycles                                                                 cycle                  26,358,930.49
    Compute (SM) [%]                                                                     %                           0.40
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   This kernel exhibits low compute throughput and memory bandwidth utilization relative to the peak performance 
          of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak typically indicate    
          latency issues. Look at Scheduler Statistics and Warp State Statistics for potential reasons.                 

    Section: Launch Statistics
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Size                                                                                                        256
    Function Cache Configuration                                                                  cudaFuncCachePreferNone
    Grid Size                                                                                                      32,768
    Registers Per Thread                                                   register/thread                             16
    Shared Memory Configuration Size                                                  byte                              0
    Driver Shared Memory Per Block                                              byte/block                              0
    Dynamic Shared Memory Per Block                                             byte/block                              0
    Static Shared Memory Per Block                                              byte/block                              0
    Threads                                                                         thread                      8,388,608
    Waves Per SM                                                                                                    51.20
    ---------------------------------------------------------------------- --------------- ------------------------------

    Section: Occupancy
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Limit SM                                                                   block                             32
    Block Limit Registers                                                            block                             16
    Block Limit Shared Mem                                                           block                             32
    Block Limit Warps                                                                block                              8
    Theoretical Active Warps per SM                                                   warp                             64
    Theoretical Occupancy                                                                %                            100
    Achieved Occupancy                                                                   %                          86.72
    Achieved Active Warps Per SM                                                      warp                          55.50
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   This kernel's theoretical occupancy is not impacted by any block limit. The difference between calculated     
          theoretical (100.0%) and measured achieved occupancy (86.7%) can be the result of warp scheduling overheads   
          or workload imbalances during the kernel execution. Load imbalances can occur between warps within a block    
          as well as across blocks of the same kernel. See the CUDA Best Practices Guide                                
          (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on           
          optimizing occupancy.                                                                                         

  reduce_a(float *, float *), 2025-Jun-08 21:51:39, Context 1, Stream 7
    Section: GPU Speed Of Light Throughput
    ---------------------------------------------------------------------- --------------- ------------------------------
    DRAM Frequency                                                           cycle/usecond                         836.50
    SM Frequency                                                             cycle/nsecond                           1.23
    Elapsed Cycles                                                                   cycle                         64,591
    Memory [%]                                                                           %                          74.97
    DRAM Throughput                                                                      %                          74.97
    Duration                                                                       usecond                          52.26
    L1/TEX Cache Throughput                                                              %                          22.68
    L2 Cache Throughput                                                                  %                          26.81
    SM Active Cycles                                                                 cycle                      57,802.31
    Compute (SM) [%]                                                                     %                          16.68
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   Memory is more heavily utilized than Compute: Look at the Memory Workload Analysis section to identify the    
          DRAM bottleneck. Check memory replay (coalescing) metrics to make sure you're efficiently utilizing the       
          bytes transferred. Also consider whether it is possible to do more work per memory access (kernel fusion) or  
          whether there are values you can (re)compute.                                                                 

    Section: Launch Statistics
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Size                                                                                                        256
    Function Cache Configuration                                                                  cudaFuncCachePreferNone
    Grid Size                                                                                                         640
    Registers Per Thread                                                   register/thread                             16
    Shared Memory Configuration Size                                                 Kbyte                           8.19
    Driver Shared Memory Per Block                                              byte/block                              0
    Dynamic Shared Memory Per Block                                             byte/block                              0
    Static Shared Memory Per Block                                             Kbyte/block                           1.02
    Threads                                                                         thread                        163,840
    Waves Per SM                                                                                                        1
    ---------------------------------------------------------------------- --------------- ------------------------------

    Section: Occupancy
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Limit SM                                                                   block                             32
    Block Limit Registers                                                            block                             16
    Block Limit Shared Mem                                                           block                              8
    Block Limit Warps                                                                block                              8
    Theoretical Active Warps per SM                                                   warp                             64
    Theoretical Occupancy                                                                %                            100
    Achieved Occupancy                                                                   %                          94.72
    Achieved Active Warps Per SM                                                      warp                          60.62
    ---------------------------------------------------------------------- --------------- ------------------------------
    INF   This kernel's theoretical occupancy is not impacted by any block limit.                                       

  reduce_ws(float *, float *), 2025-Jun-08 21:51:39, Context 1, Stream 7
    Section: GPU Speed Of Light Throughput
    ---------------------------------------------------------------------- --------------- ------------------------------
    DRAM Frequency                                                           cycle/usecond                         818.13
    SM Frequency                                                             cycle/nsecond                           1.21
    Elapsed Cycles                                                                   cycle                         63,578
    Memory [%]                                                                           %                          76.14
    DRAM Throughput                                                                      %                          76.14
    Duration                                                                       usecond                          52.61
    L1/TEX Cache Throughput                                                              %                          22.85
    L2 Cache Throughput                                                                  %                          27.25
    SM Active Cycles                                                                 cycle                      57,373.43
    Compute (SM) [%]                                                                     %                          13.88
    ---------------------------------------------------------------------- --------------- ------------------------------
    WRN   Memory is more heavily utilized than Compute: Look at the Memory Workload Analysis section to identify the    
          DRAM bottleneck. Check memory replay (coalescing) metrics to make sure you're efficiently utilizing the       
          bytes transferred. Also consider whether it is possible to do more work per memory access (kernel fusion) or  
          whether there are values you can (re)compute.                                                                 

    Section: Launch Statistics
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Size                                                                                                        256
    Function Cache Configuration                                                                  cudaFuncCachePreferNone
    Grid Size                                                                                                         640
    Registers Per Thread                                                   register/thread                             16
    Shared Memory Configuration Size                                                 Kbyte                           8.19
    Driver Shared Memory Per Block                                              byte/block                              0
    Dynamic Shared Memory Per Block                                             byte/block                              0
    Static Shared Memory Per Block                                              byte/block                            128
    Threads                                                                         thread                        163,840
    Waves Per SM                                                                                                        1
    ---------------------------------------------------------------------- --------------- ------------------------------

    Section: Occupancy
    ---------------------------------------------------------------------- --------------- ------------------------------
    Block Limit SM                                                                   block                             32
    Block Limit Registers                                                            block                             16
    Block Limit Shared Mem                                                           block                             32
    Block Limit Warps                                                                block                              8
    Theoretical Active Warps per SM                                                   warp                             64
    Theoretical Occupancy                                                                %                            100
    Achieved Occupancy                                                                   %                          94.71
    Achieved Active Warps Per SM                                                      warp                          60.61
    ---------------------------------------------------------------------- --------------- ------------------------------
    INF   This kernel's theoretical occupancy is not impacted by any block limit.     
```
