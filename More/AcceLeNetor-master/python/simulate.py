import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
# Gán sẵn giá trị của kernel
conv1_kernel_0 = np.array([
    [-73, -51, 23, -12, 27],
    [-90, 24, 23, 23, 13],
    [-71, 69, 38, 37, -5],
    [-27, 15, 32, 17, 4],
    [-18, 34, -6, -14, -35]
])

conv1_kernel_1 = np.array([
    [14, 4, 7, -12, -16],
    [26, 9, -2, 1, -4],
    [23, 28, 6, 0, 30],
    [-6, 42, 67, 28, 6],
    [0, -6, 2, 15, 15]
])

conv2_kernel_0 = np.array([
    [
        [11, 27, 34, 0, -3],
        [-35, 25, 18, -11, -12],
        [8, -14, -5, 3, 22],
        [14, 2, -1, 30, 11],
        [1, -30, -39, -57, -8]
    ],
    [
        [-30, -14, 4, 16, -27],
        [-41, 0, 3, 13, 31],
        [32, 58, 69, 79, 23],
        [-18, -27, -1, -30, -91],
        [-9, 10, -29, -45, 1]
    ]
])

conv2_kernel_1 = np.array([
    [
        [41, 28, -15, -30, -12],
        [-34, -47, 28, -2, -29],
        [-37, -34, 23, 24, 12],
        [10, -20, -62, -3, 4],
        [15, 8, 6, -3, 4]
    ],
    [
        [-48, -32, -41, -43, -48],
        [-12, -59, 10, 19, 36],
        [124, 108, 47, 5, 35],
        [-50, 16, 0, 15, -11],
        [-73, -13, 14, 10, -3]
    ]
])

conv3_kernel_0 = np.array([
    [
        [-65, -15, 19, 24, 5], 
        [-29, -3, 5, -7, 17], 
        [28, 17, 20, 7, 1], 
        [12, -5, 32, -23, 13], 
        [6, -16, 7, 2, 1]
    ],
    [
        [-19, 20, 14, -36, -17], 
        [-72, 6, 22, 2, -2], 
        [-48, -4, 27, 25, -47], 
        [53, 3, -3, -17, 25], 
        [82, -20, 4, 13, 50]
    ]
])

conv3_kernel_1 = np.array([
    [
        [37, 19, -5, -14, -83], 
        [12, 12, -12, -4, -81], 
        [-50, -11, -1, 2, 54], 
        [-25, 28, 39, -1, 41], 
        [39, 37, -8, -11, -5]
    ],
    [
        [-26, -25, -12, -7, 23], 
        [21, -6, -20, 24, 13], 
        [25, 7, -14, 34, -16], 
        [-35, 26, -12, -6, 16],
        [-90, 21, 14, 43, 39]
    ]
])

conv3_kernel_2 = np.array([
    [
        [30, 42, -16, 18, -37], 
        [-16, 14, 10, -3, -43], 
        [7, 7, -11, 59, 35], 
        [9, -2, 2, 59, 17], 
        [-6, -22, -30, -4, 15]
    ],
    [
        [-2, 0, 8, 0, 15], 
        [29, 10, 11, 29, 10], 
        [-24, -6, 9, 47, -45], 
        [-7, 7, 15, -30, -35], 
        [25, -16, -34, -7, -1]
    ]
])

conv3_kernel_3 = np.array([  
    [
        [10, -16, 13, -13, -20], 
        [22, -11, 0, 1, 34], 
        [-1, -32, 1, 26, 17], 
        [-20, -9, 16, -58, -9], 
        [33, 19, 29, -7, -32]
    ],
    [
        [17, 8, 8, -40, 17], 
        [-13, 2, 16, 12, -6], 
        [-16, 0, 59, 42, 29], 
        [66, -8, -9, 19, 55], 
        [-121, -13, 11, 12, -12]
    ]
])

conv3_kernel_4 = np.array([   
    [ 
        [-8, 32, 50, 78, 50], 
        [10, 4, 5, 11, 24],
        [-25, -8, 22, -36, -45], 
        [-10, 1, 37, -24, -1], 
        [9, -11, 20, 5, -29]
    ],
    [
        [22, -15, -34, -75, -18], 
        [-21, -13, -7, 14, 73], 
        [-37, 6, 31, 50, 48], 
        [-3, 33, 5, 18, -10], 
        [-35, 23, 12, 26, -3]
    ]
])
conv3_kernel_5 = np.array([  
    [ 
        [77, 33, 23, -17, -34], 
        [45, 12, 4, -3, 8], 
        [15, -6, -9, 3, -22], 
        [0, 13, -9, -3, -2], 
        [3, -23, -23, 8, -34]
    ],
    [
        [-44, 5, 16, -3, 6], 
        [-18, 31, 12, 21, 9], 
        [61, -7, 2, 18, 37], 
        [96, 12, -13, 24, 10], 
        [84, 25, 19, 2, -21]
    ]
])
    
