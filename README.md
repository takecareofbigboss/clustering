title: "README.md"
date: 2015-05-10 13:08:43
tags:
---

##k-means/spectral clustering/normalized cut/normalized spectral clustering 算法的matlab代码 

k_means.m 是kmeans算法的代码；
load_ATT_face.m 是读取pgm图片数据的代码；
main.m 是主函数，包括PCA降维到50，以及存数成mat文件
new_index.mat 是显示结果好坏的W矩阵的变形；
norm_cut.m 是normalized cut算法的代码；
norm_spec_clust.m 是normalized spectral clustering算法的代码；
redImage.mat 是图片pca降维之后的数据；
spe_clust.m 是spectral clustering算法的代码；
sys_kmeans.m 是调用系统自带dekmeans()算法的代码；