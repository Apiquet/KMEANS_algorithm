%% DO NOT MODIFY THIS UNLESS YOU ARE ON YOUR OWN COMPUTER
% addpath(genpath("C:\Program Files\MATLAB\toolbox\ML_toolbox-master"))
% addpath("../check_utils_encr")

clear; 
close all; 
clc;

dataset_path = '../Data/';
rng(42);
seed = rng;

%Load picture
img = imread(strcat(dataset_path,'tiger.jpg'));
img = im2double(img);
imgSize = size(img);

%compress image with number of clusters
K = 5; init='random'; type='L2'; MaxIter = 100;
[labels, centroids] = compress_image(img,K,init,type,MaxIter);

%reconstruct image
[rimg] = reconstruct_image(labels,centroids,imgSize);

%visualizing reconstructed image
%Selecting 3, 5 and 11 clusters to see the difference
K_range=3:2:11;
K_range(3) = [];
K_range(3) = [];

% plot the original image and the compressed one side by side
figure('Name', 'Original and compressed images')
subplot(2,2,1)
imshow(img)
title('Original image')

%Compress and reconstruct image for 3, 5 and 11 clusters
for i=1:size(K_range,2)
    K = K_range(i);
    [labels, centroids] = compress_image(img,K,init,type,MaxIter);
    [rimg] = reconstruct_image(labels,centroids,imgSize);
    subplot(2,2,i+1)
    imshow(rimg)
    title(join([num2str(K) ' clusters']))
end