conv3_kernel_6 = np.array([  
    [
        [-11, -47, -24, 6, 35], 
        [-15, 17, 9, 9, 23], 
        [17, -2, -14, 58, 18], 
        [-8, 18, -6, 24, 38], 
        [30, -11, 0, 9, -9]
    ],
    [
        [44, 8, -31, -72, -37], 
        [-20, 2, -6, -11, -9], 
        [39, 13, 18, 68, 10], 
        [45, 15, 9, 22, 49], 
        [-31, -15, -11, -39, 22]
    ]
])

conv3_kernel_7 = np.array([  
    [
        [-15, -1, -41, -22, -4], 
        [-71, 4, 18, 9, 4], 
        [13, 12, 9, 7, 16], 
        [25, 3, -2, -23, -62], 
        [-2, 2, -14, 6, 33]
    ],
    [
        [10, 40, 5, 2, 35], 
        [39, 5, 8, 9, 15], 
        [-37, -27, 34, 56, -6], 
        [-23, 24, 35, 21, -42], 
        [37, 20, 27, -10, -70]
    ]
])

conv3_kernel_8 = np.array([  
    [
        [-76, -29, 15, -3, 22], 
        [-116, 2, 2, 5, -8], 
        [22, -18, 16, 13, 40], 
        [-2, -3, 10, -15, -3], 
        [18, 7, -2, 8, -5]
    ],
    [
        [57, 40, 3, -6, 30], 
        [25, 7, 10, 27, 31], 
        [6, -33, -40, -16, -32], 
        [-17, -14, -16, 0, -27],
         [-76, 9, 9, 11, -60]
    ]
])

conv3_kernel_9 = np.array([    
    [
        [43, -28, -28, -49, -24], 
        [41, -18, 17, 18, 9], 
        [-3, -14, 70, 41, 0], 
        [-19, -16, 42, -30, 1], 
        [4, -38, 44, 24, -22]
    ],
    [
        [-7, 13, 44, -36, -8], 
        [-5, -12, 11, -25, -35], 
        [-2, -12, 29, -3, -1], 
        [17, 7, 4, 4, 3], 
        [14, 27, 1, -4, -13]
    ]
])

connect_matrix = np.array([
    [-43, 49, -7, -39, 7, -8, -3, -2, 25, -24],
    [54, -18, -51, -39, 0, 19, 20, -94, 50, 74],
    [20, 42, -2, 19, -45, 24, 6, -22, -57, -3],
    [-14, -2, -32, -1, -9, 47, -13, 22, -45, 22],
    [0, -18, -5, -17, -34, -46, 64, 28, -20, 23],
    [18, -32, -34, -13, 42, 25, -7, 20, -6, -38],
    [-52, 26, 21, 9, 62, -91, 13, -14, -14, -16],
    [-32, -43, 54, 20, -5, 28, 0, -39, 27, 17],
    [7, -2, 2, 58, -14, -9, -29, 12, 11, -9],
    [27, -7, 38, -20, -11, -23, -35, 42, -31, 17]
])
#28x28 input
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
])

def convolution_1(image, kernel):
    kernel_height, kernel_width = kernel.shape
    image_height, image_width = image.shape
    image_padded = np.pad(image, pad_width=2, mode='constant', constant_values=0)
    # print(image_padded)
    image_padded_excel = pd.DataFrame(image_padded)
    with pd.ExcelWriter('D:/Coding/AcceLeNetor-master/excel/image_padded.xlsx') as writer:
     image_padded_excel.to_excel(writer, sheet_name='image_padded', index=False)

    output_height = image_padded.shape[0] - kernel_height + 1
    output_width = image_padded.shape[1] - kernel_width + 1
    output = np.zeros((output_height, output_width))

    # Duyệt qua ảnh và thực hiện phép nhân chéo với kernel
    for i in range(output_height):
        for j in range(output_width):
            region = image_padded[i:i+kernel_height, j:j+kernel_width]  # Lấy vùng con của ảnh
            output[i, j] = np.sum(region * kernel)  # Nhân từng phần tử và cộng lại

    return output

def convolution_2(featuremap, kernels):
    num_kernels, kernel_height, kernel_width = kernels.shape
    featuremap_height, featuremap_width = featuremap.shape
    output_height = featuremap_height - kernel_height + 1
    output_width = featuremap_width - kernel_width + 1
    output = np.zeros((num_kernels, output_height, output_width))

    # Duyệt qua từng kernel
    for k in range(num_kernels):
        for i in range(output_height):
            for j in range(output_width):
                region = featuremap[i:i + kernel_height, j:j + kernel_width]  # Lấy vùng con của featuremap
                output[k, i, j] = np.sum(region * kernels[k])  # Nhân từng phần tử và cộng lại

    return output

