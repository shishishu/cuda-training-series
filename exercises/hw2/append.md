# matrix_mul_shared_var_thread.cu
- block_size = 32 (dft)
```
Done. Compute took 0.626938 seconds
```
```
==1510043== NVPROF is profiling process 1510043, command: ./matrix_mul_shared
Done. Compute took 0.618091 seconds
Success!
==1510043== Profiling application: ./matrix_mul_shared
==1510043== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   59.68%  254.32ms         1  254.32ms  254.32ms  254.32ms  mmul(float const *, float const *, float*, int)
                   26.54%  113.11ms         2  56.555ms  56.464ms  56.646ms  [CUDA memcpy HtoD]
                   13.78%  58.721ms         1  58.721ms  58.721ms  58.721ms  [CUDA memcpy DtoH]
      API calls:   71.95%  426.98ms         3  142.33ms  56.685ms  313.49ms  cudaMemcpy
                   27.89%  165.51ms         3  55.170ms  390.69us  164.73ms  cudaMalloc
                    0.14%  846.70us       404  2.0950us     146ns  94.023us  cuDeviceGetAttribute
                    0.01%  82.812us         4  20.703us  17.945us  26.429us  cuDeviceGetName
                    0.00%  27.714us         1  27.714us  27.714us  27.714us  cudaLaunchKernel
                    0.00%  9.5280us         4  2.3820us     896ns  5.6510us  cuDeviceGetPCIBusId
                    0.00%  1.8820us         4     470ns     198ns     883ns  cudaGetLastError
                    0.00%  1.6130us         8     201ns     147ns     457ns  cuDeviceGet
                    0.00%  1.0710us         3     357ns     208ns     654ns  cuDeviceGetCount
                    0.00%     949ns         4     237ns     200ns     342ns  cuDeviceTotalMem
                    0.00%     876ns         4     219ns     193ns     263ns  cuDeviceGetUuid
                    0.00%     334ns         1     334ns     334ns     334ns  cuModuleGetLoadingMode
```
- block_size = 64
```
Fatal error: kernel launch failure (invalid configuration argument at matrix_mul_shared_var_thread.cu:99)
```
- block_size = 16
```
Done. Compute took 0.736148 seconds
```
- block_size = 8
```
Done. Compute took 1.405855 seconds
```
- block_size = 4
```
==1509791== NVPROF is profiling process 1509791, command: ./matrix_mul_shared_var_thread
Done. Compute took 3.575321 seconds
Success!
==1509791== Profiling application: ./matrix_mul_shared_var_thread
==1509791== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   94.91%  3.20771s         1  3.20771s  3.20771s  3.20771s  mmul(float const *, float const *, float*, int)
                    3.35%  113.18ms         2  56.592ms  56.543ms  56.642ms  [CUDA memcpy HtoD]
                    1.75%  58.999ms         1  58.999ms  58.999ms  58.999ms  [CUDA memcpy DtoH]
      API calls:   95.76%  3.38072s         3  1.12691s  56.765ms  3.26715s  cudaMemcpy
                    4.21%  148.70ms         3  49.567ms  384.62us  147.93ms  cudaMalloc
                    0.02%  830.37us       404  2.0550us     141ns  93.545us  cuDeviceGetAttribute
                    0.00%  82.378us         4  20.594us  18.041us  27.455us  cuDeviceGetName
                    0.00%  33.461us         1  33.461us  33.461us  33.461us  cudaLaunchKernel
                    0.00%  10.875us         4  2.7180us     923ns  6.9220us  cuDeviceGetPCIBusId
                    0.00%  2.1920us         4     548ns     181ns     862ns  cudaGetLastError
                    0.00%  1.7260us         8     215ns     147ns     508ns  cuDeviceGet
                    0.00%  1.1360us         4     284ns     182ns     508ns  cuDeviceTotalMem
                    0.00%  1.0560us         3     352ns     180ns     687ns  cuDeviceGetCount
                    0.00%     887ns         4     221ns     189ns     312ns  cuDeviceGetUuid
                    0.00%     341ns         1     341ns     341ns     341ns  cuModuleGetLoadingMode
```
Done. Compute took 3.593932 seconds
```
- block_size = 1
```
Done. Compute took 79.884225 seconds
```

# matrix_mul_shared_var_io.cu
## transpose Bs only
```
==2415680== NVPROF is profiling process 2415680, command: ./matrix_mul_shared_var_io
Done. Compute took 1.779633 seconds
Success!
==2415680== Profiling application: ./matrix_mul_shared_var_io
==2415680== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   90.50%  1.42966s         1  1.42966s  1.42966s  1.42966s  mmul(float const *, float const *, float*, int)
                    7.61%  120.18ms         2  60.089ms  60.052ms  60.126ms  [CUDA memcpy HtoD]
                    1.89%  29.880ms         1  29.880ms  29.880ms  29.880ms  [CUDA memcpy DtoH]
      API calls:   91.02%  1.58036s         3  526.79ms  60.289ms  1.45977s  cudaMemcpy
                    8.92%  154.96ms         3  51.655ms  380.33us  154.18ms  cudaMalloc
                    0.05%  851.39us       404  2.1070us     148ns  101.83us  cuDeviceGetAttribute
                    0.01%  89.451us         4  22.362us  19.166us  30.789us  cuDeviceGetName
                    0.00%  29.711us         1  29.711us  29.711us  29.711us  cudaLaunchKernel
                    0.00%  16.085us         4  4.0210us     923ns  12.271us  cuDeviceGetPCIBusId
                    0.00%  1.9910us         4     497ns     217ns     710ns  cudaGetLastError
                    0.00%  1.6760us         8     209ns     142ns     439ns  cuDeviceGet
                    0.00%  1.2410us         3     413ns     255ns     728ns  cuDeviceGetCount
                    0.00%  1.1570us         4     289ns     249ns     329ns  cuDeviceTotalMem
                    0.00%     855ns         4     213ns     171ns     284ns  cuDeviceGetUuid
                    0.00%     309ns         1     309ns     309ns     309ns  cuModuleGetLoadingMode
