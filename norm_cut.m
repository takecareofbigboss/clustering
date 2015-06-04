function norm_cut()
    
%load the image data matrix;
image_tmp = load('redImage');
image = image_tmp.redImage;

%get the size
n = 20;
[M,N] = size(image);

%to construct the w_ij matrix;
theta = 0.01;
k = 8;
%----------Gaussian affinity-------------%
% for(i=1:N)
%     total_w = [];
%     total_ij = [];
%     for(j=1:N)
%         temp_w = exp(-(norm(image(:,i)-image(:,j)))^2/2*theta^2);
%         dist_ij = norm(image(:,i)-image(:,j));
%         total_w = [total_w,temp_w];
%         total_ij = [total_ij,dist_ij];
%         W(i,j) = 0;
%     end
%     [dist_sort,loc_sort] = sort(total_ij);    
%     W(i,loc_sort(1:k)) = total_w(loc_sort(1:k));
% end

%---------K-NN affinity--------------%
for(i=1:N)
    total_ij = [];
    for(j=1:N)
        dist_ij = norm(image(:,i)-image(:,j));
        total_ij = [total_ij,dist_ij];
        W(i,j) = 0;
    end
    [dist_sort,loc_sort] = sort(total_ij);    
    W(i,loc_sort(1:k)) = 1;
end

%to construct the D_ij & L matrix
one_vec = ones(N,1);
D = diag(W*one_vec);
L = D - W;

%Compute the n generalized eigenvectors of (L,D) with its n smallest eigenvalues;
[vecMix,valMix] = eigs(L,D,20,'sm');
%[sort_val sort_loc] = sort(valMix);
vecMix = vecMix(:,1:20);
vecMix = vecMix./repmat(sqrt(sum(vecMix.*vecMix)),size(vecMix,1),1);
Y = vecMix';

%using k-means to cluster the points;
k_means(Y);


end