import re
import numpy as np
from pathlib import Path
import matplotlib.pyplot as plt

file_path = Path("d:/Coding/AcceLeNetor-master/test_images/test_image_4_8bits.sv")
with file_path.open() as f:
    content = f.read()

# Regex lấy pixel
pattern = r'image\s*\[\d+\]\[\d+\]\s*=\s*(-?\d+)\s*;'
pixels = list(map(int, re.findall(pattern, content)))

# Chuyển thành mảng 28x28
image_array = np.array(pixels).reshape((32, 32))

# Vẽ ảnh, không trục, không viền, không title
plt.imshow(image_array, cmap='gray', interpolation='nearest')
plt.axis('off')

# ✅ Lưu ảnh 28x28 đúng kích thước, không dư viền trắng
plt.subplots_adjust(left=0, right=1, top=1, bottom=0)
plt.gca().xaxis.set_visible(False)
plt.gca().yaxis.set_visible(False)
plt.savefig("d:/Coding/AcceLeNetor-master/image_clean.png", dpi=28, bbox_inches='tight', pad_inches=0)

plt.close()
