function sys_kmeans(image)

%load the image data matrix;
% image_tmp = load('redImage');
% image = image_tmp.redImage;

index = kmeans(image',20);
new_index = reshape(index,10,20);
save('new_index.mat','new_index');

end