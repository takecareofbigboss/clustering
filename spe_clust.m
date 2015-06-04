function spe_clust()

%load the image data matrix;
image_tmp = load('redImage');
image = image_tmp.redImage;

%get the size
n = 20;
[M,N] = size(image);

%to construct the w_ij matrix;
theta = 2;
k = 8;
epsion = 1.0;

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

%------------------------K-NN affinity--------------%
% for(i=1:N)
%     total_ij = [];
%     for(j=1:N)
%         dist_ij = norm(image(:,i)-image(:,j));
%         total_ij = [total_ij,dist_ij];
%         W(i,j) = 0;
%     end
%     [dist_sort,loc_sort] = sort(total_ij);    
%     W(i,loc_sort(1:k)) = 1;
% end

%-----------theta-neighborhood affinity---------------%
for(i=1:N)
    total_ij = [];
    for(j=1:N)
        dist_ij = norm(image(:,i)-image(:,j));
        W(i,j) = 0;
        if(dist_ij<=epsion)
            total_ij = [total_ij,dist_ij];
            W(i,j) = 1;
        end        
    end
end

%to construct the D_ij & L matrix
one_vec = ones(N,1);
D = diag(W*one_vec);
L = D - W;

%Compute the n eigenvectors of L with its n smallest eigenvalues;

[vecL val] = eigs(L,200);
total_tmp = [];
for(i=1:200)
    val_tmp = val(i,i);
    total_tmp = [total_tmp,val_tmp];
end
[sort_val sort_loc] = sort(total_tmp);
vecL = vecL(:,sort_loc(1:20));
vecL = vecL./repmat(sqrt(sum(vecL.*vecL)),size(vecL,1),1);
Y = vecL';

%using k-means to cluster the points;
sys_kmeans(Y);


end