function k_means(image)

% %load the image data matrix;
%  image_tmp = load('redImage');
%  image = image_tmp.redImage;

%get the size
n = 20;
[M,N] = size(image);

%get the initial clusters centers;
rand_temp = [];
% for(i=1:20)
%      temp = 10*(i-1)+ceil(rand(1)*10);
%      rand_temp = [rand_temp,temp];    
% end
rand_temp = randperm(200,20);
mu0 = image(:,rand_temp);

%make the algorithm converge;
epsion = 1.0e-20;
mu1 = zeros(M,20);
iter_num = 0;
dist = max_dist(mu1,mu0);
while(iter_num<20)
    %show the converge trends;
     iter_num = iter_num + 1;    
     str = sprintf('迭代次数为%d次',iter_num);
     disp(str); 
     str1 = sprintf('迭代后剩余量%f',max_dist(mu1,mu0));
     disp(str1);
    
    %algorithm part;
    mu1 = mu0;
    w0 = find_min(image,mu0);
    mu0 = get_mu(w0,image);
    %dist = max_dist(mu1,mu0);
end
    disp(max_dist(mu1,mu0)); %from here, we know that it converges for 4 times;
    
    % to match every cluster centers with 10-nn points;
    index = [];
    for(j=1:200)
        index_tmp = find(w0(:,j)~=0);
        index = [index,index_tmp];
    end
    new_index = reshape(index,10,20);
    save('new_index.mat','new_index');
    a = 2;
    %to calculate the clustering rate;
    


    
    
    
    
    %find whether x_i belongs to cluster mu_l,and get w_ij
    function w_org = find_min(image_org,mu_org)
        for(j=1:200)
            temp_total = [];
            for(i=1:20)
                temp_mu = (norm(image_org(:,j)-mu_org(:,i),2))^2;
                temp_total = [temp_total,temp_mu];
                w_org(i,j) = 0;
            end
            [~,min_n] = min(temp_total);
            w_org(min_n,j) = 1;
            temp_total = [];
        end
    end

    %calculate the distance between all cluster centers,and get the max;
    function max_tmp = max_dist(mu1,mu0)
        total_dist = [];
        for(i=1:20)
            tmp_dist = norm(mu1(i)-mu0(i),2);
            total_dist = [total_dist,tmp_dist];
        end       
        max_tmp = max(total_dist);
        total_dist = [];
    end

    %update the mu0;
    function mu = get_mu(w,image)
        for(i=1:20)
            sum_val = zeros(M,1);
            for(j=1:200)
                tmp_sum = w(i,j)*image(:,j);
                sum_val = sum_val + tmp_sum;                
            end
            mu(:,i) = sum_val/sum(w(i,:));
        end
    end
    

end