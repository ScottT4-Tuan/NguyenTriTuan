import re
import numpy as np
from pathlib import Path

# Load kernel file
path = Path("kernal_trained/kernel_and_matrix_8bits.sv")
content = path.read_text()

# Dùng regex để lấy giá trị của conv1_kernel
pattern = r'conv1_kernel\[(\d+)\]\[(\d+)\]\[(\d+)\]\s*=\s*(-?\d+)\s*;'
matches = re.findall(pattern, content)

# Chuẩn bị mảng kernel 2 bộ lọc, 5x5
kernels = np.zeros((2, 5, 5), dtype=int)

# Đổ dữ liệu vào
for k, i, j, val in matches:
    kernels[int(k)][int(i)][int(j)] = int(val)

# Hiển thị từng kernel
for idx, kernel in enumerate(kernels):
    print(f"\nKernel {idx} (5x5):")
    for row in kernel:
        print(" ".join(f"{val:6d}" for val in row))
