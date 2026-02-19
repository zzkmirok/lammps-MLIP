export TORCH_PREFIX=$(python -c "import torch; print(torch.utils.cmake_prefix_path)")
export TORCH_DIR="${TORCH_PREFIX}/Torch"
export MTS_PREFIX=$(python -c "import metatensor; print(metatensor.utils.cmake_prefix_path)")
export MTS_DIR="${MTS_PREFIX}/metatensor"
export MTS_TORCH_PREFIX=$(python -c "import metatensor.torch; print(metatensor.torch.utils.cmake_prefix_path)")
export MTS_TORCH_DIR="${MTS_TORCH_PREFIX}/metatensor_torch"
export MTA_TORCH_PREFIX=$(python -c "import metatomic.torch; print(metatomic.torch.utils.cmake_prefix_path)")
export MTA_TORCH_DIR="${MTA_TORCH_PREFIX}/metatomic_torch"

export CMAKE_PREFIX_PATH="$TORCH_PREFIX;$MTS_PREFIX;$MTS_TORCH_PREFIX;$MTA_TORCH_PREFIX;$CMAKE_PREFIX_PATH"
