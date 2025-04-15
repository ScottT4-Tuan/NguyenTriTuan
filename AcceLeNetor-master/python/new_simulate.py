import numpy as np
import pandas as pd
conv1_kernel_0 = np.array([
    [-73, -51, 23, -12, 27],
    [-90, 24, 23, 23, 13],
    [-71, 69, 38, 37, -5],
    [-27, 15, 32, 17, 4],
    [-18, 34, -6, -14, -35]
], dtype=np.int8)

conv1_kernel_1 = np.array([
    [14, 4, 7, -12, -16],
    [26, 9, -2, 1, -4],
    [23, 28, 6, 0, 30],
    [-6, 42, 67, 28, 6],
    [0, -6, 2, 15, 15]
], dtype=np.int8)
image = np.array([
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], #0
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], #1
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], #2
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], #3
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], #4
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 33, 116, 19, 0, 0, 0, 0, 0], #5
    [0, 0, 0, 0, 31, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 90, 19, 0, 0, 0, 0, 0, 0], #6
    [0, 0, 0, 0, 63, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 76, 105, 20, 0, 0, 0, 0, 0], #7
    [0, 0, 0, 0, 110, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 127, 81, 0, 0, 0, 0, 0, 0], #8
    [0, 0, 0, 0, 111, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 91, 127, 62, 0, 0, 0, 0, 0, 0], #9
    [0, 0, 0, 23, 122, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 99, 127, 28, 0, 0, 0, 0, 0, 0], #10
    [0, 0, 0, 60, 127, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 115, 127, 14, 0, 0, 0, 0, 0, 0], #11
    [0, 0, 0, 79, 127, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 81, 127, 108, 8, 0, 0, 0, 0, 0, 0], #12
    [0, 0, 0, 79, 127, 33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 43, 89, 124, 127, 45, 0, 0, 0, 0, 0, 0, 0], #13
    [0, 0, 0, 79, 127, 42, 0, 0, 0, 23, 24, 58, 72, 75, 120, 121, 117, 89, 120, 126, 20, 0, 0, 0, 0, 0, 0, 0], #14
    [0, 0, 0, 75, 126, 118, 103, 103, 103, 126, 127, 125, 120, 99, 71, 45, 14, 2, 116, 125, 0, 0, 0, 0, 0, 0, 0, 0], #15
    [0, 0, 0, 59, 88, 88, 88, 88, 88, 88, 49, 28, 0, 0, 0, 0, 0, 51, 127, 110, 0, 0, 0, 0, 0, 0, 0, 0], #16
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84, 127, 68, 0, 0, 0, 0, 0, 0, 0, 0], #17
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84, 127, 28, 0, 0, 0, 0, 0, 0, 0, 0], #18
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84, 127, 28, 0, 0, 0, 0, 0, 0, 0, 0], #19
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84, 127, 47, 0, 0, 0, 0, 0, 0, 0, 0], #20
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84, 127, 48, 0, 0, 0, 0, 0, 0, 0, 0], #21
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84, 127, 76, 0, 0, 0, 0, 0, 0, 0, 0], #22
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 84, 127, 76, 0, 0, 0, 0, 0, 0, 0, 0], #23
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 48, 127, 76, 0, 0, 0, 0, 0, 0, 0, 0], #24
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], #25
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], #26
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] #27
], dtype=np.int8)
# Padding ảnh
def pad_image(image):
    padded_image = np.zeros((32, 32), dtype=np.int8)
    padded_image[2:30, 2:30] = image
    return padded_image

# Convolution operation
def convolution_point(map_block, kernel, shift):
    intermediate_value = np.int32(0)  # Sử dụng np.int32 để tránh tràn số trong phép tính
    for i in range(5):
        for j in range(5):
            intermediate_value += np.int32(kernel[i, j]) * np.int32(map_block[i, j])

    # Dịch chuyển bit theo giá trị shift
    return np.int8(intermediate_value >> shift)

# Convolution layer 1
def conv_layer_1(image_padded, kernel_0, kernel_1, shift):
    featuremap = np.zeros((2, 28, 28), dtype=np.int8)
    for i in range(28):
        for j in range(28):
            # Cắt ảnh con 5x5 từ vùng ảnh
            image_sliced = image_padded[i:i+5, j:j+5]
            
            # Áp dụng convolution với kernel_0
            featuremap[0, i, j] = convolution_point(image_sliced, kernel_0, shift)
            
            # Áp dụng convolution với kernel_1
            featuremap[1, i, j] = convolution_point(image_sliced, kernel_1, shift)

    return featuremap

# Padding stage
padded_image = pad_image(image)

# Convolution 1
shift = 9  # shift bitwise (theo lý thuyết trong Verilog)
featuremap = conv_layer_1(padded_image, conv1_kernel_0, conv1_kernel_1, shift)

# Lưu featuremap vào file Excel
featuremap_df = pd.DataFrame(featuremap[0])  # Lưu featuremap đầu tiên
with pd.ExcelWriter('D:/Coding/AcceLeNetor-master/new_excel/featuremap_output.xlsx') as writer:
    featuremap_df.to_excel(writer, sheet_name='featuremap_0', index=False)

featuremap_df = pd.DataFrame(featuremap[1])  # Lưu featuremap thứ hai
with pd.ExcelWriter('D:/Coding/AcceLeNetor-master/new_excel/featuremap_output.xlsx', mode='a') as writer:
    featuremap_df.to_excel(writer, sheet_name='featuremap_1', index=False)