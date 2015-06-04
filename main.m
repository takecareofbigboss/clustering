function main
clc;
close all;
clear all;

%load the image and save it as a mat file;
image = [];
image_tmp = [];
for i=1:20
    for j=1:10
        image_tmp = load_ATT_face(i,j);
        image_tmp = double(image_tmp(:));
        image = [image,image_tmp];
    end
end
image_tmp = [];

% %apply PCA algorithm to reduce the dimension to d=50;
% image = image./repmat(sqrt(sum(image.*image)),size(image,1),1);%normalize the image;
% image = image - repmat(mean(image,2),1,size(image,2));
% [vecImage ~] = eigs(image*image',50);
% redImage = vecImage'*image;%thus,redImage is the final dim-reduced data matrix;
% save('redImage.mat','redImage');

%system PCA functions;
[COEFF, SCORE, LATENT, TSQUARED] = pca(image','NumComponents',50);
%redImage = SCORE'*image;
redImage = SCORE;
redImage = redImage';
redImage = redImage./repmat(sqrt(sum(redImage.*redImage)),size(redImage,1),1);%normalize the image;
save('redImage.mat','redImage');

%using k-means to realize the algorithm;
load('redImage.mat');
sys_kmeans(redImage);

%using spectral clustering to realize the algorithm;
%spe_clust(redImage);



end