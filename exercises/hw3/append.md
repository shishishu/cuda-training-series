# vector_add.cu
- blocks = 1, threads = 1
```
==2506505== Profiling application: ./vector_add
==2506505== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   96.47%  2.38492s         1  2.38492s  2.38492s  2.38492s  vadd(float const *, float const *, float*, int)
                    2.33%  57.489ms         2  28.745ms  28.645ms  28.844ms  [CUDA memcpy HtoD]
                    1.20%  29.757ms         1  29.757ms  29.757ms  29.757ms  [CUDA memcpy DtoH]
      API calls:   94.26%  2.47301s         3  824.34ms  28.873ms  2.41513s  cudaMemcpy
                    5.70%  149.58ms         3  49.859ms  246.91us  149.07ms  cudaMalloc
                    0.03%  833.72us       404  2.0630us     146ns  91.499us  cuDeviceGetAttribute
                    0.00%  85.918us         4  21.479us  18.170us  31.119us  cuDeviceGetName
                    0.00%  29.561us         1  29.561us  29.561us  29.561us  cudaLaunchKernel
                    0.00%  12.653us         4  3.1630us  1.3350us  7.6340us  cuDeviceGetPCIBusId
                    0.00%  2.5100us         8     313ns     144ns  1.3540us  cuDeviceGet
                    0.00%  1.8320us         4     458ns     177ns     733ns  cudaGetLastError
                    0.00%  1.1090us         3     369ns     207ns     679ns  cuDeviceGetCount
                    0.00%  1.0730us         4     268ns     193ns     406ns  cuDeviceTotalMem
                    0.00%     825ns         4     206ns     171ns     267ns  cuDeviceGetUuid
                    0.00%     381ns         1     381ns     381ns     381ns  cuModuleGetLoadingMode
```
- blocks = 1, threads = 256
```
==2512752== Profiling application: ./vector_add
==2512752== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   46.35%  60.084ms         2  30.042ms  30.011ms  30.073ms  [CUDA memcpy HtoD]
                   42.15%  54.639ms         1  54.639ms  54.639ms  54.639ms  vadd(float const *, float const *, float*, int)
                   11.51%  14.919ms         1  14.919ms  14.919ms  14.919ms  [CUDA memcpy DtoH]
      API calls:   53.71%  152.31ms         3  50.770ms  239.15us  151.82ms  cudaMalloc
                   45.94%  130.29ms         3  43.431ms  30.250ms  69.791ms  cudaMemcpy
                    0.30%  848.47us       404  2.1000us     146ns  98.484us  cuDeviceGetAttribute
                    0.03%  89.995us         4  22.498us  19.302us  31.804us  cuDeviceGetName
                    0.01%  31.440us         1  31.440us  31.440us  31.440us  cudaLaunchKernel
                    0.00%  12.388us         4  3.0970us  1.0110us  7.4940us  cuDeviceGetPCIBusId
                    0.00%  1.9370us         8     242ns     143ns     660ns  cuDeviceGet
                    0.00%  1.7580us         4     439ns     180ns     792ns  cudaGetLastError
                    0.00%  1.4600us         4     365ns     274ns     612ns  cuDeviceTotalMem
                    0.00%  1.1570us         3     385ns     208ns     698ns  cuDeviceGetCount
                    0.00%     835ns         4     208ns     178ns     273ns  cuDeviceGetUuid
                    0.00%     356ns         1     356ns     356ns     356ns  cuModuleGetLoadingMode
```
- blocks = 10, threads = 256
```
==2510660== Profiling application: ./vector_add
==2510660== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   73.64%  59.993ms         2  29.997ms  29.960ms  30.033ms  [CUDA memcpy HtoD]
                   18.29%  14.903ms         1  14.903ms  14.903ms  14.903ms  [CUDA memcpy DtoH]
                    8.07%  6.5713ms         1  6.5713ms  6.5713ms  6.5713ms  vadd(float const *, float const *, float*, int)
      API calls:   64.32%  149.85ms         3  49.950ms  246.96us  149.34ms  cudaMalloc
                   35.25%  82.118ms         3  27.373ms  21.705ms  30.213ms  cudaMemcpy
                    0.37%  855.89us       404  2.1180us     146ns  98.239us  cuDeviceGetAttribute
                    0.04%  85.585us         4  21.396us  18.668us  29.127us  cuDeviceGetName
                    0.01%  31.445us         1  31.445us  31.445us  31.445us  cudaLaunchKernel
                    0.01%  12.687us         4  3.1710us  1.1330us  7.4540us  cuDeviceGetPCIBusId
                    0.00%  1.7020us         4     425ns     168ns     850ns  cudaGetLastError
                    0.00%  1.5470us         8     193ns     138ns     492ns  cuDeviceGet
                    0.00%  1.2600us         4     315ns     270ns     429ns  cuDeviceTotalMem
                    0.00%  1.0830us         3     361ns     186ns     691ns  cuDeviceGetCount
                    0.00%     909ns         4     227ns     194ns     270ns  cuDeviceGetUuid
                    0.00%     359ns         1     359ns     359ns     359ns  cuModuleGetLoadingMode
```
- blocks = 100, threads = 256
```
==2511140== Profiling application: ./vector_add
==2511140== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   78.96%  59.962ms         2  29.981ms  29.902ms  30.060ms  [CUDA memcpy HtoD]
                   19.68%  14.946ms         1  14.946ms  14.946ms  14.946ms  [CUDA memcpy DtoH]
                    1.36%  1.0328ms         1  1.0328ms  1.0328ms  1.0328ms  vadd(float const *, float const *, float*, int)
      API calls:   67.01%  157.62ms         3  52.539ms  247.59us  157.12ms  cudaMalloc
                   32.56%  76.579ms         3  25.526ms  16.201ms  30.239ms  cudaMemcpy
                    0.37%  870.36us       404  2.1540us     144ns  98.230us  cuDeviceGetAttribute
                    0.04%  90.880us         4  22.720us  19.177us  32.188us  cuDeviceGetName
                    0.01%  30.684us         1  30.684us  30.684us  30.684us  cudaLaunchKernel
                    0.00%  11.086us         4  2.7710us     877ns  6.7670us  cuDeviceGetPCIBusId
                    0.00%  1.9130us         8     239ns     147ns     617ns  cuDeviceGet
                    0.00%  1.7310us         4     432ns     172ns     923ns  cudaGetLastError
                    0.00%  1.4470us         4     361ns     249ns     524ns  cuDeviceTotalMem
                    0.00%  1.2950us         3     431ns     227ns     786ns  cuDeviceGetCount
                    0.00%     836ns         4     209ns     181ns     262ns  cuDeviceGetUuid
                    0.00%     445ns         1     445ns     445ns     445ns  cuModuleGetLoadingMode
```
- blocks = 100, threads = 1024
```
==2506956== Profiling application: ./vector_add
==2506956== Profiling result:
            Type  Time(%)      Time     Calls       Avg       Min       Max  Name
 GPU activities:   65.42%  56.173ms         2  28.087ms  28.026ms  28.147ms  [CUDA memcpy HtoD]
                   33.89%  29.103ms         1  29.103ms  29.103ms  29.103ms  [CUDA memcpy DtoH]
                    0.68%  587.32us         1  587.32us  587.32us  587.32us  vadd(float const *, float const *, float*, int)
      API calls:   62.88%  148.54ms         3  49.514ms  238.14us  148.05ms  cudaMalloc
                   36.70%  86.695ms         3  28.898ms  28.249ms  30.133ms  cudaMemcpy
                    0.37%  865.63us       404  2.1420us     143ns  98.560us  cuDeviceGetAttribute
                    0.04%  84.728us         4  21.182us  18.215us  28.690us  cuDeviceGetName
                    0.01%  30.933us         1  30.933us  30.933us  30.933us  cudaLaunchKernel
                    0.01%  11.818us         4  2.9540us     943ns  7.8130us  cuDeviceGetPCIBusId
                    0.00%  1.7790us         8     222ns     147ns     600ns  cuDeviceGet
                    0.00%  1.3770us         4     344ns     199ns     671ns  cudaGetLastError
                    0.00%  1.0250us         3     341ns     188ns     600ns  cuDeviceGetCount
                    0.00%  1.0080us         4     252ns     209ns     343ns  cuDeviceTotalMem
                    0.00%     857ns         4     214ns     174ns     246ns  cuDeviceGetUuid
                    0.00%     348ns         1     348ns     348ns     348ns  cuModuleGetLoadingMode
```
