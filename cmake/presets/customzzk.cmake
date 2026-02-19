# ==============================================================================
# LAMMPS Ultimate Preset: H100 (Hopper) + Sapphire Rapids (SPR)
# Features: Kokkos-CUDA, Custom PLUMED 2.10.0, Metatomic-ML, and Full RPATH
# ==============================================================================

# --- 1. 编译器与基础优化 ---
set(CMAKE_BUILD_TYPE "Release" CACHE STRING "" FORCE)
set(CMAKE_CXX_STANDARD 17 CACHE STRING "" FORCE)
set(BUILD_MPI ON CACHE BOOL "" FORCE)
set(BUILD_OMP ON CACHE BOOL "" FORCE)
# 核心：使用 nvcc_wrapper 协调 CUDA 和 C++ 编译
get_filename_component(NVCC_WRAPPER_CMD ${CMAKE_CURRENT_SOURCE_DIR}/../lib/kokkos/bin/nvcc_wrapper ABSOLUTE)
set(CMAKE_CXX_COMPILER ${NVCC_WRAPPER_CMD} CACHE FILEPATH "" FORCE)

# CPU 端指令集优化 (针对 Sapphire Rapids)
set(CMAKE_CXX_FLAGS "-O3 -march=sapphirerapids" CACHE STRING "" FORCE)

# --- 2. KOKKOS 硬件加速 (H100 & SPR) ---
set(PKG_KOKKOS ON CACHE BOOL "" FORCE)
set(Kokkos_ENABLE_CUDA ON CACHE BOOL "" FORCE)
set(Kokkos_ENABLE_OPENMP ON CACHE BOOL "" FORCE)

# 架构设置：完美匹配 RWTH 节点
set(Kokkos_ARCH_HOPPER90 ON CACHE BOOL "" FORCE) # H100 GPU (SM 9.0)
set(Kokkos_ARCH_SPR ON CACHE BOOL "" FORCE)      # Sapphire Rapids CPU

# FFT 引擎：强制使用 GPU CUFFT 加速
set(FFT_KOKKOS "CUFFT" CACHE STRING "" FORCE)

# --- 3. 外部插件集成 (PLUMED & Metatomic) ---
# 链接你的自定义 PLUMED 2.10.0
set(PKG_PLUMED ON CACHE BOOL "" FORCE)
set(PLUMED_MODE "shared" CACHE STRING "" FORCE)
set(PLUMED_LIBRARY "$ENV{MY_PLUMED_PATH}/lib/libplumed.so" CACHE FILEPATH "" FORCE)
set(PLUMED_INCLUDE_DIR "$ENV{MY_PLUMED_PATH}/include" CACHE PATH "" FORCE)

# 集成 Metatomic：使用本地已安装版本，禁止自动下载
set(PKG_ML-METATOMIC ON CACHE BOOL "" FORCE)
set(DOWNLOAD_METATENSOR OFF CACHE BOOL "" FORCE)
set(DOWNLOAD_METATOMIC OFF CACHE BOOL "" FORCE)
set(Torch_DIR "$ENV{TORCH_DIR}" CACHE STRING "" FORCE)
set(metatensor_torch_DIR "$ENV{MTS_TORCH_DIR}" CACHE STRING "" FORCE)
set(metatensor_DIR "$ENV{MTS_DIR}" CACHE STRING "" FORCE)
set(metatomic_torch_DIR "$ENV{MTA_TORCH_DIR}" CACHE STRING "" FORCE)

# --- 4. RPATH 运行路径配置 (全 5 路径导航) ---
set(LAMMPS_INSTALL_RPATH ON CACHE BOOL "" FORCE)
# set(CMAKE_INSTALL_RPATH "$ENV{MY_PLUMED_PATH}/lib"
#     "$ENV{TORCH_PREFIX}/lib"
#     "$ENV{MTS_PREFIX}/lib"
#     "$ENV{MTS_TORCH_PREFIX}/lib"
#     "$ENV{MTA_TORCH_PREFIX}/lib"
#     CACHE STRING "" FORCE
# )
set(CMAKE_BUILD_WITH_INSTALL_RPATH ON CACHE BOOL "" FORCE)

# --- 5. 常用物理包补齐 (参考系统版) ---
set(PKG_MANYBODY ON CACHE BOOL "" FORCE)
set(PKG_KSPACE ON CACHE BOOL "" FORCE)
set(PKG_MOLECULE ON CACHE BOOL "" FORCE)
set(PKG_RIGID ON CACHE BOOL "" FORCE)
set(PKG_REAXFF ON CACHE BOOL "" FORCE)
set(PKG_PYTHON ON CACHE BOOL "" FORCE)
set(PKG_VORONOI ON CACHE BOOL "" FORCE)

# 压缩与 I/O 支持
set(WITH_GZIP ON CACHE BOOL "" FORCE)
set(WITH_PNG ON CACHE BOOL "" FORCE)
set(WITH_JPEG ON CACHE BOOL "" FORCE)