def convolution_3(image1, image2, kernels):
    num_kernels, num_channels, kernel_height, kernel_width = kernels.shape
    image_height, image_width = image1.shape  # Assume image1 and image2 have the same shape
    
    # Tạo mảng kết quả cho featuremap3
    output_height = image_height - kernel_height + 1
    output_width = image_width - kernel_width + 1
    featuremap3 = np.zeros((num_kernels, output_height, output_width))

    # Duyệt qua từng kernel
    for k in range(num_kernels):
        # Duyệt qua từng channel (2 channel input)
        for c in range(num_channels):  # Duyệt qua từng channel của kernel
            # Convolution cho từng vị trí của ảnh
            for i in range(output_height):
                for j in range(output_width):
                    # Lấy vùng con tương ứng từ image1 và image2
                    region1 = image1[i:i + kernel_height, j:j + kernel_width]
                    region2 = image2[i:i + kernel_height, j:j + kernel_width]
                    
                    # Thực hiện phép nhân với kernel và cộng kết quả từ 2 feature maps (2 channels)
                    featuremap3[k, i, j] += np.sum(region1 * kernels[k, c])  # Kernel với channel 1
                    featuremap3[k, i, j] += np.sum(region2 * kernels[k, c])  # Kernel với channel 2

    return featuremap3

def relu(featuremap):
    return np.maximum(0, featuremap)

# Lớp Pooling (Max Pooling)
def max_pooling(featuremap, pool_size=2, stride=2):
    pool_height, pool_width = pool_size, pool_size
    output_height = (featuremap.shape[0] - pool_height) // stride + 1
    output_width = (featuremap.shape[1] - pool_width) // stride + 1
    pooled_featuremap = np.zeros((output_height, output_width))
    
    for i in range(0, output_height * stride, stride):
        for j in range(0, output_width * stride, stride):
            pooled_featuremap[i // stride, j // stride] = np.max(featuremap[i:i+pool_height, j:j+pool_width])
    
    return pooled_featuremap

def fully_connect_layer(featuremap3, connect_matrix):
    # Số lượng phần tử trong featuremap3 (10 phần tử)
    num_elements = featuremap3.shape[0]
    
    # Khởi tạo output_vector
    output_vector = np.zeros(num_elements, dtype=np.int16)

    # Thực hiện phép nhân ma trận và dịch phải (shift)
    for j in range(num_elements):
        intermediate_output = 0  # Giá trị tạm thời để tính toán cho mỗi phần tử trong output_vector[j]
        
        for i in range(num_elements):
            intermediate_output += featuremap3[i] * connect_matrix[j, i]  # Phép nhân ma trận
            
        # Dịch phải (shift) với 7 bit, giống như trong Verilog
        output_vector[j] = intermediate_output / 128
    
    return output_vector
#image 
# image_excel = pd.DataFrame(image)
# Áp dụng phép nhân với cả 2 kernel
output_0 = convolution_1(image, conv1_kernel_0)
output_1 = convolution_1(image, conv1_kernel_1)
# output_0_excel = pd.DataFrame(output_0)
# output_1_excel = pd.DataFrame(output_1)

# with pd.ExcelWriter('D:/Coding/AcceLeNetor-master/excel/convolution1_results.xlsx') as writer:
#     output_0_excel.to_excel(writer, sheet_name='conv1_kernel_0', index=False)
#     output_1_excel.to_excel(writer, sheet_name='conv1_kernel_1', index=False)
# Activation 1 
output_0_relu1 = relu(output_0)
output_1_relu2 = relu(output_1)
# Max pooling 1 
output_0_pool = max_pooling(output_0_relu1)
output_1_pool = max_pooling(output_1_relu2)
output_0_excel = pd.DataFrame(output_0_pool)
output_1_excel = pd.DataFrame(output_1_pool)
with pd.ExcelWriter('D:/Coding/AcceLeNetor-master/excel/activation1_results.xlsx') as writer:
    output_0_excel.to_excel(writer, sheet_name='activation1_0', index=False)
    output_1_excel.to_excel(writer, sheet_name='activation1_1', index=False)
# # Convolution 2 
# output_0_conv2 = convolution_2(output_0_pool, conv2_kernel_0)
# output_1_conv2 = convolution_2(output_1_pool, conv2_kernel_1)

# output_0_conv2 = np.sum(output_0_conv2, axis=0)  # Tổng cho đầu vào đầu tiên
# output_1_conv2 = np.sum(output_1_conv2, axis=0)  # Tổng cho đầu vào thứ hai
# # Activation 2 
# output_0_relu2 = relu(output_0_conv2)
# output_1_relu2 = relu(output_1_conv2)
# # Max pooling 2 
# output_0_pool = max_pooling(output_0_relu2)
# output_1_pool = max_pooling(output_1_relu2)

# # Convolution 3
# kernels = np.array([conv3_kernel_0, conv3_kernel_1, conv3_kernel_2, conv3_kernel_3, 
#                     conv3_kernel_4, conv3_kernel_5, conv3_kernel_6, conv3_kernel_7, 
#                     conv3_kernel_8, conv3_kernel_9])
# output = convolution_3(output_0_pool, output_1_pool, kernels)
# # output = output.flatten()
# # Fully connect 
# output_vector = fully_connect_layer(output, connect_matrix)

#Excel 
# output_df_0_pool = pd.DataFrame(output)
# output_df_1_pool = pd.DataFrame(output_1_pool)