```
## transpose Bs and solve bank conflict
```
Done. Compute took 0.643552 seconds
Success!
==2420980== Profiling application: ./matrix_mul_shared_var_io
==2420980== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   63.28%  258.47ms         1  258.47ms  258.47ms  258.47ms  mmul(float const *, float const *, float*, int)
                   29.40%  120.10ms         2  60.049ms  60.013ms  60.085ms  [CUDA memcpy HtoD]
                    7.32%  29.886ms         1  29.886ms  29.886ms  29.886ms  [CUDA memcpy DtoH]
      API calls:   68.52%  409.10ms         3  136.37ms  60.249ms  288.58ms  cudaMemcpy
                   31.32%  186.99ms         3  62.331ms  384.55us  186.22ms  cudaMalloc
                    0.14%  846.13us       404  2.0940us     147ns  99.205us  cuDeviceGetAttribute
                    0.02%  89.670us         4  22.417us  19.340us  31.136us  cuDeviceGetName
                    0.00%  28.858us         1  28.858us  28.858us  28.858us  cudaLaunchKernel
                    0.00%  12.050us         4  3.0120us     934ns  7.2250us  cuDeviceGetPCIBusId
                    0.00%  2.4420us         4     610ns     197ns  1.2220us  cudaGetLastError
                    0.00%  1.6750us         8     209ns     149ns     567ns  cuDeviceGet
                    0.00%  1.2110us         4     302ns     260ns     379ns  cuDeviceTotalMem
                    0.00%  1.1150us         3     371ns     207ns     701ns  cuDeviceGetCount
                    0.00%     792ns         4     198ns     168ns     255ns  cuDeviceGetUuid
                    0.00%     336ns         1     336ns     336ns     336ns  cuModuleGetLoadingMode
```
